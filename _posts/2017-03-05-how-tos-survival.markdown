---
layout: post
title:  "How-tos survival"
date: 2017-03-05
categories: ruby parsing gnuplot
published: true
---

Watching ["ReactJS Basics"](https://www.youtube.com/watch?v=JPT3bFIwJYA&list=PL55RiY5tL51oyA8euSROLjMFZbXaV7skS) course the other day I've noticed that the further I go – the smaller number of pageviews for each lesson was. But is that "dropout rate" the same for all courses? Here is my little research.

<!--more-->

## Intro

So the procedure we are going to follow is called [survival analysis](https://en.wikipedia.org/wiki/Survival_analysis). It's very well known in medicine but could be applied to many more industries as well.

<blockquote>
  <p>
    The fraction of patients living for a certain amount of time after treatment.
    <cite>by <a href="https://en.wikipedia.org/wiki/Kaplan%E2%80%93Meier_estimator">Wikipedia</a></cite>
  </p>
</blockquote>

Let's think of a brighter example for it than cancer patients. It could be a percentage of working laptops from the same batch or fraction of people who continue using your product after the first week, second week, etc.

In our research, we'll look at how many people who started online course continue with it and watch new lessons.

## Main assumption

We are going to work with Youtube data since it's open and there are plenty of interesting courses. But there is a *very important assumption* – to make a precise survival analysis we'd need to know timestamp and user id for every view of every video in the course. But since Youtube gives us only a number of pageviews per video, let's assume that all pageviews are unique and there are no users who started the course lately (we'd exclude them in real analysis).

## Getting the data

So I've picked up some courses on programming, chess, guitar, drawing, and fitness:

* [Learn to Draw](https://www.youtube.com/watch?v=ewMksAbgdBI&list=PL1HIh25sbqZnkA1T09UtVHoyjYaMJuK0a)
* [Beginner Guitar Lessons](https://www.youtube.com/watch?v=_bULnYSWNPE&list=PLiyMO_9U8g1BNzo7ZoXwKg2Pqt5chP6CT)
* [How to Play Chess](https://www.youtube.com/watch?v=wH9Z1ORrtjQ&list=PLLALQuK1NDriznzxP5rQkQwKIrGSWRMZF)
* [21-Day Summer Shape-Up Challenge](https://www.youtube.com/watch?v=-2ziPcnlndQ&list=PLI37FJmOtrj0CeeQVTqaVD6UfHSRpG6NO)
* [Machine Learning with Python](https://www.youtube.com/watch?v=OGxgnH8y2NM&list=PLQVvvaa0QuDfKTOs3Keq_kaG2P55YRn5v)
* [ReactJS + Redux Basics](https://www.youtube.com/watch?v=qrsle5quS7A&list=PL55RiY5tL51rrC3sh8qLiYHqUV3twEYU_)
* [React JS Tutorials for Beginners](https://www.youtube.com/watch?v=-AbaV3nrw6E&list=PL6gx4Cwl9DGBuKtLgPR_zWYnrwv-JllpA)

I think there is no use to share Ruby basics like looping through an array of ids and dump downloaded data to CSV, you can [check all the code yourself](https://github.com/makaroni4/youtube_survival). May be pay attention how it's organized. It's very much inspired by Jupyter Notebooks in Python: progression of steps that should be run one by one.

## Visualize survival curves

At this point, we have [pageviews for each video](https://github.com/makaroni4/youtube_survival/tree/master/pageviews_data) in selected courses. Before we start processing it, let's just plot it as it is. I think this step is very useful in any research you do.

[Gnuplot](http://www.gnuplot.info/) is pretty much a standard, so let's go with it:

<div class="two-images">
  <img src="/images/posts/youtube_survival/raw_data.png" alt="Raw Youtube Pageviews per video">

  <img src="/images/posts/youtube_survival/raw_data_no_spikes.png" alt="Youtube Pageviews with no spikes">
</div>

As you can see not every curve has downward slope – there are spikes in the middle with millions of pageviews. I guess it's very specific to Youtube when some videos became viral – just look at the title "How to Achieve Checkmate in 2 Moves". So we'll remove these points. We'd also remove pageviews when users haven't started from the beginning, but our assumption is that there are no such pageviews.

For the final plot we will calculate a portion of "survived" users for every lesson:

<img src="/images/posts/youtube_survival/survival_curves.png" alt="Youtube Pageviews Survival Curves">

As you can see it's really hard to survive singing and drawing classes online :smile: On top, we have chess and React JS – both are easy but bring you a lot of fun :beers:

P.S. All code for this post is [available on Github](https://github.com/makaroni4/youtube_survival).
