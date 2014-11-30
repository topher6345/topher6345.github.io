---
layout: post
status: publish
published: true
title: Jekyll Build Tools Part I - Minifying Javascript
author: Topher
date: '2014-11-29 13:29:54 -0700'
categories:
- Code
tags:
- Ruby
---

# Jekyll Build Tools Part I - Minifying Javascript

I love Jekyll, a static site generator. However it does not automatically minify javascript files.

Rather than use something like `gulp.js` (which I also dig), I challenged myself to write a script in Ruby.
The result was suprisingly concise and I didn't need to add any unnecessary abstraction.

```ruby
require 'uglifier'

Dir[File.join('_site', '**', '*')].reject { |file| File.directory? file }
.each do |file|
  next unless file[/\.js/]
  compressed = Uglifier.compile(
    File.read(file)
  )
  File.open(file, 'w') { |newfile| newfile.write(compressed) }
  puts "#{file} uglified."
end
```

I was able to write the code in a functional/streaming style, emulating `gulp.js`'s streaming build principles.

The first line gets all of the files in the directory `_site`

```ruby
Dir[File.join('_site', '**', '*')].reject { |p| File.directory? p }
```
this line does two things

* Using the `Dir` class, we get an Array of all the items in the `_site` directory as Files.
* The block passed to the reject method removes the directories from the array.

Now that we have an array of files, we can uglify them by calling the `each` method on the array and passing a block.

```ruby
.each do |file|
  next unless file[/\.js/]
  compressed = Uglifier.compile(
    File.read(file)
  )
  File.open(file, 'w') { |newfile| newfile.write(compressed) }
  puts "#{file} uglified."
end
```

The first line moves to the next item if the file does not have the .js extension.
It does this by using the `[]` regex method on the file object. If there is no match, then the method returns nil, which evaluates to false and moves to the next element in the array.

The next 3 lines call the `Uglifier.compile` method on a file read as a string. 

Then we use Ruby's `File` class to open the file and write the compressed string.



