---
layout: post
title:  "Meet Guitar Bro – open source browser game that helps you learn notes on guitar"
date: 2017-07-10
published: true
---

It's always a pleasure to mix programming with something tactile and even more – with something musical. Check out my little experiment of building a browser game that helps learning notes on guitar.

<figure>
  <img src="/images/posts/guitar_bro/guitar_bro.gif" />
  <figcaption>Guitar Bro in action. <a href="https://makaroni4.github.io/guitar_bro/" target="_blank">Try it out!</a></figcaption>
</figure>

<!--more-->

## Intro

Learning notes means to be able to play any note (there are 12 of them) on any string (there are 6) without thinking. So when we started to learn notes at a guitar class the idea of Guitar Bro came pretty easy – I needed a trainer to constantly ask "Play X note on Y string" and check whether I played the correct note.

[A while ago](/ruby/hacking/2014/03/26/how-to-tune-guitar-with-ruby/) I have already experimented with notes recognition to tune a guitar – there is no magic, bear with me and I'll explain how to detect a guitar note with just a browser.

## Constraints

I wanted this project (and actually any project) to be dead simple. I needed some constraints, otherwise it's really hard to think and it's almost impossible to converge to something that can be shipped fast. These are constraints I had in mind:

1. Play only on one string. My guitar teacher introduced me a concept of "unitar" (and he was introduced to this concept by his teacher years ago). It's a general constraint to master an instrument. Probably, the very first guitar had only 1 string.

2. All calculation must happen in the browser. No fancy server setup, ideally you can open the game in your browser offline in the park and practice.

## Development

It was February back then and it took 4 month till I really started working on it. Luckily, a friend was visiting me in Berlin (I must say that many of my friends can code) and one evening we just decided to make something fun and long story short we started doing Guitar Bro.

Big inspiration came from [Google Chrome Guitar Tuner](https://github.com/GoogleChrome/guitar-tuner), we figured out about [Web Audio API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API) that allows to do so much stuff with audio in the browser, far beyond microphone access and [FFT](https://en.wikipedia.org/wiki/Fast_Fourier_transform) we needed.

The core of the game is to detect frequency and make sure it matches a note. For this we needed a list of all available frequencies on guitar:

<figure>
  <img src="/images/posts/guitar_bro/guitar_frequencies.jpg" />
  <figcaption>Frequencies of notes on guitar. <a href="http://forums.prsguitars.com/threads/best-sounding-rig-in-the-history-of-your-world.16468/page-8#post-254659">Source</a></figcaption>
</figure>

Next step was to see how FFT works in the browser, so we quickly set up a little visualisation with [d3](https://github.com/d3) and experimented with FFT attributes to find a proper resolution and maximize accuracy.

## Identifying notes

Looking at notes frequencies above we can see that the lowest distance between two guitar notes is around 5Hz, so we need our FFT Analyser to have a resolution 5Hz or lower. FFT resolution is determind via [sampling rate and FFT size](http://zone.ni.com/reference/en-XX/help/372416B-01/svtconcepts/fft_funda/) (number of samples). Default [sampling rate of Web Audio API FFT Analyser](https://developer.mozilla.org/en-US/docs/Web/API/AudioContext/sampleRate) is 44100Hz and [FFT size](https://developer.mozilla.org/en-US/docs/Web/API/AnalyserNode/fftSize) is always a power of 2 (from 32 to 32768). So if we set FFT size to 8192 we'll get frequency resolution of `44100 / 8192 =~ 5.4Hz` which should be enough for our purposes.

To make sure it works we set up a quick d3 visualisation for FFT output:

<figure>
  <img src="/images/posts/guitar_bro/notes_fft_d3_raw.jpg" />
  <figcaption>FFT output when I play A-note on the E-string. Check out <a href="https://makaroni4.github.io/web_audio_fft_meets_d3/2_fft.html" target="_blank">live browser demo!</a></figcaption>
</figure>

From the notes frequencies table we see that A-note on E-string should be around 440Hz. The biggest spike is located around this frequency, but we can improve data for analysis by using [Math.pow](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/pow) function, check out how same input will look like:

<figure>
  <img src="/images/posts/guitar_bro/notes_fft_d3.jpg" />
  <figcaption>Same A-note on the E-string but with power applied. Check out <a href="https://makaroni4.github.io/web_audio_fft_meets_d3/3_guitar_notes.html" target="_blank">live browser demo!</a> My guitar is probably out of tune a bit, since the spike is slightly off center :smile:</figcaption>
</figure>

It's clear that the input was the A-note (grey lines – are notes of the first string). Easy approach to detect clear note is to calculate the area of the FFT curve around each note and compare these values. If some value is 95% higher then all the rest – it's a clear note.

If you want to play with sound analysis, [here is a repo](https://github.com/makaroni4/web_audio_fft_meets_d3) with these live visualizations of Web Audio API FFT using d3.

## Making a game

At this step it was proven that we can use just a browser (only latest Chrome, since only latest Chrome allows to configure FFT size to have proper resolution) to detect guitar notes. But when practicing guitar normally one should have a metronome on, so you practice notes and rhythm at the same time. This is how the idea of falling notes was born: we know FPS of drawing falling notes on canvas, we know distance between falling notes. It means that we can calculate time between each pair of falling notes. And it can not only be same distance (metronome mode) but only different distances (like real songs!)

It's mind blowing, how we went from little research prototype to a browser game which I do use to learn notes. There are obvioulsy many improvements that could be made to Guitar Bro – add Bass mode, Ukulele mode, add more songs but it  won't make any sense if no one will use it.

So I encourage you to [try it out](https://makaroni4.github.io/guitar_bro/) or contribute. Check out [Github repo](https://github.com/makaroni4/guitar_bro) for code or submit an issue with feature request.
