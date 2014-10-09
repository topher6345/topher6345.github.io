---
layout: post
status: publish
published: true
title: ActiveRecord#random method
author: Topher
date: '2014-05-28 15:24:00 -0800'
categories:
- Code
---


# How to Get a Random ActiveRecord object

Simple add the following code to a new file:

```ruby
# in config/initializers/active_record_random.rb

class ActiveRecord::Base
  def self.random
    self.limit(1).offset(rand(self.count)).first
  end
end
```