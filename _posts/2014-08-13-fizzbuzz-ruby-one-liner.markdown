---
layout: post
status: publish
published: true
title: FizzBuzz Ruby One-liner
author: Topher
date: '2014-08-13 13:29:54 -0700'
categories:
- Code
tags:
- Ruby
---

Everyone loves FizzBuzz and I love how expressive Ruby is, so here's FizzBuzz as Ruby One-liner:


```ruby
(1..100).map {|e| (e % 15).zero? ? "FizzBuzz": (e % 3).zero? ? "Fizz" : (e % 5).zero? ? "Buzz": e }.each {|e| puts e }
```


A more width-efficient version, but still elegant.

```ruby

(1..100).map do |elem|
  puts 'FizzBuzz' if (elem % 15).zero?
  puts 'Fizz' if (elem % 3).zero?
  puts 'Buzz' if (elem % 5).zero?
  puts elem
end

```
