---
layout: post
title:  "Meet Guitar Bro – open source browser game that helps you learn notes on guitar"
date: 2017-07-03
published: false
---

It's always a pleasure to mix programming with something tactile and even more – with something musical. Check out my little experiment of building a browser game that helps learning notes on guitar.

<figure>
  <img src="/images/posts/guitar_bro/guitar_bro.gif" />
  <figcaption>Guitar Bro in action. <a href="https://makaroni4.github.io/guitar_bro/">Try it out!</a></figcaption>
</figure>

<!--more-->

## Intro

Learning notes means to be able to play any note (there are 12 of them) on any string (there are 6) without thinking. So when we started to learn notes at a guitar class the idea of Guitar Bro came pretty easy – I needed a trainer to constantly ask "Play X note on Y string" and check whether I played the correct note.

[A while ago](http://localhost:4000/ruby/hacking/2014/03/26/how-to-tune-guitar-with-ruby/) I have already experimented with notes recognition to tune a guitar. So I knew the project is going to be a mix of FFT and some browser technologies.

## Constraints

The main principle I always use to start something – it has to be dead simple. I needed some constraints, otherwise it's really hard to think and it's almost impossible to converge to something that can be shipped. These are constraints I had in mind:

1. Play only on one string. My guitar teacher introduced me a concept of "unitar" (and he was introduced to this concept by his teacher years ago). It's a general constraint to master an instrument. Probably, the very first guitar had only 1 string.

2. All calculation must happen in the browser. No fancy server setup, ideally you can open the game in your browser offline in the park and practice.

## Development

It was February back then and it took 4 month till I really started working on it. Luckily, a friend was visiting me in Berlin (I must say that many of my friends can code) and one evening we just decided to make something fun and long story short we started doing Guitar Bro.

Big inspiration came from [Google Chrome Guitar Tuner](https://github.com/GoogleChrome/guitar-tuner), we figured out about [Web Audio API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API) that allows to do so much stuff with audio in the browser, far beyond microphone and [FFT](https://en.wikipedia.org/wiki/Fast_Fourier_transform) we needed.

The core of the game is to detect frequency and make sure it matches a note. For this we needed a list of all available frequencies on guitar:

<figure>
  <img src="/images/posts/guitar_bro/guitar_frequencies.jpg" />
  <figcaption>Frequencies of notes on guitar. <a href="http://forums.prsguitars.com/threads/best-sounding-rig-in-the-history-of-your-world.16468/page-8#post-254659">Source</a></figcaption>
</figure>

Next step was to see how FFT works in the browser, so we quickly set up a little visualisation with [d3](https://github.com/d3) and played with some attributes to find a proper resolution and maximize accuracy.

TODO:
- GIF for intro & repo
- repo with D3 visuals
- params in FFT, resolution => Chrome only
- trying to add songs (BPM and real notes durations)
- try game, share, give feedback
- screencast
