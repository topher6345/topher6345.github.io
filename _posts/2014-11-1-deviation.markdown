---
layout: post
status: publish
published: true
title: Maximum Deviation Alorithm in Ruby
author: Topher
date: '2014-11-1 13:29:54 -0700'
categories:
- Code
tags:
- Ruby
---

```ruby
class Array
  def subarrays(n)
    results = []
    lower = 0
    upper = n - 1
    until (upper == (count))
      results << self[lower..upper]
      upper += 1
      lower += 1
    end
    results
  end

  def deviation(n)
    self.subarrays(n).map { |a| a.max - a.min }.max
  end
end

[6, 9, 4, 7, 4, 1].deviation(3)
```
