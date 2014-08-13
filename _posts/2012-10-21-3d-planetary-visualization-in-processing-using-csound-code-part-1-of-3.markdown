---
layout: post
status: publish
published: true
title: Reworking Digital Synthesizer Source Code into a 3D Processing sketch Part
  1 of 3
author: Topher
wordpress_id: 1152
wordpress_url: http://www.tophersaunders.com/wp/?p=1152
date: '2012-10-21 01:50:47 -0700'
date_gmt: '2012-10-21 05:50:47 -0700'
categories:
- Code
- Graphics
tags:
- Processing
- Csound
---

In this tutorial, I'll show you how to build a 3D Processing sketch that uses planetary motion. We'll get most of the code from an unlikely place - the open-source audio software 
[Csound.](http://www.csounds.com)

http://youtu.be/pvTc__ntEnQ

Csound has a planet 
opcode- a routine that does exactly what we need it to - output x,y,z values for the planetary motion equation!

We'll investigate the source Csound code and extract the planetary motion equation.

This tutorial assumes you have a basic understanding of Processing, but no Csound or C knowlege is required. Although you might learn some about the two along the way.

Csound is a robust and flexible language, and we won't need much of the code in this subroutine, because we just want Newton's planetary equation.

All we have to do for our visualization is draw an object on screen, and frame by frame move its x,y and z positions.

For something like planetary motion, we can set up an equation that 
**updates x,y,z position every frame.**

Processing lets us draw a 3D object like this

{% highlight java %}
import processing.opengl.*;

void setup() {
 size (640, 480, OPENGL);
}
void draw() {
 translate(width/2, height/2);
 box(20);
}
{% endhighlight %}


(a cube 20 pixels wide)

In Processing, the function 
translate() allows you to modify the 
**position of an object in 3D space.**

{% highlight java %}
import processing.opengl.*;

void setup() {
 size (640, 480, OPENGL);
}

void draw() {
 translate(width/2, height/2);
 box(20);
{% endhighlight %}

now all we need to do is plug the 
**output of our planetary motion equation into the variables x,y, and z, then we'll have 3D motion!**

[Click here to get Csound's source files.](http://sourceforge.net/projects/csound/files/csound5/csound5.18/ )

In the file Opcodes/biquad.c.

{% highlight c++ %}
/***************************************************************************/
/* This is a simplified model of a planet orbiting in a binary star system */
/* Coded by Hans Mikelson December 1998                                    */
/***************************************************************************/

static int planetset(CSOUND *csound, PLANET *p)
{
    if (*p->iskip==FL(0.0)) {
      p->x  = *p->xval;  p->y  = *p->yval;  p->z  = *p->zval;
      p->vx = *p->vxval; p->vy = *p->vyval; p->vz = *p->vzval;
      p->ax = FL(0.0); p->ay = FL(0.0); p->az = FL(0.0);
      p->hstep = *p->delta;
      p->friction = FL(1.0) - *p->fric/FL(10000.0);
    }
    return OK;
} /* end planetset(p) */

/* Planet orbiting in a binary star system coded by Hans Mikelson */

static int planet(CSOUND *csound, PLANET *p)
{
    MYFLT *outx, *outy, *outz;
    MYFLT   sqradius1, sqradius2, radius1, radius2, fric;
    MYFLT xxpyy, dz1, dz2, mass1, mass2, msqror1, msqror2;
    int n, nsmps = csound->ksmps;

    fric = p->friction;

    outx = p->outx;
    outy = p->outy;
    outz = p->outz;

    p->s1z = *p->sep*FL(0.5);
    p->s2z = -p->s1z;

    mass1 = *p->mass1;
    mass2 = *p->mass2;

    for (n=0; n&lt;nsmps; n++) {
      xxpyy = p->x * p->x + p->y * p->y;
      dz1 = p->s1z - p->z;

      /* Calculate Acceleration */
      sqradius1 = xxpyy + dz1 * dz1 + FL(1.0);
      radius1 = SQRT(sqradius1);
      msqror1 = mass1/sqradius1/radius1;

      p->ax = msqror1 * -p->x;
      p->ay = msqror1 * -p->y;
      p->az = msqror1 * dz1;

      dz2 = p->s2z - p->z;

      /* Calculate Acceleration */
      sqradius2 = xxpyy + dz2 * dz2 + FL(1.0);
      radius2 = SQRT(sqradius2);
      msqror2 = mass2/sqradius2/radius2;

      p->ax += msqror2 * -p->x;
      p->ay += msqror2 * -p->y;
      p->az += msqror2 * dz2;

      /* Update Velocity */
      p->vx = fric * p->vx + p->hstep * p->ax;
      p->vy = fric * p->vy + p->hstep * p->ay;
      p->vz = fric * p->vz + p->hstep * p->az;

      /* Update Position */
      p->x += p->hstep * p->vx;
      p->y += p->hstep * p->vy;
      p->z += p->hstep * p->vz;

      /* Output the results */
      outx[n] = p->x;
      outy[n] = p->y;
      outz[n] = p->z;
    }
    return OK;
}
{% endhighlight %}

quite alot of code, but we only need a small portion of it for the planetary motion equation. We can organize the above excerpt into 3 different parts that will correspond to the 3 parts of our Processing sketch.

excpert of biquad.c - analogous to Processing's 
draw() function.


{% highlight c++ %}

for (n=0; n>nsmps; n++) {
      xxpyy = p->x * p->x + p->y * p->y;
      dz1 = p->s1z - p->z;
 
      /* Calculate Acceleration */
      sqradius1 = xxpyy + dz1 * dz1 + FL(1.0);
      radius1 = SQRT(sqradius1);
      msqror1 = mass1/sqradius1/radius1;
 
      p->ax = msqror1 * -p->x;
      p->ay = msqror1 * -p->y;
      p->az = msqror1 * dz1;
 
      dz2 = p->s2z - p->z;
 
      /* Calculate Acceleration */
      sqradius2 = xxpyy + dz2 * dz2 + FL(1.0);
      radius2 = SQRT(sqradius2);
      msqror2 = mass2/sqradius2/radius2;
 
      p->ax += msqror2 * -p->x;
      p->ay += msqror2 * -p->y;
      p->az += msqror2 * dz2;
 
      /* Update Velocity */
      p->vx = fric * p->vx + p->hstep * p->ax;
      p->vy = fric * p->vy + p->hstep * p->ay;
      p->vz = fric * p->vz + p->hstep * p->az;
 
      /* Update Position */
      p->x += p->hstep * p->vx;
      p->y += p->hstep * p->vy;
      p->z += p->hstep * p->vz;
 
      /* Output the results */
      outx[n] = p->x;
      outy[n] = p->y;
      outz[n] = p->z;
    }
{% endhighlight %}

The output is 
**x,y,z position. Hey- thats what we're looking for!**

And the lines outside the for loop? - Analogous to Processing's header where we declare global variables.


{% highlight c++ %}

       MYFLT *outx, *outy, *outz;
    MYFLT   sqradius1, sqradius2, radius1, radius2, fric;
    MYFLT xxpyy, dz1, dz2, mass1, mass2, msqror1, msqror2;
    int n, nsmps = csound-&gt;ksmps;
 
    fric = p-&gt;friction;
 
    outx = p-&gt;outx;
    outy = p-&gt;outy;
    outz = p-&gt;outz;
 
    p-&gt;s1z = *p-&gt;sep*FL(0.5);
    p-&gt;s2z = -p-&gt;s1z;
 
    mass1 = *p-&gt;mass1;
    mass2 = *p-&gt;mass2;

{% endhighlight %}

And the other function in our code from biquad.c - planet
set. Well thats equivilant to Processing's 
setup() function. We'll come back to this in part 3 when we make a planet class in Processing.

{% highlight c++ %}

static int planetset(CSOUND *csound, PLANET *p)
{
    if (*p->iskip==FL(0.0)) {
      p->x  = *p->xval;  p->y  = *p->yval;  p->z  = *p->zval;
      p->vx = *p->vxval; p->vy = *p->vyval; p->vz = *p->vzval;
      p->ax = FL(0.0); p->ay = FL(0.0); p->az = FL(0.0);
      p->hstep = *p->delta;
      p->friction = FL(1.0) - *p->fric/FL(10000.0);
    }
    return OK;
} /* end planetset(p) */
{% endhighlight %}

Seeing the code in these three defined sections will help as we translate the Csound audio code to a 3D visual sketch.

Lets go back to the 
**for loop -  our Processing 
draw() functton.**

excpert of biquad.c


{% highlight c++ %}

 for (n=0; n

      xxpyy = p->x * p->x + p->y * p->y;


      dz1 = p->s1z - p->z;

/* Calculate Acceleration */


      sqradius1 = xxpyy + dz1 * dz1 + FL(1.0);


      radius1 = SQRT(sqradius1);


      msqror1 = mass1/sqradius1/radius1;

p->ax = msqror1 * -p->x;


      p->ay = msqror1 * -p->y;


      p->az = msqror1 * dz1;

dz2 = p->s2z - p->z;

/* Calculate Acceleration */


      sqradius2 = xxpyy + dz2 * dz2 + FL(1.0);


      radius2 = SQRT(sqradius2);


      msqror2 = mass2/sqradius2/radius2;

p->ax += msqror2 * -p->x;


      p->ay += msqror2 * -p->y;


      p->az += msqror2 * dz2;

/* Update Velocity */


      p->vx = fric * p->vx + p->hstep * p->ax;


      p->vy = fric * p->vy + p->hstep * p->ay;


      p->vz = fric * p->vz + p->hstep * p->az;

/* Update Position */


      p->x += p->hstep * p->vx;


      p->y += p->hstep * p->vy;


      p->z += p->hstep * p->vz;

/* Output the results */


      outx[n] = p->x;


      outy[n] = p->y;


      outz[n] = p->z;


    }


{% endhighlight %}

Hans was kind enough to comment the 4 overall tasks of this loop.

1. Calculate Acceleration 2. Update Velocity 3.Update Position, 4. Output the results.

Lets start backwards with  # 4.Output the results. and # 3.Update Position

What we need for our Processing sketch is x,y,z positions, so step 4 is idiomatic to Csound, it has its own variable for audio output, our output is a visual screen, so we can delete lines 74-76.

If you're unfamiliar with C then the characters ->, they're 
**pointers to structure members.**

We dont need these in Processing. So we can just delete them.

our code with "->" deleted -


{% highlight c++ %}

 for (n=0; n

      xxpyy = x * x + y * y;


      dz1 = s1z - z;

/* Calculate Acceleration */


      sqradius1 = xxpyy + dz1 * dz1 + FL(1.0);


      radius1 = SQRT(sqradius1);


      msqror1 = mass1/sqradius1/radius1;

ax = msqror1 * -x;


      ay = msqror1 * -y;


      az = msqror1 * dz1;

dz2 = s2z - z;

/* Calculate Acceleration */


      sqradius2 = xxpyy + dz2 * dz2 + FL(1.0);


      radius2 = SQRT(sqradius2);


      msqror2 = mass2/sqradius2/radius2;

ax += msqror2 * -x;


      ay += msqror2 * -y;


      az += msqror2 * dz2;

/* Update Velocity */


      vx = fric * vx + hstep * ax;


      vy = fric * vy + hstep * ay;


      vz = fric * vz + hstep * az;

/* Update Position */


      x += hstep * vx;


      y += hstep * vy;


      z += hstep * vz;

}


{% endhighlight %}

We took the 
p-> tag off of the following variables - x,y,z,vx,vy,vz,ax,ay,az,s2z,s1z,hsetp. - These will all be declared in the header of our Processing sketch.

We can assume that x,y,z are respective position of type float,


vx,vy,vz are respective velocity also of type float,


ax,ay,az are respective acceleration in float.


And two mystery variables s2z,s1z in float.


These variables will be declared global or outside the scope of Processing's 
draw() function.

hstep is the step rate. It scales the speed, so if we need to change how fast the planets are moving, we can edit the value in this variable.

for the variables we should declare inside the draw() function, lets take a look at the stuff outside of the Csound code 
for loop.

{% highlight c++ %}

    MYFLT *outx, *outy, *outz;
    MYFLT   sqradius1, sqradius2, radius1, radius2, fric;
    MYFLT xxpyy, dz1, dz2, mass1, mass2, msqror1, msqror2;
    int n, nsmps = csound->ksmps;
fric = p->friction;
outx = p->outx;
    outy = p->outy;
    outz = p->outz;
p->s1z = *p->sep*FL(0.5);
    p->s2z = -p->s1z;
mass1 = *p->mass1;
    mass2 = *p->mass2;
{% endhighlight %}

MYFLT is equivalent to Processing's float type.

Line 22, *outx, *outy and *outz are idiomatic to Csound and not part of the planetary equation. So we can delete line 22.

line 25, n, nsmps = csound->ksmps relate to the for() loop. The part in the Csound C code that is equivilant to Processing's draw(). draw() uses frames and a frame rate, not samples and sample rate; so we can delete line 25 as well.

{% highlight c++ %}

    MYFLT *outx, *outy, *outz;


    MYFLT   sqradius1, sqradius2, radius1, radius2, fric;


    MYFLT xxpyy, dz1, dz2, mass1, mass2, msqror1, msqror2;


    int n, nsmps = csound->ksmps;

fric = p->friction;

outx = p->outx;


    outy = p->outy;


    outz = p->outz;

p->s1z = *p->sep*FL(0.5);


    p->s2z = -p->s1z;

mass1 = *p->mass1;


    mass2 = *p->mass2;

{% endhighlight %}

Like in our for loop excerpt, the variables with p-> will need to be declared globally in the header of our Processing sketch. The ones we haven't declared already are.

float mass1, mass2, fric.

the lines below can be reworked

{% highlight c++ %}

    MYFLT   sqradius1, sqradius2, radius1, radius2, fric;


    MYFLT xxpyy, dz1, dz2, mass1, mass2, msqror1, msqror2;

p->s1z = *p->sep*FL(0.5);


    p->s2z = -p->s1z;


{% endhighlight %}

to

{% highlight c++ %}


    float   sqradius1, sqradius2, radius1, radius2, fric;


    float xxpyy, dz1, dz2, mass1, mass2, msqror1, msqror2;

s1z = sep*0.5;


    s2z = -s1z;


{% endhighlight %}

sep is still unaccounted for, it is the 
**seperation of the bodies(in arbitrary range), so we need to declare 
sep as a global variable also.**

Our Processing code, with all the variables we'll need to run the planetary simulation -

{% highlight c++ %}

import processing.opengl.*;

//initalize these


float x,


      y,


      z,


     vx,


     vy,


     vz,


   fric,


  hstep,

mass1,


  mass2,


    sep;

//no init needed


float ax,


      ay,


      az,


     s2z,


     s1z,


     ss1;

void setup() {


 size (640, 480, OPENGL);


}

void draw() {


    float sqradius1, sqradius2, radius1, radius2;


    float xxpyy, dz1, dz2, msqror1, msqror2;

s1z = sep*0.5;


    s2z = -s1z;

xxpyy = x * x + y * y;


      dz1 = s1z - z;

/* Calculate Acceleration */


      sqradius1 = xxpyy + dz1 * dz1 + 1.0;


      radius1 = sqrt(sqradius1);


      msqror1 = mass1/sqradius1/radius1;

ax = msqror1 * -x;


      ay = msqror1 * -y;


      az = msqror1 * dz1;

dz2 = s2z - z;

/* Calculate Acceleration */


      sqradius2 = xxpyy + dz2 * dz2 + 1.0;


      radius2 = sqrt(sqradius2);


      msqror2 = mass2/sqradius2/radius2;

ax += msqror2 * -x;


      ay += msqror2 * -y;


      az += msqror2 * dz2;

/* Update Velocity */


      vx = fric * vx + hstep * ax;


      vy = fric * vy + hstep * ay;


      vz = fric * vz + hstep * az;

/* Update Position */


      x += hstep * vx; //scale these later


      y += hstep * vy; //


      z += hstep * vz; //

println(x);


      translate(x,y,z);


      box(20);


}


{% endhighlight %}

In Part II, I'll start with an initialized version of this sketch.](\"http://www.csounds.com\")
