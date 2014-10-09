---
layout: post
status: publish
published: false
title: Csound .csd Obfuscator in Python
author: Topher
date: '2013-05-22 02:48:47 -0700'
categories:
- Code
tags:
- Csound
- Python
- featured
---

In this post I'll walk you through how I built a Csound csd obfuscator in Python.

[Check it out on Github ](https://github.com/topher6345/obfuscateorc)

Csound is a great tool for digital synthesis. Possibly the only drawback of the language is that it offers no mechanism to hide implementation details of your sound design algorithms.

The below I've written in Python, I call it obfuscateorc, uses several Python standard libraries to strip comments, replace variable names with gibberish, and add all kinds of visually unappealing nonsense without altering the behavior of the Csound file.

{% highlight python %}
#! /usr/bin/env python
from shlex import shlex
import re
import sys
import os
import string
import random
def random_string(n):
    &quot;&quot;&quot; Create n length random string &quot;&quot;&quot;
    code = ''.join([random.choice('abcdefghijklmnoprstuvwyxzABCDEFGHIJKLMNOPRSTUVWXYZ') for i in range(n)])
    return code
#print random_string(16)
#print list(shlex(open(sys.argv[1]))) #Test that the file gets into the script

def removeComments(string):
    string = re.sub(re.compile(&quot;/\*.*?\*/&quot;,re.DOTALL ) ,&quot;&quot; ,string)
    string = re.sub(re.compile(&quot;;.*?\n&quot; ) ,&quot;&quot; ,string)
    return string
csd = open(sys.argv[1]).read()
#print csd #Sanity Test
#find a-rate variables
csd = removeComments(csd)
#print comments
#print csd
avarexpr = r'\ba\w+\b'           #Regex to find a-rate variables
avars = re.findall(avarexpr, csd)#Apply regex
avars = list(set(avars))         #Make set
#print avars                      #Test
for item in avars:
    #print item
    csd = re.sub(r'%s' % item, 'a'+random_string(16),csd)
#print csd
ivarexpr = r'\bi\w+\b'
ivars = re.findall(ivarexpr, csd)
ivars = list(set(ivars))         #Make set
ivars.remove('instr')
#print ivars
for item in ivars:
    #print item
    csd = re.sub(r'%s' % item, 'i'+random_string(16),csd)
#print csd
kvarexpr = r'\bk\w+\b'
kvars = re.findall(kvarexpr, csd)
try:
    kvars.remove('ksmps')
except ValueError:
    pass
try:
    kvars.remove('kr')
except ValueError:
    pass
kvars = list(set(kvars))         #Make set
#print kvars
for item in kvars:
    #print item
    csd = re.sub(r'%s' % item, 'k'+random_string(16),csd)
#print csd
gavarexpr = r'\bga\w+\b'
gavars = re.findall(gavarexpr, csd)
gavars = list(set(gavars))         #Make set
#print gavars
for item in gavars:
    #print item
    csd = re.sub(r'%s' % item, 'ga'+random_string(16),csd)
#print csd
givarexpr = r'\bgi\w+\b'
givars = re.findall(givarexpr, csd)
givars = list(set(givars))         #Make set
#print givars
for item in givars:
    #print item
    csd = re.sub(r'%s' % item, 'gi'+random_string(16),csd)
#print csd
gkvarexpr = r'[^\&quot;]\bgk\w+\b'
#gkvarexpr = r'\bgk\w+\b'
gkvars = re.findall(gkvarexpr, csd)
gkvars = list(set(gkvars))         #Make set
#print gkvars
for item in gkvars:
    #print item
    csd = re.sub(r'%s' % item, 'gk'+random_string(16),csd)
print csd
{% endhighlight %}
