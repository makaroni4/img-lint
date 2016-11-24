---
layout: post
title:  "How to tune a guitar with Ruby and FFT"
date: 2014-03-26
categories: ruby hacking
background_image: "/images/posts/ruby_fft/top_image.png"
published: true
---

From time to time, when nobody sees me, I like to play the guitar and every time I face a challenge – how to tune it properly. And like in any other case Ruby comes to the rescue!

<!--more-->

### Run-up

Tuned classic guitar has known frequencies – 329,63[Hz](http://en.wikipedia.org/wiki/Hertz) for the open first string and [so on](http://en.wikipedia.org/wiki/Guitar_tunings#Standard). So to tune the guitar we need to know frequency shift for any string and simply fix it.

Let's start by recording the sound of the first open string.

<iframe width="100%" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/141500370&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_artwork=true"></iframe>

In .wav file we have "signal vs time" data and to look at the wave form we can use some software, like [Audacity](http://audacity.sourceforge.net/):

<img src="/images/posts/ruby_fft/guitar_audacity.png" width="600px" />

or we can plot it with Ruby and [Gnuplot](http://www.gnuplot.info/).

To obtain sound vs time data from .wav file let's use [SoX](http://sox.sourceforge.net/):

~~~bash
sox guitar_first_string.wav guitar_first_string.dat
~~~

`guitar_first_string.dat` will consist of several columns – time and volumes of every channel:

<img src="/images/posts/ruby_fft/wav_data.png" width="600px" />

<img src="/images/posts/ruby_fft/gnuplot_waveform.png" width="600px" />

You can download .dat file [from here](/images/posts/ruby_fft/guitar_first_string.dat).

Plotter code:

~~~ruby
require 'open3'

class GNUPlotter < Struct.new(:data, :params)
  def plot
    image, s = Open3.capture2("gnuplot", stdin_data: gnuplot_commands, binmode: true)
    system "open #{params[:image_name]}"
  end

  private
  def gnuplot_commands
    commands = %{
      set terminal png font "/Library/Fonts/Arial.ttf" 14
      set title "#{params[:title]}"
      set xlabel "#{params[:x_axis_title]}"
      set ylabel "#{params[:y_axis_title]}"
      set output "#{params[:image_name]}"
      set key off
      plot "-" with points
    }

    data.each do |x, y|
      commands << "#{x} #{y}\n"
    end

    commands << "e\n"
  end
end

sound_data = File.read("guitar_first_string.dat").split("\n")[2..-1].map { |row| row.split.map(&:to_f) }.
  map { |r| r.first(2) }

plot_params = {
  image_name: "plot.png",
  title: "Guitar first string sound",
  x_axis_title: "Time, s",
  y_axis_title: ".wav signal"
}

plotter = GNUPlotter.new(sound_data, plot_params)
plotter.plot
~~~

### Fast Fourier Transform

> Mathematical transformation employed to transform signals between time domain and frequency domain
> <cite>[Wikipedia](http://en.wikipedia.org/wiki/Fourier_transform)<cite>

We will use <http://www.fftw.org/> library for converting .wav file data (sound vs time) to its spectrum (magnitude vs frequency).

Now we have everything to calculate spectrum.

~~~ruby
require "fftw3"
require_relative "plotter"

def read_channel_data(filename, channel_number)
  data = File.read(filename).split("\n")[2..-1].map { |row| row.split.map(&:to_f) }
  duration = data.last[0]
  signal = data.map { |r| r[channel_number] }

  return signal, duration
end

def calculate_fft(signal, duration, max_points = 3000)
  na = NArray[signal]
  fc = FFTW3.fft(na)

  spectrum = fc.real.to_a.flatten.first(na.length / 2).first(max_points).each_with_index.map do |val, index|
    [index / duration, val.abs]
  end
end

signal, duration = read_channel_data("guitar_first_string.dat", 1)
spectrum = calculate_fft(signal, duration)

max_frequency = spectrum.sort_by(&:last).last.first.round(2)

spectrum_plot_params = {
  image_name: "spectrum.png",
  title: "First guitar string spectrum #{max_frequency}Hz",
  x_axis_title: "Frequency, Hz",
  y_axis_title: "Magnitude"
}

plotter = GNUPlotter.new(spectrum, spectrum_plot_params)
plotter.plot
~~~

And a final plot:

<img src="/images/posts/ruby_fft/spectrum.png" width="600px" />

As you can see we need to pull the string for 77.09Hz :)
