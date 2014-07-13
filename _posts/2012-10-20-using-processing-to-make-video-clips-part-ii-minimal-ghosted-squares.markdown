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
excerpt: "[caption id=\"attachment_1123\" align=\"aligncenter\" width=\"320\"]
[![\"\"](\"http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-9.11.09-PM.png\") A video clip made with Processing
  using the Quicktime template[/caption]\r\n\r\nIn my last post, I showed you
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

[caption id="attachment_1123" align="aligncenter" width="320"]
[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-9.11.09-PM.png) A video clip made with Processing using the Quicktime template[/caption]](http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-9.11.09-PM.png)

In my last post, I showed you how to setup a template in Processing for making quicktime movies.

In this tutorial, I'll show you how to make a movie with the template - 4 squares that grow in size, overlap in a cool way, and with ghosting.

[]()[]()

squares.pde

[code gutter="true" lang="cpp" collapse="true"]


import processing.video.*;


MovieMaker mm;

final boolean makeMovie = false;


final String  movieName = "rectangleous.mov";


final int   myFrameRate = 30;

int i=0;

void setup(){

background(255);


  size (320, 240);


  if(makeMovie){


    mm = new MovieMaker(this,


                       width,


                      height,


                   movieName,


                 myFrameRate,


             MovieMaker.H263,


             MovieMaker.HIGH);


  }

}

void draw() {

fill(255, 255, 255, 10);


rectMode(CENTER);


//Background-for ghosting


rect((width/2)-5,//x origin


    (height/2)-5,//y origin


        width+15,// x size


      height+15);// y size

i++;

stroke(0);


strokeWeight(1);

noFill();

rect(width/2,//x origin


     height/2,//y origin


         i,i);//x&y size

rect(width/4,//x origin


     height/2,//y origin


         i,i);//x&y size

rect(width*3/4,//x origin


      height/2,//y origin


          i,i);//x&y size

rect(width/2,//x origin


    height*3/4,//y origin


          i,i);//x&y size

rect(width/2,//x origin


      height/4,//y origin


          i,i); //x&y size

if(makeMovie) mm.addFrame();


}

void keyPressed() {


    if (key == ' ') {


      if(makeMovie) mm.finish();


    }


}


[/code]

The code above is built on top of the tutorial 
[Using Processing to Make Video Clips Part I – Quicktime Template](http://www.tophersaunders.com/wp/?p=1081)

Lets first look at the template from last time.

quicktimeTemplate.pde

[code gutter="true" lang="cpp" collapse="true" highlight="20"]


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

I've highlighted line 20 here because that's the place in the code where we'd place our drawing code.

Let me start by discussing a way I've made the template more robust for debugging sketches

Say we want to debug the drawing algorithm, and we want to test our sketch without making a movie. Normall we'd have to comment out the highlighted lines of code like so.

[code gutter="true" lang="cpp" collapse="true" highlight="8,9,10,11,12,13,14,21,27"]


import processing.video.*;

MovieMaker mm;  // Declare MovieMaker object

void setup() {


  size(320, 240);


  // Create MovieMaker object with size, filename,


  //mm = new MovieMaker(this,


  //                   width, //size x


  //                  height, //size y


  //           "drawing.mov", //name of movie


  //                      30, //frame rate


  //         MovieMaker.H263, //codec


  //         MovieMaker.HIGH);//quality

background(204);


}

void draw() {


  ellipse(mouseX, mouseY, 20, 20);


  //mm.addFrame();  // Add window's pixels to movie


}

void keyPressed() {


    if (key == ' ')//If Spacebar Pressed..


    {


    //   mm.finish();  // Close Movie.


    }


}


[/code]

We can do this an easier way by creating a global boolean variable that will allow us to "comment out" all these lines in a self documenting way

in squares.pde

[code gutter="true" lang="cpp" highlight="4"]


import processing.video.*;


MovieMaker mm;

final boolean makeMovie = false;


final String  movieName = "rectangleous.mov";


final int   myFrameRate = 30;


[/code]

Line 4 we declare a boolean called 
makeMovie. We use the keyword 
final to indicate that this value will not change throughout the duration of the sketch, even if we do so accidentally.

The following lines ask this boolean if its true or false. If it's false, then we don't utilize those lines, we don't output a movie and we get to debug our sketch in peace without filling our harddrive with scratch movies.

squares.pde

[code gutter="true" lang="cpp" collapse="true" highlight="14,15,16,17,18,19,20,21,22,62,68"]


import processing.video.*;


MovieMaker mm;

final boolean makeMovie = false;


final String  movieName = "rectangleous.mov";


final int   myFrameRate = 30;

int i=0;

void setup(){

background(255);


  size (320, 240);


  if(makeMovie){


    mm = new MovieMaker(this,


                       width,


                      height,


                   movieName,


                 myFrameRate,


             MovieMaker.H263,


             MovieMaker.HIGH);


  }

}

void draw() {

fill(255, 255, 255, 10);


rectMode(CENTER);


//Background-for ghosting


rect((width/2)-5,//x origin


    (height/2)-5,//y origin


        width+15,// x size


      height+15);// y size

i++;

stroke(0);


strokeWeight(1);

noFill();

rect(width/2,//x origin


     height/2,//y origin


         i,i);//x&y size

rect(width/4,//x origin


     height/2,//y origin


         i,i);//x&y size

rect(width*3/4,//x origin


      height/2,//y origin


          i,i);//x&y size

rect(width/2,//x origin


    height*3/4,//y origin


          i,i);//x&y size

rect(width/2,//x origin


      height/4,//y origin


          i,i); //x&y size

if(makeMovie) mm.addFrame();


}

void keyPressed() {


    if (key == ' ') {


      if(makeMovie) mm.finish();


    }


}


[/code]

lines 5 and 6 let us set common movie parameters without having to dig through the constructor arguments.

[code gutter="true" lang="cpp" highlight="5,6"]


import processing.video.*;


MovieMaker mm;

final boolean makeMovie = false;


final String  movieName = "rectangleous.mov";


final int   myFrameRate = 30;


[/code]

Now that this subtle difference is made clear, we will discuss the drawing algorithm, starting with the cool "ghosting" effect that leaves trails.

squares.pde

[code gutter="true" lang="cpp" collapse="true" highlight="31,32,33,34"]


import processing.video.*;


MovieMaker mm;

final boolean makeMovie = false;


final String  movieName = "rectangleous.mov";


final int   myFrameRate = 30;

int i=0;

void setup(){

background(255);


  size (320, 240);


  if(makeMovie){


    mm = new MovieMaker(this,


                       width,


                      height,


                   movieName,


                 myFrameRate,


             MovieMaker.H263,


             MovieMaker.HIGH);


  }

}

void draw() {

fill(255, 255, 255, 10);


rectMode(CENTER);


//Background-for ghosting


rect((width/2)-5,//x origin


    (height/2)-5,//y origin


        width+15,// x size


      height+15);// y size

i++;

stroke(0);


strokeWeight(1);

noFill();

rect(width/2,//x origin


     height/2,//y origin


         i,i);//x&y size

rect(width/4,//x origin


     height/2,//y origin


         i,i);//x&y size

rect(width*3/4,//x origin


      height/2,//y origin


          i,i);//x&y size

rect(width/2,//x origin


    height*3/4,//y origin


          i,i);//x&y size

rect(width/2,//x origin


      height/4,//y origin


          i,i); //x&y size

if(makeMovie) mm.addFrame();


}

void keyPressed() {


    if (key == ' ') {


      if(makeMovie) mm.finish();


    }


}


[/code]

These highlighted lines draw a semi-transparent white rectangle before any other drawing that occurs in the 
draw() function. In Processing, you have to explicitly tell it to "erase" the previous frame or every frame will add to the one before it. usually you use the background() function. background() however, does not let you use the alpha channel for transparency.

Any drawing that occurs after the highlighted lines will be "ghosted" and leave trails - a simple trick to make your drawings more "sensual."

Note that we use rectMode(CENTER), meaning that the position arguments for the rect() function specify the center of the rectangle, not the upper left hand corner as is the default behavior for the rect() function.

This allows us to position our 5 rectangles more intuitively by specifying the point from which they grow outward.

[code gutter="true" lang="cpp" firstline="43"]


 rect(width/2,//x origin


     height/2,//y origin


         i,i);//x&y size


[/code]

here we set the x origin to width/2, i.e. the horizonal center of the screen, and height/2, i.e. the vertical center of the screen, and we increment the x and y sizes together to get the effect of a growing rectangle.

[code gutter="true" lang="cpp" firstline="45"]


 rect(width/4,//x origin


     height/2,//y origin


         i,i);//x&y size


[/code]

here the x origin is a quarter of the width, or halfway to the horizontal center of the screen, and height/2, the vertical center of the screen again.

and so on for the placement of other rectangles...

[caption id="attachment_1136" align="aligncenter" width="320"]
[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-10.04.46-PM.png) The first couple frames of our video look like this.[/caption]](http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-10.04.46-PM.png)

To give these rectangles motion, we declare a global variable in the header, and then increment the value every frame, So in the first frame i=0, the second i=1, the third frame i=3 and so on. The effect is that the squares are a little bigger each frame.

[caption id="attachment_1137" align="aligncenter" width="322"]
[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-10.06.50-PM.png) As the variable i is incremented each frame, the squares grow[/caption]](http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-10.06.50-PM.png)

[caption id="attachment_1138" align="aligncenter" width="322"]
[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-10.07.59-PM.png) Because we specified noFill() on line 41, the lines of the squares overlap.[/caption]](http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-10.07.59-PM.png)

[caption id="attachment_1140" align="aligncenter" width="319"]
[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-10.09.34-PM.png) They continue to overlap in cool ways until...[/caption]](http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-10.09.34-PM.png)

[caption id="attachment_1141" align="aligncenter" width="321"]
[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-10.11.25-PM.png) ...they become too large for the screen. Now we can hit spacebar, which calls mm.finish() and our Quicktime .mov is ready![/caption]](http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-10.11.25-PM.png)](\"http://www.tophersaunders.com/wp/wp-content/uploads/2012/10/Screen-Shot-2012-10-20-at-9.11.09-PM.png\")
