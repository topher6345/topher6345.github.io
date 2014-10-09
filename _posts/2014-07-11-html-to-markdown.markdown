---
layout: post
status: publish
published: true
title: HTML to Markdown
author: Topher
date: '2014-08-13 13:29:54 -0700'
categories:
- Code
tags:
- Ruby
---

Recently I decided to migrate my Wordpress blog to Jekyll, for a number of reasons.

After hand converting some of the posts to markdown I figured there has to be a way to automate this.

I discovered the `html2markdown` gem by Mike Li, however the gem did not have a command line interface.

After I ran `gem install html2markdown` I wrote a script to convert an .html file to markdown and print to stdout.


```ruby
#!/usr/bin/env ruby
require 'html2markdown'; puts HTMLPage.new(:contents => ARGF.read).markdown
```

You would use such a script like

```
html2markdown index.html > index.md
```

This made the process of migrating some of the older posts I've made MUCH easier.

## Edit

The script is now a part of the `html2markdown` gem!

You can view the pull request here:

[https://github.com/29decibel/html2markdown/pull/8](https://github.com/29decibel/html2markdown/pull/8)