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

> All modern browsers support and automatically negotiate gzip compression for all HTTP requests. Enabling gzip compression can reduce the size of the transferred response by up to 90%, which can significantly reduce the amount of time to download the resource, reduce data usage for the client, and improve the time to first render of your pages.

[https://developers.google.com/speed/docs/insights/EnableCompression](https://developers.google.com/speed/docs/insights/EnableCompression)

I tried (and failed) to do this with the shell commands `ls` and `gzip`. I couldn't find an elegant way to 

* List all the files recursively
* Ignore the directories

I needed a script that could do some intelligent directory traversal and then gzip the files in place.

Here's the solution I came up with

```ruby
# jekyll-gzip.rb
# Compresses all the files in a directory using gzip compression

require 'zlib'

# Get a list of files in folder, recursively
folder = '_site'

Dir[File.join(folder, '**', '*')].reject { |filename| File.directory? filename }
.each do |filename|
  old_file_text = File.read(filename)
  open(filename, 'wb') do |file|
    gzip = Zlib::GzipWriter.new(file)
    gzip << old_file_text
    gzip.close
  end
end
```

### Getting the proper file list.

The following Ruby code, using the Dir class, recursively gets a list of all the contents of a directory and returns an array of strings.

```ruby
Dir[File.join(folder, '**', '*')]
```

### Filtering out directories.

Now that we have an array of filenames as strings, we can use the File class to test if it points to a directory, and reject elements of the array that are directories.

```ruby
.reject { |filename| File.directory? filename }
```

### Gzipping the files

Now that we have an array of just filenames (free of directory names) as strings. We can use Ruby's `File` class to read the file in as a string, and use Ruby's `Zlib` module to compress the strings and write them to the opened file.

```ruby
.each do |filename|
  old_file_text = File.read(filename)
  open(filename, 'wb') do |file|
    gzip = Zlib::GzipWriter.new(file)
    gzip << old_file_text
    gzip.close
  end
end
```



