---
layout: post
title:  "translation missing: en.blog_post.title"
date: 2017-12-18
published: true
---

TL;DR Make sure you're raising an error in test and development environments if there is a translation missing. Below there are a couple of thoughts and examples.

<!--more-->

## Intro

It's 2017: we are using microservices, shipping APIs and building Progressive Web Apps. But it can't ease the pain of a real user when our web app is missing translations:

<figure>
  <img src="/images/posts/translation_missing/runtastic.png" />
  <figcaption>Runtastic</figcaption>
</figure>

<figure>
  <img src="/images/posts/translation_missing/strava.png" />
  <figcaption>Strava</figcaption>
</figure>

<figure>
  <img src="/images/posts/translation_missing/groupon.png" />
  <figcaption>Groupon</figcaption>
</figure>

You can find thousands of examples [here](https://publicwww.com/websites/translation_missing/).

## What can possibly go wrong?

The worst case – you're sending multi-language emails using your app, so your copy lives in locale files. No matter which translation is missing in this part – it will be sent to every user of your app. :boom:

## Next actions

If you're using Rails just go to your `env/test.rb` and `env/development.rb` and uncomment:

~~~ruby
config.action_view.raise_on_missing_translations = true
~~~

Merry Christmas! :santa: :christmas_tree: :gift:
