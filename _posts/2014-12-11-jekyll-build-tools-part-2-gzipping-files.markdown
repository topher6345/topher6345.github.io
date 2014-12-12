---
layout: post
status: publish
published: true
title: Jekyll Build Tools Part II - Gzipping Files
author: Topher
date: '2014-12-11 13:29:54 -0700'
categories:
- Code
tags:
- Ruby
---

# Jekyll Build Tools Part II - Gzipping files

Google's PageSpeed tool says:

> All modern browsers support and automatically negotiate gzip compression for all HTTP requests. Enabling gzip compression can reduce the size of the transferred response by up to 90%, which can significantly reduce the amount of time to download the resource, reduce data usage for the client, and improve the time to first render of your pages. See text compression with GZIP to learn more.

- https://developers.google.com/speed/docs/insights/EnableCompression

Ruby's standard library module [zlib](http://ruby-doc.org/stdlib-2.1.2/libdoc/zlib/rdoc/Zlib.html)
makes it easy to gzip your jekyll-generated static website!

Below is a ruby script that will 
```ruby
# jekyll-gzip.rb
# Compresses all the files in a directory using gzip compression

require 'zlib'

Dir[File.join('_site', '**', '*')].reject { |p| File.directory? p }
.each do |oldfile|
  old_file_text = File.read(oldfile)
  open(oldfile, 'wb') do |file|
    gzip = Zlib::GzipWriter.new(file)
    gzip << old_file_text
    gzip.close
  end
end
```

