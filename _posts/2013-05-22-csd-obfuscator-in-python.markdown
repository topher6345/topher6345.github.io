---
layout: post
status: publish
published: true
title: Csound .csd Obfuscator in Python
author:
  display_name: Topher
  login: admin
  email: csaunders@berklee.net
  url: http://www.tophersaunders.com
author_login: admin
author_email: csaunders@berklee.net
author_url: http://www.tophersaunders.com
excerpt: "In this post I'll walk you through how I built a Csound csd obfuscator in
  Python.\r\n\r\nCheck it out on Github:\r\n\r\n<a href=\"https:&#47;&#47;github.com&#47;topher6345&#47;obfuscateorc\"
  title=\"https:&#47;&#47;github.com&#47;topher6345&#47;obfuscateorc\" target=\"_blank\"><&#47;a>\r\n"
wordpress_id: 1267
wordpress_url: http://www.tophersaunders.com/wp/?p=1267
date: '2013-05-22 02:48:47 -0700'
date_gmt: '2013-05-22 06:48:47 -0700'
categories:
- Code
tags:
- Csound
- Python
- featured
---
<p>In this post I'll walk you through how I built a Csound csd obfuscator in Python.</p>
<p>Check it out on Github:</p>
<p><a href="https:&#47;&#47;github.com&#47;topher6345&#47;obfuscateorc" title="https:&#47;&#47;github.com&#47;topher6345&#47;obfuscateorc" target="_blank"><&#47;a><br />
<a id="more"></a><a id="more-1267"></a></p>
<p>Csound is a great tool for digital synthesis. Possibly the only drawback of the language is that it offers no mechanism to hide implementation details of your sound design algorithms.</p>
<p>The below I've written in Python, I call it obfuscateorc, uses several Python standard libraries to strip comments, replace variable names with gibberish, and add all kinds of visually unappealing nonsense without altering the behavior of the Csound file. </p>
<p>[code lang="python" gutter="true" collapse="true"]<br />
#! &#47;usr&#47;bin&#47;env python<br />
from shlex import shlex<br />
import re<br />
import sys<br />
import os<br />
import string<br />
import random<br />
def random_string(n):<br />
    &amp;quot;&amp;quot;&amp;quot; Create n length random string &amp;quot;&amp;quot;&amp;quot;<br />
    code = ''.join([random.choice('abcdefghijklmnoprstuvwyxzABCDEFGHIJKLMNOPRSTUVWXYZ') for i in range(n)])<br />
    return code<br />
#print random_string(16)<br />
#print list(shlex(open(sys.argv[1]))) #Test that the file gets into the script</p>
<p>def removeComments(string):<br />
    string = re.sub(re.compile(&amp;quot;&#47;\*.*?\*&#47;&amp;quot;,re.DOTALL ) ,&amp;quot;&amp;quot; ,string)<br />
    string = re.sub(re.compile(&amp;quot;;.*?\n&amp;quot; ) ,&amp;quot;&amp;quot; ,string)<br />
    return string<br />
csd = open(sys.argv[1]).read()<br />
#print csd #Sanity Test<br />
#find a-rate variables</p>
<p>csd = removeComments(csd)<br />
#print comments</p>
<p>#print csd<br />
avarexpr = r'\ba\w+\b'           #Regex to find a-rate variables<br />
avars = re.findall(avarexpr, csd)#Apply regex<br />
avars = list(set(avars))         #Make set<br />
#print avars                      #Test<br />
for item in avars:<br />
    #print item<br />
    csd = re.sub(r'%s' % item, 'a'+random_string(16),csd)<br />
#print csd</p>
<p>ivarexpr = r'\bi\w+\b'<br />
ivars = re.findall(ivarexpr, csd)<br />
ivars = list(set(ivars))         #Make set<br />
ivars.remove('instr')<br />
#print ivars<br />
for item in ivars:<br />
    #print item<br />
    csd = re.sub(r'%s' % item, 'i'+random_string(16),csd)<br />
#print csd</p>
<p>kvarexpr = r'\bk\w+\b'<br />
kvars = re.findall(kvarexpr, csd)<br />
try:<br />
    kvars.remove('ksmps')<br />
except ValueError:<br />
    pass<br />
try:<br />
    kvars.remove('kr')<br />
except ValueError:<br />
    pass<br />
kvars = list(set(kvars))         #Make set<br />
#print kvars<br />
for item in kvars:<br />
    #print item<br />
    csd = re.sub(r'%s' % item, 'k'+random_string(16),csd)<br />
#print csd</p>
<p>gavarexpr = r'\bga\w+\b'<br />
gavars = re.findall(gavarexpr, csd)<br />
gavars = list(set(gavars))         #Make set<br />
#print gavars<br />
for item in gavars:<br />
    #print item<br />
    csd = re.sub(r'%s' % item, 'ga'+random_string(16),csd)<br />
#print csd</p>
<p>givarexpr = r'\bgi\w+\b'<br />
givars = re.findall(givarexpr, csd)<br />
givars = list(set(givars))         #Make set<br />
#print givars<br />
for item in givars:<br />
    #print item<br />
    csd = re.sub(r'%s' % item, 'gi'+random_string(16),csd)<br />
#print csd</p>
<p>gkvarexpr = r'[^\&amp;quot;]\bgk\w+\b'<br />
#gkvarexpr = r'\bgk\w+\b'<br />
gkvars = re.findall(gkvarexpr, csd)<br />
gkvars = list(set(gkvars))         #Make set<br />
#print gkvars<br />
for item in gkvars:<br />
    #print item<br />
    csd = re.sub(r'%s' % item, 'gk'+random_string(16),csd)<br />
print csd<br />
[&#47;code]</p>
