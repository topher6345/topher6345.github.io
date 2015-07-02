---
layout: post
status: publish
published: true
title: Dining Philosophers in Ruby
author: Topher
date: '2015-3-20 13:29:54 -0700'
categories:
- Code
tags:
- Ruby
---


```ruby
# Dining Philosophers
#     \ # /
#    #     #
#     /#|#\
#
#  Philosophers
#     \ 0 /
#    4     1
#     /3|2\
#
#   Chopsticks
#     4 # 0
#    #     #
#     3#2#1
require 'thread'

# Hungry or meditating
class Philosopher
  def initialize(left:, right:)
    @left, @right = left, right
    loop do
      meditate
      hungry
    end
  end

  def meditate
    puts "#{self} is meditating..."
    sleep(rand 1..3)
    puts "#{self} is hungry..."
  end

  def hungry
    pick_up_chopsticks
  end

  def pick_up_chopsticks
    loop do
      @left.lock
      puts "#{self} has one chopstick..."
      break if @right.try_lock
      puts "#{self} cannot pickup second chopstick"
      @left.unlock
    end
    puts "#{self} has the second chopstick!", "#{self} eats..."
    eat
  end

  def eat
    sleep(rand 1..3)
    puts "#{self} done eating."
    @right.unlock
    @left.unlock
  end
end

chopsticks = []
5.times { chopsticks << Mutex.new }

pool = []
pool << Thread.new { Philosopher.new left: chopsticks[0], right: chopsticks[1] }
pool << Thread.new { Philosopher.new left: chopsticks[1], right: chopsticks[2] }
pool << Thread.new { Philosopher.new left: chopsticks[2], right: chopsticks[3] }
pool << Thread.new { Philosopher.new left: chopsticks[3], right: chopsticks[4] }
pool << Thread.new { Philosopher.new left: chopsticks[4], right: chopsticks[0] }
pool.each(&:join)
```
