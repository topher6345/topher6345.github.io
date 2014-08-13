---
layout: post
status: publish
published: true
title: Exporting Quicktime Movies with Processing - Part I
author: Topher
date: '2012-10-20 21:09:06 -0700'
categories:
- Video
- Code
- Graphics
tags:
- Processing
---

In this tutorial, I'll show you a template for making 2D quicktime movies with 
[Processing.](http://processing.org/)

[caption id="attachment_1083" align="aligncenter" width="323"]
[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-7.49.48-PM.png) A video made with Processing.[/caption]](http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-7.49.48-PM.png)

Processing is a very user friendly language. One of its strengths is how easily you can do procedural drawing. However, its surprisingly tricky to export sketches as quicktime movies, and its not very well documented (until now!)

[]()[]()

First I'll show you how to setup Processing, then I'll go over the Quicktime Template sketch that you can use as a starting point to make movies.

NOTE: This template only works for 2D drawing, using the P3D and OPENGL engines do not work as far as I have experienced.

Setup Step 1:


Download Processing 
**1.5.1 


The latest version (Processing 2.0) will 
**not work for our purposes.


Here is a link to the 
[download page.](http://www.processing.org/download/)****

Setup Step 2:


Obtain the Quicktime Template sketch.


[code gutter="true" lang="cpp"]


import processing.video.*;

MovieMaker mm;  // Declare MovieMaker object

void setup() {


  size(320, 240);


  // Create MovieMaker object with size, filename,


  mm = new MovieMaker(this,


                     width, //size x


                    height, //size y


             "drawing.mov", //name of movie


                        30, //frame rate


           MovieMaker.H263, //codec


           MovieMaker.HIGH);//quality

background(204);


}

void draw() {


  ellipse(mouseX, mouseY, 20, 20);


  mm.addFrame();  // Add window's pixels to movie


}

void keyPressed() {


    if (key == ' ')//If Spacebar Pressed..


    {


       mm.finish();  // Close Movie.


    }


}


[/code]


I don't recall where I got this sketch. You can copy/paste it into your sketch window. Save it -- you'll use it a lot.

I'll go through this sketch line by line to highlight the most important parts.

[code gutter="true" lang="cpp"]


import processing.video.*;


[/code]


This line includes the video library into the sketch. Most importantly- the definition of the MovieMaker class.

[code gutter="true" lang="cpp" firstline="3"]


MovieMaker mm;  // Declare MovieMaker object


[/code]


This tells the Processing interpretor that we will be using the MovieMaker class. And we'll call that object "mm".

However our MovieMaker object called "mm" still needs to be initialized, for here we've merely told Processing to expect it to be used. We will initialize this object with a 
constructor. This will give the required instance variables of mm valid starting values.

[code gutter="true" lang="cpp" firstline="5"]


void setup() {


  size(320, 240);


  // Create MovieMaker object with size, filename,


  mm = new MovieMaker(this,


                     width, //size x


                    height, //size y


             "drawing.mov", //name of movie


                        30, //frame rate


           MovieMaker.H263, //codec


           MovieMaker.HIGH);//quality

background(204);


}


[/code]

This is done the setup() function. In Processing, the setup() function initializes the variables of the sketch. Our constructor is on lines 8-13.

Its like saying - use the function 
new to initialize an instance of 
MovieMaker class with these values as arguments, and store this initialized object in the variable 
mm.

The arguments are spaced so that they each get their own line. This is valid syntax but not required. One could write a equally valid statment -

[code gutter="true" lang="cpp" firstline="5" highlight="8"]


void setup() {


  size(320, 240);


  // Create MovieMaker object with size, filename,


  mm = new MovieMaker(this, width, height, "drawing.mov", 30, MovieMaker.H263, MovieMaker.HIGH);


background(204);


}


[/code]

This however, doesn't leave room for us to comment on what all these arguments are. Generally if theres more than 3 arguments, I space it vertically and comment each argument.
**(whitespace does not matter in Processing, and this is why) - Much easier to read when having to quickly visually scan a ton of lines.**

[code gutter="true" lang="cpp" firstline="5" highlight="6"]


void setup() {


  size(320, 240);


  // Create MovieMaker object with size, filename,


  mm = new MovieMaker(this,


                     width, //size x


                    height, //size y


             "drawing.mov", //name of movie


                        30, //frame rate


           MovieMaker.H263, //codec


           MovieMaker.HIGH);//quality

background(204);


}


[/code]

**We must declare the size() of the sketch before calling the MovieMaker constructor**

or else our new() function will return an exception claiming that its been given some NULL pointer. 
Cryptic.


But it makes sense, how is it sopposed to know how big the 
width and 
height is if we haven't told it?

Here is where we specify the name of the quicktime movie to be output by the sketch.

[code gutter="true" lang="cpp" firstline="5" highlight="11"]


void setup() {


  size(320, 240);


  // Create MovieMaker object with size, filename,


  mm = new MovieMaker(this,


                     width, //size x


                    height, //size y


             "drawing.mov", //name of movie


                        30, //frame rate


           MovieMaker.H263, //codec


           MovieMaker.HIGH);//quality

background(204);


}


[/code]

Frame Rate - Notice that in the 
setup() function I did 
**not set a frame rate with the 
frameRate() function. 
**The frame rate of the sketch is not the same as the frame rate of the output quicktime movie.****

In Processing, if you don't specify 
frameRate(), it defaults to 
60 fps. This means our sketch will move twice as fast as the output movie. - Example- if we run this sketch for 4 seconds it will produce a movie 8 seconds long. This can be used to our advantage if we need slow moving quicktime movies but don't want to wait for the sketch to run that long.

Next is our draw() function.

[code gutter="true" lang="cpp" firstline="19"]


void draw() {


  ellipse(mouseX, mouseY, 20, 20);


  mm.addFrame();  // Add window's pixels to movie


}


[/code]

Remember that draw() is called once per frame. We didn't specify it in setup() so this defaults to 60 fps. So draw() is called 60 times a second. This is kind of irrelevant here because there is no movement in this draw() function. It simply draws a static, unmoving circle. Thats why its a template.

[code gutter="true" lang="cpp" firstline="19" highlight="20"]


void draw() {


  ellipse(mouseX, mouseY, 20, 20);


  mm.addFrame();  // Add window's pixels to movie


}


[/code]

Replace line 20 with whatever drawing code you want.

Whats important in this function for our goal of making quicktime movies is line 21:

[code gutter="true" lang="cpp" firstline="19" highlight="21"]


void draw() {


  ellipse(mouseX, mouseY, 20, 20);


  mm.addFrame();  // Add window's pixels to movie


}


[/code]

At the end of the 
draw() function, the 
.addFrame() method of our MovieMaker object 
mm takes all the data we've drawn to the screen and adds it as a frame to our quicktime movie. Like I said above, you can replace the contents of 
draw() with your own drawing algorithms, and it will work fine as long as the MovieMaker method 
.addFrame() is called at the end of the 
draw() function. For example if we call the 
.addFrame() method before the end of our drawing code, that drawing will not get added to the quicktime frame.

Our final function is the 
keyPressed() function. This provides a crucial step in the quicktime movie process of closing the file and writing the length of the movie to the header of the .mov file.

[code gutter="true" lang="cpp" firstline="24" highlight="21"]


void keyPressed() {


    if (key == ' ')//If Spacebar Pressed..


    {


       mm.finish();  // Close Movie.


    }


}


[/code]

**It is crucial that you call the 
.finish() method of the MovieMaker object or your .mov file will be corrupted.**

Lets review the steps to outputting a quicktime movie from our sketch:

**Step 1: Import movie maker library**

[code gutter="true" lang="cpp" highlight="1"]


import processing.video.*;


[/code]

**Step 2: create an instance of the Movie Maker object**

[code gutter="true" lang="cpp" firstline="3" highlight="3"]


MovieMaker mm;  // Declare MovieMaker object


[/code]

**Step 3: Call the constructor in the setup() function to initialize our quicktime movie's size, framerate, quality and other settings.**

[code gutter="true" lang="cpp" firstline="5" highlight="8,9,10,11,12,13,14"]


void setup() {


  size(320, 240);


  // Create MovieMaker object with size, filename,


  mm = new MovieMaker(this,


                     width, //size x


                    height, //size y


             "drawing.mov", //name of movie


                        30, //frame rate


           MovieMaker.H263, //codec


           MovieMaker.HIGH);//quality

background(204);


}


[/code]

**Step 4: add each frame to the quicktime movie in the draw() function using the .addFrame() method.**

[code gutter="true" lang="cpp" firstline="19" highlight="21"]


void draw() {


  ellipse(mouseX, mouseY, 20, 20);


  mm.addFrame();  // Add window's pixels to movie


}


[/code]

**Step 5: at some point, call the 
.finish() method to close the .mov file correctly.**

[code gutter="true" lang="cpp" firstline="24" highlight="27"]


void keyPressed() {


    if (key == ' ')//If Spacebar Pressed..


    {


       mm.finish();  // Close Movie.


    }


}


[/code]

in 
Part II I'll show an example made with this template.](\"http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-7.49.48-PM.png\")
