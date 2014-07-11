---
layout: post
status: publish
published: true
title: Exporting Quicktime Movies with Processing - Part II
author:
  display_name: Topher
  login: admin
  email: csaunders@berklee.net
  url: http://www.tophersaunders.com
author_login: admin
author_email: csaunders@berklee.net
author_url: http://www.tophersaunders.com
excerpt: "[caption id=\"attachment_1123\" align=\"aligncenter\" width=\"320\"]<a href=\"http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-9.11.09-PM.png\"><img
  class=\"size-full wp-image-1123\" title=\"Screen Shot 2012-10-20 at 9.11.09 PM\"
  src=\"http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-9.11.09-PM.png\"
  alt=\"\" width=\"320\" height=\"241\" &#47;><&#47;a> A video clip made with Processing
  using the Quicktime template[&#47;caption]\r\n\r\nIn my last post, I showed you
  how to setup a template in Processing for making quicktime movies.\r\n\r\nIn this
  tutorial, I'll show you how to make a movie with the template - 4 squares that grow
  in size, overlap in a cool way, and with ghosting.\r\n\r\n"
wordpress_id: 1121
wordpress_url: http://www.tophersaunders.com/wp/?p=1121
date: '2012-10-20 22:15:36 -0700'
date_gmt: '2012-10-21 02:15:36 -0700'
categories:
- Video
- Code
- Graphics
tags:
- Processing
---
<p>[caption id="attachment_1123" align="aligncenter" width="320"]<a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-9.11.09-PM.png"><img class="size-full wp-image-1123" title="Screen Shot 2012-10-20 at 9.11.09 PM" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-9.11.09-PM.png" alt="" width="320" height="241" &#47;><&#47;a> A video clip made with Processing using the Quicktime template[&#47;caption]</p>
<p>In my last post, I showed you how to setup a template in Processing for making quicktime movies.</p>
<p>In this tutorial, I'll show you how to make a movie with the template - 4 squares that grow in size, overlap in a cool way, and with ghosting.</p>
<p><a id="more"></a><a id="more-1121"></a><br />
squares.pde</p>
<p>[code gutter="true" lang="cpp" collapse="true"]<br />
import processing.video.*;<br />
MovieMaker mm;</p>
<p>final boolean makeMovie = false;<br />
final String  movieName = "rectangleous.mov";<br />
final int   myFrameRate = 30;</p>
<p>int i=0;</p>
<p>void setup(){</p>
<p>  background(255);<br />
  size (320, 240);<br />
  if(makeMovie){<br />
    mm = new MovieMaker(this,<br />
                       width,<br />
                      height,<br />
                   movieName,<br />
                 myFrameRate,<br />
             MovieMaker.H263,<br />
             MovieMaker.HIGH);<br />
  }</p>
<p>}</p>
<p>void draw() {</p>
<p>fill(255, 255, 255, 10);<br />
rectMode(CENTER);<br />
&#47;&#47;Background-for ghosting<br />
rect((width&#47;2)-5,&#47;&#47;x origin<br />
    (height&#47;2)-5,&#47;&#47;y origin<br />
        width+15,&#47;&#47; x size<br />
      height+15);&#47;&#47; y size</p>
<p>i++;</p>
<p>stroke(0);<br />
strokeWeight(1);</p>
<p>noFill();</p>
<p> rect(width&#47;2,&#47;&#47;x origin<br />
     height&#47;2,&#47;&#47;y origin<br />
         i,i);&#47;&#47;x&amp;y size</p>
<p> rect(width&#47;4,&#47;&#47;x origin<br />
     height&#47;2,&#47;&#47;y origin<br />
         i,i);&#47;&#47;x&amp;y size</p>
<p>rect(width*3&#47;4,&#47;&#47;x origin<br />
      height&#47;2,&#47;&#47;y origin<br />
          i,i);&#47;&#47;x&amp;y size</p>
<p>  rect(width&#47;2,&#47;&#47;x origin<br />
    height*3&#47;4,&#47;&#47;y origin<br />
          i,i);&#47;&#47;x&amp;y size</p>
<p>  rect(width&#47;2,&#47;&#47;x origin<br />
      height&#47;4,&#47;&#47;y origin<br />
          i,i); &#47;&#47;x&amp;y size</p>
<p>if(makeMovie) mm.addFrame();<br />
}</p>
<p>void keyPressed() {<br />
    if (key == ' ') {<br />
      if(makeMovie) mm.finish();<br />
    }<br />
}<br />
[&#47;code]</p>
<p>The code above is built on top of the tutorial <a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;?p=1081" target="_blank">Using Processing to Make Video Clips Part I &ndash; Quicktime Template<&#47;a></p>
<p>Lets first look at the template from last time.</p>
<p>quicktimeTemplate.pde</p>
<p>[code gutter="true" lang="cpp" collapse="true" highlight="20"]<br />
import processing.video.*;</p>
<p>MovieMaker mm;  &#47;&#47; Declare MovieMaker object</p>
<p>void setup() {<br />
  size(320, 240);<br />
  &#47;&#47; Create MovieMaker object with size, filename,<br />
  mm = new MovieMaker(this,<br />
                     width, &#47;&#47;size x<br />
                    height, &#47;&#47;size y<br />
             "drawing.mov", &#47;&#47;name of movie<br />
                        30, &#47;&#47;frame rate<br />
           MovieMaker.H263, &#47;&#47;codec<br />
           MovieMaker.HIGH);&#47;&#47;quality</p>
<p>background(204);<br />
}</p>
<p>void draw() {<br />
  ellipse(mouseX, mouseY, 20, 20);<br />
  mm.addFrame();  &#47;&#47; Add window's pixels to movie<br />
}</p>
<p>void keyPressed() {<br />
    if (key == ' ')&#47;&#47;If Spacebar Pressed..<br />
    {<br />
       mm.finish();  &#47;&#47; Close Movie.<br />
    }<br />
}<br />
[&#47;code]</p>
<p>I've highlighted line 20 here because that's the place in the code where we'd place our drawing code.</p>
<p>Let me start by discussing a way I've made the template more robust for debugging sketches</p>
<p>Say we want to debug the drawing algorithm, and we want to test our sketch without making a movie. Normall we'd have to comment out the highlighted lines of code like so.</p>
<p>[code gutter="true" lang="cpp" collapse="true" highlight="8,9,10,11,12,13,14,21,27"]<br />
import processing.video.*;</p>
<p>MovieMaker mm;  &#47;&#47; Declare MovieMaker object</p>
<p>void setup() {<br />
  size(320, 240);<br />
  &#47;&#47; Create MovieMaker object with size, filename,<br />
  &#47;&#47;mm = new MovieMaker(this,<br />
  &#47;&#47;                   width, &#47;&#47;size x<br />
  &#47;&#47;                  height, &#47;&#47;size y<br />
  &#47;&#47;           "drawing.mov", &#47;&#47;name of movie<br />
  &#47;&#47;                      30, &#47;&#47;frame rate<br />
  &#47;&#47;         MovieMaker.H263, &#47;&#47;codec<br />
  &#47;&#47;         MovieMaker.HIGH);&#47;&#47;quality</p>
<p>background(204);<br />
}</p>
<p>void draw() {<br />
  ellipse(mouseX, mouseY, 20, 20);<br />
  &#47;&#47;mm.addFrame();  &#47;&#47; Add window's pixels to movie<br />
}</p>
<p>void keyPressed() {<br />
    if (key == ' ')&#47;&#47;If Spacebar Pressed..<br />
    {<br />
    &#47;&#47;   mm.finish();  &#47;&#47; Close Movie.<br />
    }<br />
}<br />
[&#47;code]</p>
<p>We can do this an easier way by creating a global boolean variable that will allow us to "comment out" all these lines in a self documenting way</p>
<p>in squares.pde</p>
<p>[code gutter="true" lang="cpp" highlight="4"]<br />
import processing.video.*;<br />
MovieMaker mm;</p>
<p>final boolean makeMovie = false;<br />
final String  movieName = "rectangleous.mov";<br />
final int   myFrameRate = 30;<br />
[&#47;code]</p>
<p>Line 4 we declare a boolean called <em>makeMovie<&#47;em>. We use the keyword <em>final<&#47;em> to indicate that this value will not change throughout the duration of the sketch, even if we do so accidentally.</p>
<p>The following lines ask this boolean if its true or false. If it's false, then we don't utilize those lines, we don't output a movie and we get to debug our sketch in peace without filling our harddrive with scratch movies.</p>
<p>squares.pde</p>
<p>[code gutter="true" lang="cpp" collapse="true" highlight="14,15,16,17,18,19,20,21,22,62,68"]<br />
import processing.video.*;<br />
MovieMaker mm;</p>
<p>final boolean makeMovie = false;<br />
final String  movieName = "rectangleous.mov";<br />
final int   myFrameRate = 30;</p>
<p>int i=0;</p>
<p>void setup(){</p>
<p>  background(255);<br />
  size (320, 240);<br />
  if(makeMovie){<br />
    mm = new MovieMaker(this,<br />
                       width,<br />
                      height,<br />
                   movieName,<br />
                 myFrameRate,<br />
             MovieMaker.H263,<br />
             MovieMaker.HIGH);<br />
  }</p>
<p>}</p>
<p>void draw() {</p>
<p>fill(255, 255, 255, 10);<br />
rectMode(CENTER);<br />
&#47;&#47;Background-for ghosting<br />
rect((width&#47;2)-5,&#47;&#47;x origin<br />
    (height&#47;2)-5,&#47;&#47;y origin<br />
        width+15,&#47;&#47; x size<br />
      height+15);&#47;&#47; y size</p>
<p>i++;</p>
<p>stroke(0);<br />
strokeWeight(1);</p>
<p>noFill();</p>
<p> rect(width&#47;2,&#47;&#47;x origin<br />
     height&#47;2,&#47;&#47;y origin<br />
         i,i);&#47;&#47;x&amp;y size</p>
<p> rect(width&#47;4,&#47;&#47;x origin<br />
     height&#47;2,&#47;&#47;y origin<br />
         i,i);&#47;&#47;x&amp;y size</p>
<p>rect(width*3&#47;4,&#47;&#47;x origin<br />
      height&#47;2,&#47;&#47;y origin<br />
          i,i);&#47;&#47;x&amp;y size</p>
<p>  rect(width&#47;2,&#47;&#47;x origin<br />
    height*3&#47;4,&#47;&#47;y origin<br />
          i,i);&#47;&#47;x&amp;y size</p>
<p>  rect(width&#47;2,&#47;&#47;x origin<br />
      height&#47;4,&#47;&#47;y origin<br />
          i,i); &#47;&#47;x&amp;y size</p>
<p>if(makeMovie) mm.addFrame();<br />
}</p>
<p>void keyPressed() {<br />
    if (key == ' ') {<br />
      if(makeMovie) mm.finish();<br />
    }<br />
}<br />
[&#47;code]</p>
<p>lines 5 and 6 let us set common movie parameters without having to dig through the constructor arguments.</p>
<p>[code gutter="true" lang="cpp" highlight="5,6"]<br />
import processing.video.*;<br />
MovieMaker mm;</p>
<p>final boolean makeMovie = false;<br />
final String  movieName = "rectangleous.mov";<br />
final int   myFrameRate = 30;<br />
[&#47;code]</p>
<p>Now that this subtle difference is made clear, we will discuss the drawing algorithm, starting with the cool "ghosting" effect that leaves trails.</p>
<p>squares.pde</p>
<p>[code gutter="true" lang="cpp" collapse="true" highlight="31,32,33,34"]<br />
import processing.video.*;<br />
MovieMaker mm;</p>
<p>final boolean makeMovie = false;<br />
final String  movieName = "rectangleous.mov";<br />
final int   myFrameRate = 30;</p>
<p>int i=0;</p>
<p>void setup(){</p>
<p>  background(255);<br />
  size (320, 240);<br />
  if(makeMovie){<br />
    mm = new MovieMaker(this,<br />
                       width,<br />
                      height,<br />
                   movieName,<br />
                 myFrameRate,<br />
             MovieMaker.H263,<br />
             MovieMaker.HIGH);<br />
  }</p>
<p>}</p>
<p>void draw() {</p>
<p>fill(255, 255, 255, 10);<br />
rectMode(CENTER);<br />
&#47;&#47;Background-for ghosting<br />
rect((width&#47;2)-5,&#47;&#47;x origin<br />
    (height&#47;2)-5,&#47;&#47;y origin<br />
        width+15,&#47;&#47; x size<br />
      height+15);&#47;&#47; y size</p>
<p>i++;</p>
<p>stroke(0);<br />
strokeWeight(1);</p>
<p>noFill();</p>
<p> rect(width&#47;2,&#47;&#47;x origin<br />
     height&#47;2,&#47;&#47;y origin<br />
         i,i);&#47;&#47;x&amp;y size</p>
<p> rect(width&#47;4,&#47;&#47;x origin<br />
     height&#47;2,&#47;&#47;y origin<br />
         i,i);&#47;&#47;x&amp;y size</p>
<p>rect(width*3&#47;4,&#47;&#47;x origin<br />
      height&#47;2,&#47;&#47;y origin<br />
          i,i);&#47;&#47;x&amp;y size</p>
<p>  rect(width&#47;2,&#47;&#47;x origin<br />
    height*3&#47;4,&#47;&#47;y origin<br />
          i,i);&#47;&#47;x&amp;y size</p>
<p>  rect(width&#47;2,&#47;&#47;x origin<br />
      height&#47;4,&#47;&#47;y origin<br />
          i,i); &#47;&#47;x&amp;y size</p>
<p>if(makeMovie) mm.addFrame();<br />
}</p>
<p>void keyPressed() {<br />
    if (key == ' ') {<br />
      if(makeMovie) mm.finish();<br />
    }<br />
}<br />
[&#47;code]</p>
<p>These highlighted lines draw a semi-transparent white rectangle before any other drawing that occurs in the <em>draw()<&#47;em> function. In Processing, you have to explicitly tell it to "erase" the previous frame or every frame will add to the one before it. usually you use the background() function. background() however, does not let you use the alpha channel for transparency.</p>
<p>Any drawing that occurs after the highlighted lines will be "ghosted" and leave trails - a simple trick to make your drawings more "sensual."</p>
<p>Note that we use rectMode(CENTER), meaning that the position arguments for the rect() function specify the center of the rectangle, not the upper left hand corner as is the default behavior for the rect() function.</p>
<p>This allows us to position our 5 rectangles more intuitively by specifying the point from which they grow outward.</p>
<p>[code gutter="true" lang="cpp" firstline="43"]<br />
 rect(width&#47;2,&#47;&#47;x origin<br />
     height&#47;2,&#47;&#47;y origin<br />
         i,i);&#47;&#47;x&amp;y size<br />
[&#47;code]</p>
<p>here we set the x origin to width&#47;2, i.e. the horizonal center of the screen, and height&#47;2, i.e. the vertical center of the screen, and we increment the x and y sizes together to get the effect of a growing rectangle.</p>
<p>[code gutter="true" lang="cpp" firstline="45"]<br />
 rect(width&#47;4,&#47;&#47;x origin<br />
     height&#47;2,&#47;&#47;y origin<br />
         i,i);&#47;&#47;x&amp;y size<br />
[&#47;code]</p>
<p>here the x origin is a quarter of the width, or halfway to the horizontal center of the screen, and height&#47;2, the vertical center of the screen again.</p>
<p>and so on for the placement of other rectangles...</p>
<p>[caption id="attachment_1136" align="aligncenter" width="320"]<a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-10.04.46-PM.png"><img class="size-full wp-image-1136" title="Screen Shot 2012-10-20 at 10.04.46 PM" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-10.04.46-PM.png" alt="" width="320" height="239" &#47;><&#47;a> The first couple frames of our video look like this.[&#47;caption]</p>
<p>To give these rectangles motion, we declare a global variable in the header, and then increment the value every frame, So in the first frame i=0, the second i=1, the third frame i=3 and so on. The effect is that the squares are a little bigger each frame.</p>
<p>[caption id="attachment_1137" align="aligncenter" width="322"]<a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-10.06.50-PM.png"><img class="size-full wp-image-1137" title="Screen Shot 2012-10-20 at 10.06.50 PM" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-10.06.50-PM.png" alt="" width="322" height="241" &#47;><&#47;a> As the variable i is incremented each frame, the squares grow[&#47;caption]</p>
<p>[caption id="attachment_1138" align="aligncenter" width="322"]<a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-10.07.59-PM.png"><img class="size-full wp-image-1138" title="Screen Shot 2012-10-20 at 10.07.59 PM" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-10.07.59-PM.png" alt="" width="322" height="241" &#47;><&#47;a> Because we specified noFill() on line 41, the lines of the squares overlap.[&#47;caption]</p>
<p>[caption id="attachment_1140" align="aligncenter" width="319"]<a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-10.09.34-PM.png"><img class=" wp-image-1140" title="Screen Shot 2012-10-20 at 10.09.34 PM" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-10.09.34-PM.png" alt="" width="319" height="235" &#47;><&#47;a> They continue to overlap in cool ways until...[&#47;caption]</p>
<p>[caption id="attachment_1141" align="aligncenter" width="321"]<a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-10.11.25-PM.png"><img class="size-full wp-image-1141" title="Screen Shot 2012-10-20 at 10.11.25 PM" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-10.11.25-PM.png" alt="" width="321" height="240" &#47;><&#47;a> ...they become too large for the screen. Now we can hit spacebar, which calls mm.finish() and our Quicktime .mov is ready![&#47;caption]</p>
