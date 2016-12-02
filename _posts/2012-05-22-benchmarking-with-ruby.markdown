---
layout: post
title:  "Benchmarking with Ruby"
date: 2012-05-22
categories: ruby benchmarking
published: true
---

A great technique to improve your code is using benchmarking – comparison between different solutions leads to faster and better code.

<!--more-->

Ruby already has [Benchmark module](http://ruby-doc.org/stdlib-1.9.3/libdoc/benchmark/rdoc/Benchmark.html) which can be used for measuring time of running of your code. For example lets compare string concatenation methods **+=** and **<<**:

<script src="https://gist.github.com/makaroni4/164620e5301949002317ec014c6310d2.js?file=basic_benchmark.rb"></script>

This case is great and you can see the huge difference between using **+=** and **<<** methods. But benchmark timing approach is not scientific – time depends on many params and the results will be different for each run. Good approach is to run your benchmark 'experiment' several times and than calculate average.

Take a look at #gem [benchmark_suite](https://github.com/evanphx/benchmark_suite), it is a great for benchmarking. Basically it provides extension for standart benchmark. So lets look at previous example implemented with benchmark_suite:

<script src="https://gist.github.com/makaroni4/164620e5301949002317ec014c6310d2.js?file=benchmark_with_ips.rb"></script>

Also we can run benchmark without any N specified because report blocks will be executed multiple times:

<script src="https://gist.github.com/makaroni4/164620e5301949002317ec014c6310d2.js?file=auto_benchmark_with_ips.rb"></script>

Obviously benchmark_suite takes longer time but the results are more precise. Use this technique to test your class methods, algorithms and for having fun!

Happy benchmarking!

P.S. First time I heard about benchmark_suite was at Toster conference in Moscow during the presentation by [Jon Leighton](https://github.com/jonleighton), maintainer of ActiveRecord. [Slides](http://www.slideshare.net/tosterru/presentation-11633787)
