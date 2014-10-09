---
layout: post
status: publish
published: true
title: Cantus Firmus Generator in Ruby and Clojure
author: Topher
date: '2014-08-10 13:29:54 -0700'
categories:
- Code
tags:
- Ruby
- Clojure
---

Cantus Firmus Generator
-----------------------

In this post I'll explore my personal kata in the language I use professionally, Ruby; and a language I wish I had more time to work in, Clojure.

## Ruby
### Object Oriented
```ruby
class CantusFirmus
  def initialize
    @state = 0
  end

  def tick
    case @state
    when 0 # I
      @state = (0..6).to_a.sample
    when 1 # ii
      @state = [0, 2, 3, 4].sample
    when 2 # iii
      @state =  [0, 3, 4].sample
    when 3 # IV
      @state = [0, 2, 4, 6].sample
    when 4 # V
      @state = [0, 5, 6].sample
    when 5 # vi
      @state = [0, 1, 4, 3].sample
    when 6 # viio
      @state = [0, 4].sample
    end
  end

  def print
    puts tick
  end
end
```

## Clojure
### Functional
```clojure
(defn cantus-firmus [n]
    (cond
      (= n 0) (rand-int 7); I
      (= n 1) (rand-nth [0 2 3 4 6]); ii
      (= n 2) (rand-nth [0 3 4 5]); iii
      (= n 3) (rand-nth [0 1 4]); IV
      (= n 4) (rand-nth [0 5 6]); V
      (= n 5) (rand-nth [0 3 4 6]); vi
      (= n 6) (rand-nth [0 4] )));vii

  (defn print-cantus-firmus [i n]
      (println n)
      (if (< i 0)
          nil
          (print-cantus-firmus (dec i) (cantus-firmus n))))
```
