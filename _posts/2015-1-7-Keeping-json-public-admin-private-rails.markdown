---
layout: post
status: publish
published: true
title: Public JSON API Snippet in Rails
author: Topher
date: '2015-1-7 13:29:54 -0700'
categories:
- Code
tags:
- Ruby
---

# Keeping JSON API public but Admin views private in Rails

I'm working on Rails CMS that exposes a public JSON API.

I used scaffolding to set up the `Post` model, which gives me RESTful routes for my post model.

```ruby
# app/controllers/post_controller.rb

class PostController < ApplicationController
  respond_to :html, :json

  def index
    @posts = Post.all
    respond_with(@posts)
  end
  # ...
```


I'd like to hide just the html repsonses and expose the json responses.


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
