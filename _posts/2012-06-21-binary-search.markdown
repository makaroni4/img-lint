---
layout: post
title:  "Binary search with Ruby and TDD"
date: 2012-06-21
categories: ruby binary-search TDD
published: true
---

If you have sorted array than you can search elements there easily with binary search. [An interesting fact](http://en.wikipedia.org/wiki/Binary_search_algorithm#Implementation_issues) about binary search: only 10% of students are able to implement it correctly.

<!--more-->

How does it work? Since the array is sorted (from lowest to highest) on each step we can split array in two parts and than compare middle element with element we are looking for – returning element if they coincide and calling binary search for particular half (right if mid is lower than required element and left is not).

So lets do some #TDD here and have some fun with that. When implementing [binary search](http://en.wikipedia.org/wiki/Binary_search_algorithm) we should test if for empty array, array that doesn't contains required element and some more cases. And pay attention to `self.it` method that introduces some sugar to write test cases.

~~~ruby
require 'test/unit'

class TestArrayBindex < Test::Unit::TestCase
  def self.it name, &block
    define_method("test_#{name.gsub(/\W/,'_')}", &block) if block
  end

  it 'should give same results as Array#index' do
    array = (1..100).to_a

    1.upto 100 do |i|
      assert_same array.bindex(i), array.index(i)
    end
  end

  it 'should return nil for empty array' do
    assert_same [].bindex(3), nil
  end

  it 'should return 0 for array with 1 element' do
    assert_same [3].bindex(3), 0
  end

  it 'should return right index for array with 2 elements' do
    array = [1, 2]
    assert_same array.bindex(1), 0
    assert_same array.bindex(2), 1
  end

  it 'should return nil if there is no such element in array' do
    array = (1..100).to_a
    array.delete 75

    assert_same array.bindex(0), nil
    assert_same array.bindex(101), nil
    assert_same array.bindex(75), nil
  end
end
~~~

You can simply copy this snippet and run it. You should have 5 failing tests as expected. It's time to implement our `Array#bindex` method.

~~~ruby
class Array
  def bindex element, lower = 0, upper = length - 1
    return if lower > upper
    mid = (lower + upper) / 2
    element < self[mid] ? upper = mid - 1 : lower = mid + 1
    element == self[mid] ? mid : bindex(element, lower, upper)
  end
end
~~~

As you can see it is recursive implementation of the algorithm. And thanks to TDD now we can implement it in iterative manner. But before we start working on it lets do some [benchmarking](/ruby/benchmarking/2012/05/22/benchmarking-with-ruby/). Ruby provides two methods for finding index of an element: [Array#index](http://www.ruby-doc.org/core-1.9.3/Array.html#method-i-index) and [Array#rindex](http://www.ruby-doc.org/core-1.9.3/Array.html#method-i-rindex). To get right benchmarking we should first take a look at sources of these methods. Index method simply iterates through the array and on each step compare element with required. Rindex does the same thing but it starts from the end and iterates to the beginning of the array. So because of it we will make two calls for it test – from the left part of the array and from the right:

~~~ruby
require 'benchmark/ips'
Benchmark.ips do |r|
  array = (1..100).to_a

  r.report 'binary' do
    array.bindex 25
    array.bindex 75
  end

  r.report 'rindex' do
    array.rindex 25
    array.rindex 75
  end

  r.report 'index' do
    array.index 25
    array.index 75
  end
end

# binary   624616.9 (±2.5%) i/s -    3135735 in   5.023492s
# rindex   241546.2 (±2.7%) i/s -    1218294 in   5.047591s
#  index   251110.4 (±2.7%) i/s -    1262720 in   5.032348s
~~~

As you can see rindex and index works with the same speed but binary search more than twice faster because it doesn't look at every element. OK, so lets now implement iterative version of binary search and run at versus test we have.

~~~ruby
class Array
  def iterative_bindex element, lower = 0, upper = length - 1
    while upper >= lower
      mid = (upper + lower) / 2
      if self[mid] < element
        lower = mid + 1
      elsif self[mid] > element
        upper = mid - 1
      else
        return mid
      end
    end

    return nil
  end
end
~~~

And of course we should benchmark all method together! We need just add one more block to benchmark:

~~~ruby
r.report 'iterative bindex' do
  array.iterative_bindex 25
  array.iterative_bindex 75
end

#           binary   627299.2 (±2.3%) i/s -    3159927 in   5.040178s
#           rindex   243698.5 (±2.6%) i/s -    1229886 in   5.050344s
#            index   253722.6 (±2.1%) i/s -    1274260 in   5.024520s
# iterative bindex   831047.1 (±2.8%) i/s -    4182057 in   5.036514s
~~~

Seems like iterative version is the coolest :)

[Full example source code](https://gist.github.com/2966938)
