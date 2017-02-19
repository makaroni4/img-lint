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

```ruby
require 'benchmark'

Benchmark.bm do |r|
  N = 100000

  r.report("+= ") do
    s = ""
    N.times { s += "1" }
  end

  r.report("<< ") do
    s = ""
    N.times { s << "1" }
  end
end

# =>         user           system        total         real
# => +=   1.060000   0.340000   1.400000 (  1.405588)
# => <<   0.030000   0.000000   0.030000 (  0.025614)
```

This case is great and you can see the huge difference between using **+=** and **<<** methods. But benchmark timing approach is not scientific – time depends on many params and the results will be different for each run. Good approach is to run your benchmark 'experiment' several times and than calculate average.

Take a look at #gem [benchmark_suite](https://github.com/evanphx/benchmark_suite), it is a great for benchmarking. Basically it provides extension for standart benchmark. So lets look at previous example implemented with benchmark_suite:

```ruby
require 'benchmark'
require 'benchmark/ips'

Benchmark.ips do |r|
  N = 100000

  r.report("+= ") do
    s = ""
    N.times { s += "." }
  end

  r.report("<< ") do
    s = ""
    N.times { s << "." }
  end
end

# => Calculating -
# =>                 +=          1 i/100ms
# =>                 <<          3 i/100ms
# =>-
# =>                 +=         0.2 (±0.0%) i/s -          2 in   8.508143s
# =>                 <<        33.9 (±3.0%) i/s -        171 in   5.054061s
```

Also we can run benchmark without any N specified because report blocks will be executed multiple times:

```ruby
require 'benchmark'
require 'benchmark/ips'

Benchmark.ips do |r|
  r.report("+ ") do
    42 + 42
  end

  r.report("* ") do
    42 * 42
  end
end

# =>Calculating -
# =>                  +      92249 i/100ms
# =>                  *      91950 i/100ms
# =>-
# =>                  +   6852082.4 (±6.8%) i/s -   34039881 in   4.998483s
# =>                  *   6280292.3 (±5.5%) i/s -   31263000 in   4.996057s
```

Obviously benchmark_suite takes longer time but the results are more precise. Use this technique to test your class methods, algorithms and for having fun!

Happy benchmarking!

P.S. First time I heard about benchmark_suite was at Toster conference in Moscow during the presentation by [Jon Leighton](https://github.com/jonleighton), maintainer of ActiveRecord. [Slides](http://www.slideshare.net/tosterru/presentation-11633787)
