---
layout: post
status: publish
published: true
title: Exporting Quicktime Movies with Processing - Part I
author:
  display_name: Topher
  login: admin
  email: csaunders@berklee.net
  url: http://www.tophersaunders.com
author_login: admin
author_email: csaunders@berklee.net
author_url: http://www.tophersaunders.com
excerpt: "In this tutorial, I'll show you a template for making 2D quicktime movies
  with <a href=\"http:&#47;&#47;processing.org&#47;\" target=\"_blank\">Processing<&#47;a>.\r\n\r\n[caption
  id=\"attachment_1083\" align=\"aligncenter\" width=\"323\"]<a href=\"http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-7.49.48-PM.png\"><img
  class=\"size-full wp-image-1083\" title=\"\" src=\"http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-7.49.48-PM.png\"
  alt=\"\" width=\"323\" height=\"241\" &#47;><&#47;a> A video made with Processing.[&#47;caption]\r\n\r\nProcessing
  is a very user friendly language. One of its strengths is how easily you can do
  procedural drawing. However, its surprisingly tricky to export sketches as quicktime
  movies, and its not very well documented (until now!)\r\n\r\n"
wordpress_id: 1081
wordpress_url: http://www.tophersaunders.com/wp/?p=1081
date: '2012-10-20 21:09:06 -0700'
date_gmt: '2012-10-21 01:09:06 -0700'
categories:
- Video
- Code
- Graphics
tags:
- Processing
---
<p>In this tutorial, I'll show you a template for making 2D quicktime movies with <a href="http:&#47;&#47;processing.org&#47;" target="_blank">Processing<&#47;a>.</p>
<p>[caption id="attachment_1083" align="aligncenter" width="323"]<a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-7.49.48-PM.png"><img class="size-full wp-image-1083" title="" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;10&#47;Screen-Shot-2012-10-20-at-7.49.48-PM.png" alt="" width="323" height="241" &#47;><&#47;a> A video made with Processing.[&#47;caption]</p>
<p>Processing is a very user friendly language. One of its strengths is how easily you can do procedural drawing. However, its surprisingly tricky to export sketches as quicktime movies, and its not very well documented (until now!)</p>
<p><a id="more"></a><a id="more-1081"></a></p>
<p>First I'll show you how to setup Processing, then I'll go over the Quicktime Template sketch that you can use as a starting point to make movies. </p>
<p>NOTE: This template only works for 2D drawing, using the P3D and OPENGL engines do not work as far as I have experienced.</p>
<p>Setup Step 1:<br />
Download Processing <strong>1.5.1 <&#47;strong><br />
The latest version (Processing 2.0) will <strong>not<&#47;strong> work for our purposes.<br />
Here is a link to the <a href="http:&#47;&#47;www.processing.org&#47;download&#47;" target="_blank">download page<&#47;a>.</p>
<p>Setup Step 2:<br />
Obtain the Quicktime Template sketch.<br />
[code gutter="true" lang="cpp"]<br />
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
[&#47;code]<br />
I don't recall where I got this sketch. You can copy&#47;paste it into your sketch window. Save it -- you'll use it a lot.</p>
<p>I'll go through this sketch line by line to highlight the most important parts.</p>
<p>[code gutter="true" lang="cpp"]<br />
import processing.video.*;<br />
[&#47;code]<br />
This line includes the video library into the sketch. Most importantly- the definition of the MovieMaker class. </p>
<p>[code gutter="true" lang="cpp" firstline="3"]<br />
MovieMaker mm;  &#47;&#47; Declare MovieMaker object<br />
[&#47;code]<br />
This tells the Processing interpretor that we will be using the MovieMaker class. And we'll call that object "mm". </p>
<p>However our MovieMaker object called "mm" still needs to be initialized, for here we've merely told Processing to expect it to be used. We will initialize this object with a <em>constructor<&#47;em>. This will give the required instance variables of mm valid starting values. </p>
<p>[code gutter="true" lang="cpp" firstline="5"]<br />
void setup() {<br />
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
}<br />
[&#47;code]</p>
<p>This is done the setup() function. In Processing, the setup() function initializes the variables of the sketch. Our constructor is on lines 8-13. </p>
<p>Its like saying - use the function <em>new<&#47;em> to initialize an instance of <em>MovieMaker<&#47;em> class with these values as arguments, and store this initialized object in the variable <em>mm<&#47;em>. </p>
<p>The arguments are spaced so that they each get their own line. This is valid syntax but not required. One could write a equally valid statment -</p>
<p>[code gutter="true" lang="cpp" firstline="5" highlight="8"]<br />
void setup() {<br />
  size(320, 240);<br />
  &#47;&#47; Create MovieMaker object with size, filename,<br />
  mm = new MovieMaker(this, width, height, "drawing.mov", 30, MovieMaker.H263, MovieMaker.HIGH);<br />
background(204);<br />
}<br />
[&#47;code]</p>
<p>This however, doesn't leave room for us to comment on what all these arguments are. Generally if theres more than 3 arguments, I space it vertically and comment each argument.<strong>(whitespace does not matter in Processing, and this is why)<&#47;strong> - Much easier to read when having to quickly visually scan a ton of lines. </p>
<p>[code gutter="true" lang="cpp" firstline="5" highlight="6"]<br />
void setup() {<br />
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
}<br />
[&#47;code]</p>
<p><strong>We must declare the size() of the sketch before calling the MovieMaker constructor<&#47;strong></p>
<p>or else our new() function will return an exception claiming that its been given some NULL pointer. <em>Cryptic.<&#47;em><br />
But it makes sense, how is it sopposed to know how big the <em>width<&#47;em> and <em>height<&#47;em> is if we haven't told it?</p>
<p>Here is where we specify the name of the quicktime movie to be output by the sketch. </p>
<p>[code gutter="true" lang="cpp" firstline="5" highlight="11"]<br />
void setup() {<br />
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
}<br />
[&#47;code]</p>
<p>Frame Rate - Notice that in the <em>setup()<&#47;em> function I did <strong>not<&#47;strong> set a frame rate with the <em>frameRate()<&#47;em> function. <strong>The frame rate of the sketch is not the same as the frame rate of the output quicktime movie.<&#47;strong> </p>
<p>In Processing, if you don't specify <em>frameRate()<&#47;em>, it defaults to <em>60 fps<&#47;em>. This means our sketch will move twice as fast as the output movie. - Example- if we run this sketch for 4 seconds it will produce a movie 8 seconds long. This can be used to our advantage if we need slow moving quicktime movies but don't want to wait for the sketch to run that long. </p>
<p>Next is our draw() function.</p>
<p>[code gutter="true" lang="cpp" firstline="19"]<br />
void draw() {<br />
  ellipse(mouseX, mouseY, 20, 20);<br />
  mm.addFrame();  &#47;&#47; Add window's pixels to movie<br />
}<br />
[&#47;code]</p>
<p>Remember that draw() is called once per frame. We didn't specify it in setup() so this defaults to 60 fps. So draw() is called 60 times a second. This is kind of irrelevant here because there is no movement in this draw() function. It simply draws a static, unmoving circle. Thats why its a template. </p>
<p>[code gutter="true" lang="cpp" firstline="19" highlight="20"]<br />
void draw() {<br />
  ellipse(mouseX, mouseY, 20, 20);<br />
  mm.addFrame();  &#47;&#47; Add window's pixels to movie<br />
}<br />
[&#47;code]</p>
<p>Replace line 20 with whatever drawing code you want.</p>
<p>Whats important in this function for our goal of making quicktime movies is line 21:</p>
<p>[code gutter="true" lang="cpp" firstline="19" highlight="21"]<br />
void draw() {<br />
  ellipse(mouseX, mouseY, 20, 20);<br />
  mm.addFrame();  &#47;&#47; Add window's pixels to movie<br />
}<br />
[&#47;code]</p>
<p>At the end of the <em>draw()<&#47;em> function, the <em>.addFrame()<&#47;em> method of our MovieMaker object <em>mm<&#47;em> takes all the data we've drawn to the screen and adds it as a frame to our quicktime movie. Like I said above, you can replace the contents of <em>draw()<&#47;em> with your own drawing algorithms, and it will work fine as long as the MovieMaker method <em>.addFrame()<&#47;em> is called at the end of the <em>draw()<&#47;em> function. For example if we call the <em>.addFrame()<&#47;em> method before the end of our drawing code, that drawing will not get added to the quicktime frame.</p>
<p>Our final function is the <em>keyPressed()<&#47;em> function. This provides a crucial step in the quicktime movie process of closing the file and writing the length of the movie to the header of the .mov file.</p>
<p>[code gutter="true" lang="cpp" firstline="24" highlight="21"]<br />
void keyPressed() {<br />
    if (key == ' ')&#47;&#47;If Spacebar Pressed..<br />
    {<br />
       mm.finish();  &#47;&#47; Close Movie.<br />
    }<br />
}<br />
[&#47;code]</p>
<p><strong>It is crucial that you call the <em>.finish()<&#47;em> method of the MovieMaker object or your .mov file will be corrupted.<br />
<&#47;strong></p>
<p>Lets review the steps to outputting a quicktime movie from our sketch:</p>
<p><strong>Step 1:<&#47;strong> Import movie maker library</p>
<p>[code gutter="true" lang="cpp" highlight="1"]<br />
import processing.video.*;<br />
[&#47;code]</p>
<p><strong>Step 2:<&#47;strong> create an instance of the Movie Maker object</p>
<p>[code gutter="true" lang="cpp" firstline="3" highlight="3"]<br />
MovieMaker mm;  &#47;&#47; Declare MovieMaker object<br />
[&#47;code]</p>
<p><strong>Step 3:<&#47;strong> Call the constructor in the setup() function to initialize our quicktime movie's size, framerate, quality and other settings.</p>
<p>[code gutter="true" lang="cpp" firstline="5" highlight="8,9,10,11,12,13,14"]<br />
void setup() {<br />
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
}<br />
[&#47;code]</p>
<p><strong>Step 4:<&#47;strong> add each frame to the quicktime movie in the draw() function using the .addFrame() method.</p>
<p>[code gutter="true" lang="cpp" firstline="19" highlight="21"]<br />
void draw() {<br />
  ellipse(mouseX, mouseY, 20, 20);<br />
  mm.addFrame();  &#47;&#47; Add window's pixels to movie<br />
}<br />
[&#47;code]</p>
<p><strong>Step 5:<&#47;strong> at some point, call the <em>.finish()<&#47;em> method to close the .mov file correctly.</p>
<p>[code gutter="true" lang="cpp" firstline="24" highlight="27"]<br />
void keyPressed() {<br />
    if (key == ' ')&#47;&#47;If Spacebar Pressed..<br />
    {<br />
       mm.finish();  &#47;&#47; Close Movie.<br />
    }<br />
}<br />
[&#47;code]</p>
<p>in <em>Part II<&#47;em> I'll show an example made with this template. </p>
