---
layout: post
status: publish
published: true
title: Checking for Balanced Parenthesis in Ruby
author: Topher
date: '2014-10-13 13:29:54 -0700'
categories:
- Code
tags:
- Ruby
---

# Checking for Balanced Parenthesis in Ruby

While I'm not a LISP programmer to the degree I'd like to be, I was recently tasked with writing a program that checks if a string of parentheses is **balanced**.

Doing this is the lowest hanging fruit in the problem set of writing a LISP parser.

```ruby
# This method takes a string 
# and returns 0 if unbalanced
# and returns 1 if balanced

def balanced?(string)
  return 0 if closer? string[0]
  stack = ['$']
  string.split('').each do |symbol|
    if opener? symbol
      stack.push symbol
      next
    end
    if closer? symbol
      stack.pop if closes? stack.last, symbol
      next
    end
  end
  return 1 if stack == ['$']
  0
end
 
def opener?(symbol)
  ['(', '[', '{'].include? symbol
end
 
def closer?(symbol)
  [')', ']', '}'].include? symbol
end
 
def closes?(opener, closer)
  return true if opener == '(' && closer == ')'
  return true if opener == '[' && closer == ']'
  return true if opener == '{' && closer == '}'
  false
end
 
[")(){}", "[]({})", "([])", "{()[]}", "([)]"].each do |expression|
  puts balanced? expression
end
```

## The stack

The key data structure involved in solving this task is a stack.

In Ruby, the Array class can serve as our stack.

One convention I use is the string `$` at the bottom of the stack. 
