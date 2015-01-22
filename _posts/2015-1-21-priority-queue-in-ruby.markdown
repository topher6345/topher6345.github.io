---
layout: post
status: publish
published: true
title: Priority Queue in Ruby
author: Topher
date: '2015-1-21 13:29:54 -0700'
categories:
- Code
tags:
- Ruby
---

# Priority Queue

> In computer science/data structures, a priority queue is an abstract data type which is like a regular queue or stack data structure, but where additionally each element has a "priority" associated with it. In a priority queue, an element with high priority is served before an element with low priority. If two elements have the same priority, they are served according to their order in the queue.

 via [Wikipedia](http://en.wikipedia.org/wiki/Priority_queue)

I came across a data structure called a Priority Queue a while ago, and recently it proved to be useful in a real world client project. (Go figure!)

While walking through it, I thought it would be fun to implement this data structure in Ruby 2.1 using keyword arguments.

```ruby
# Requires Ruby 2.1 or greater

class PriorityQueue
  def initialize
    @stack = []
  end

  def push(item:, priority:)
    fail StandardError unless priority.is_a?(Integer) || priority.is_a?(Float)
    @stack.push(item: item, priority: priority)
  end

  def pop
    @stack.sort! do |x, y|
      x[:priority] <=> y[:priority]
    end
    @stack.pop
  end
end
```

### Constructor

The construcutor for this class is simple, just initialize an `Array` instance variable.

```ruby
  def initialize
    @stack = []
  end
```

### Push

I found great use of ruby 2.1's keyword arguments

> Ruby 2.1 introduced required keyword arguments, which are defined with a trailing colon. ...(so that) we don’t have to write the boilerplate code to extract hash options.

via Ian C. Anderson at [Thoughtbot](http://robots.thoughtbot.com/ruby-2-keyword-arguments)

```ruby
  def push(item:, priority:)
    fail StandardError unless priority.is_a?(Integer) || priority.is_a?(Float)
    @stack.push(item: item, priority: priority)
  end
```

This saves us having to use `Hash#fetch()` to ensure proper arguments are passed.

```ruby
  # in Ruby < 2.1
  # Not using keyword arguments
  def push(options= {})
    fail StandardError unless priority.is_a?(Integer) || priority.is_a?(Float)
    @stack.push(item: options.fetch(:item), priority: options.fetch(:priority))
  end
```

### Pop

```ruby
  def pop
    @stack.sort! do |x, y|
      x[:priority] <=> y[:priority]
    end
    @stack.pop
  end
```

