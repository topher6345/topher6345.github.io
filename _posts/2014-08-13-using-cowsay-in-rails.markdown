---
layout: post
status: publish
published: true
title: Using Cowsay in Rails
author: Topher
date: '2014-08-13 13:29:54 -0700'
categories:
- Code
tags:
- Ruby
---


# Using Cowsay in Rails

## Why

In my recent rails projects, I've been printing log messages in our Rails controllers using the following pattern:

``` ruby
logger.debug "--------------------------------"
logger.debug "--------------------------------"
logger.debug params.inspect
logger.debug "--------------------------------"
logger.debug "--------------------------------"
```

which makes the messages easy to read in the rails log.

This became so common, one of my coworkers made a Sublime Text 3 snippet.

## Enter Cowsay

[Cowsay](http://en.wikipedia.org/wiki/Cowsay) is a fun tool for generating ascii art.


If you want to use cowsay in your log messages just add it to your Rail's project gemfile

As of writing this article -

`gem 'ruby_cowsay', '~> 0.1.1'`

[https://rubygems.org/gems/ruby_cowsay](https://rubygems.org/gems/ruby_cowsay)

Now you will be able to write log messages like this -

```ruby
logger.debug Cow.new.think(params)
```

```
 ____________________________________
/ #<Score id: 1, patient_id: 1,      \
| day_points: 650, week_points: 650, |
| total_points: 650, created_at:     |
| "2014-08-08 19:42:31", updated_at: |
\ "2014-08-08 19:46:24">             /
 ------------------------------------
      \   ^__^
       \  (oo)\_______
          (__)\       )\/\
              ||----w |
              ||     ||
```

A little bit of fun!
