---
layout: post
status: publish
published: true
title: Keeping JSON API public but Admin views private in Rails
author: Topher
date: '2015-1-7 13:29:54 -0700'
categories:
- Code
tags:
- Ruby
---



```ruby
# app/controllers/concerns/authorize_public.rb
module AuthorizePublic
  extend ActiveSupport::Concern
  included do
    before_action :authorize
  end

  def authorize
    authenticate_user! unless request.format.to_s == 'application/json'
  end
end
```

```ruby
# app/controllers/post_controller.rb
class PostController < ApplicationController
  include AuthorizePublic
  # ...
end
```
