---
layout: post
status: publish
published: true
title: Reworking Digital Synthesizer Source Code into a 3D Processing sketch Part
  1 of 3
author:
  display_name: Topher
  login: admin
  email: csaunders@berklee.net
  url: http://www.tophersaunders.com
author_login: admin
author_email: csaunders@berklee.net
author_url: http://www.tophersaunders.com
excerpt: "Hi, in this tutorial, I'll show you how to build a 3D Processing sketch
  that uses planetary motion. We'll get most of the code from an unlikely place -
  the open-source audio software <a href=\"http:&#47;&#47;www.csounds.com\">Csound<&#47;a>.\r\n\r\nhttp:&#47;&#47;youtu.be&#47;pvTc__ntEnQ\r\n\r\nCsound
  has a planet <em>opcode<&#47;em>- a routine that does exactly what we need it to
  - output x,y,z values for the planetary motion equation! \r\n\r\nWe'll investigate
  the source Csound code and extract the planetary motion equation.\r\n\r\n"
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
<p>Hi, in this tutorial, I'll show you how to build a 3D Processing sketch that uses planetary motion. We'll get most of the code from an unlikely place - the open-source audio software <a href="http:&#47;&#47;www.csounds.com">Csound<&#47;a>.</p>
<p>http:&#47;&#47;youtu.be&#47;pvTc__ntEnQ</p>
<p>Csound has a planet <em>opcode<&#47;em>- a routine that does exactly what we need it to - output x,y,z values for the planetary motion equation! </p>
<p>We'll investigate the source Csound code and extract the planetary motion equation.</p>
<p><a id="more"></a><a id="more-1152"></a></p>
<p>This tutorial assumes you have a basic understanding of Processing, but no Csound or C knowlege is required. Although you might learn some about the two along the way. </p>
<p>Csound is a robust and flexible language, and we won't need much of the code in this subroutine, because we just want Newton's planetary equation.</p>
<p>All we have to do for our visualization is draw an object on screen, and frame by frame move its x,y and z positions. </p>
<p>For something like planetary motion, we can set up an equation that <strong>updates<&#47;strong> x,y,z position every frame. </p>
<p>Processing lets us draw a 3D object like this </p>
<p>[code lang="cpp" gutter="true" highlight="9" collapse="true"]<br />
import processing.opengl.*;</p>
<p>void setup() {<br />
 size (640, 480, OPENGL);<br />
}</p>
<p>void draw() {<br />
 translate(width&#47;2, height&#47;2);<br />
 box(20);<br />
}[&#47;code]</p>
<p>(a cube 20 pixels wide)</p>
<p>In Processing, the function <em>translate()<&#47;em> allows you to modify the <strong>position<&#47;strong> of an object in 3D space.</p>
<p>[code lang="cpp" gutter="true" highlight="8"]<br />
import processing.opengl.*;</p>
<p>void setup() {<br />
 size (640, 480, OPENGL);<br />
}</p>
<p>void draw() {<br />
 translate(width&#47;2, height&#47;2);<br />
 box(20);<br />
[&#47;code]</p>
<p>now all we need to do is plug the <strong>output<&#47;strong> of our planetary motion equation into the variables x,y, and z, then we'll have 3D motion!</p>
<p><a href="http:&#47;&#47;sourceforge.net&#47;projects&#47;csound&#47;files&#47;csound5&#47;csound5.18&#47; " target="_blank">Click here<&#47;a> to get Csound's source files. </p>
<p>In the file Opcodes&#47;biquad.c.</p>
<p>[code gutter="true" collapse="true" lang="c"]<br />
&#47;***************************************************************************&#47;<br />
&#47;* This is a simplified model of a planet orbiting in a binary star system *&#47;<br />
&#47;* Coded by Hans Mikelson December 1998                                    *&#47;<br />
&#47;***************************************************************************&#47;</p>
<p>static int planetset(CSOUND *csound, PLANET *p)<br />
{<br />
    if (*p->iskip==FL(0.0)) {<br />
      p->x  = *p->xval;  p->y  = *p->yval;  p->z  = *p->zval;<br />
      p->vx = *p->vxval; p->vy = *p->vyval; p->vz = *p->vzval;<br />
      p->ax = FL(0.0); p->ay = FL(0.0); p->az = FL(0.0);<br />
      p->hstep = *p->delta;<br />
      p->friction = FL(1.0) - *p->fric&#47;FL(10000.0);<br />
    }<br />
    return OK;<br />
} &#47;* end planetset(p) *&#47;</p>
<p>&#47;* Planet orbiting in a binary star system coded by Hans Mikelson *&#47;</p>
<p>static int planet(CSOUND *csound, PLANET *p)<br />
{<br />
    MYFLT *outx, *outy, *outz;<br />
    MYFLT   sqradius1, sqradius2, radius1, radius2, fric;<br />
    MYFLT xxpyy, dz1, dz2, mass1, mass2, msqror1, msqror2;<br />
    int n, nsmps = csound->ksmps;</p>
<p>    fric = p->friction;</p>
<p>    outx = p->outx;<br />
    outy = p->outy;<br />
    outz = p->outz;</p>
<p>    p->s1z = *p->sep*FL(0.5);<br />
    p->s2z = -p->s1z;</p>
<p>    mass1 = *p->mass1;<br />
    mass2 = *p->mass2;</p>
<p>    for (n=0; n<nsmps; n++) {<br />
      xxpyy = p->x * p->x + p->y * p->y;<br />
      dz1 = p->s1z - p->z;</p>
<p>      &#47;* Calculate Acceleration *&#47;<br />
      sqradius1 = xxpyy + dz1 * dz1 + FL(1.0);<br />
      radius1 = SQRT(sqradius1);<br />
      msqror1 = mass1&#47;sqradius1&#47;radius1;</p>
<p>      p->ax = msqror1 * -p->x;<br />
      p->ay = msqror1 * -p->y;<br />
      p->az = msqror1 * dz1;</p>
<p>      dz2 = p->s2z - p->z;</p>
<p>      &#47;* Calculate Acceleration *&#47;<br />
      sqradius2 = xxpyy + dz2 * dz2 + FL(1.0);<br />
      radius2 = SQRT(sqradius2);<br />
      msqror2 = mass2&#47;sqradius2&#47;radius2;</p>
<p>      p->ax += msqror2 * -p->x;<br />
      p->ay += msqror2 * -p->y;<br />
      p->az += msqror2 * dz2;</p>
<p>      &#47;* Update Velocity *&#47;<br />
      p->vx = fric * p->vx + p->hstep * p->ax;<br />
      p->vy = fric * p->vy + p->hstep * p->ay;<br />
      p->vz = fric * p->vz + p->hstep * p->az;</p>
<p>      &#47;* Update Position *&#47;<br />
      p->x += p->hstep * p->vx;<br />
      p->y += p->hstep * p->vy;<br />
      p->z += p->hstep * p->vz;</p>
<p>      &#47;* Output the results *&#47;<br />
      outx[n] = p->x;<br />
      outy[n] = p->y;<br />
      outz[n] = p->z;<br />
    }<br />
    return OK;<br />
}<br />
[&#47;code]</p>
<p>quite alot of code, but we only need a small portion of it for the planetary motion equation. We can organize the above excerpt into 3 different parts that will correspond to the 3 parts of our Processing sketch.</p>
<p>excpert of biquad.c - analogous to Processing's <em>draw()<&#47;em> function.<br />
[code gutter="true" firstline="39"]<br />
 for (n=0; n<nsmps; n++) {<br />
      xxpyy = p->x * p->x + p->y * p->y;<br />
      dz1 = p->s1z - p->z;</p>
<p>      &#47;* Calculate Acceleration *&#47;<br />
      sqradius1 = xxpyy + dz1 * dz1 + FL(1.0);<br />
      radius1 = SQRT(sqradius1);<br />
      msqror1 = mass1&#47;sqradius1&#47;radius1;</p>
<p>      p->ax = msqror1 * -p->x;<br />
      p->ay = msqror1 * -p->y;<br />
      p->az = msqror1 * dz1;</p>
<p>      dz2 = p->s2z - p->z;</p>
<p>      &#47;* Calculate Acceleration *&#47;<br />
      sqradius2 = xxpyy + dz2 * dz2 + FL(1.0);<br />
      radius2 = SQRT(sqradius2);<br />
      msqror2 = mass2&#47;sqradius2&#47;radius2;</p>
<p>      p->ax += msqror2 * -p->x;<br />
      p->ay += msqror2 * -p->y;<br />
      p->az += msqror2 * dz2;</p>
<p>      &#47;* Update Velocity *&#47;<br />
      p->vx = fric * p->vx + p->hstep * p->ax;<br />
      p->vy = fric * p->vy + p->hstep * p->ay;<br />
      p->vz = fric * p->vz + p->hstep * p->az;</p>
<p>      &#47;* Update Position *&#47;<br />
      p->x += p->hstep * p->vx;<br />
      p->y += p->hstep * p->vy;<br />
      p->z += p->hstep * p->vz;</p>
<p>      &#47;* Output the results *&#47;<br />
      outx[n] = p->x;<br />
      outy[n] = p->y;<br />
      outz[n] = p->z;<br />
    }<br />
[&#47;code]</p>
<p>The output is <strong>x,y,z position<&#47;strong>. Hey- thats what we're looking for!</p>
<p>And the lines outside the for loop? - Analogous to Processing's header where we declare global variables.<br />
[code gutter="true" lang="c" firstline="22"]<br />
    MYFLT *outx, *outy, *outz;<br />
    MYFLT   sqradius1, sqradius2, radius1, radius2, fric;<br />
    MYFLT xxpyy, dz1, dz2, mass1, mass2, msqror1, msqror2;<br />
    int n, nsmps = csound->ksmps;</p>
<p>    fric = p->friction;</p>
<p>    outx = p->outx;<br />
    outy = p->outy;<br />
    outz = p->outz;</p>
<p>    p->s1z = *p->sep*FL(0.5);<br />
    p->s2z = -p->s1z;</p>
<p>    mass1 = *p->mass1;<br />
    mass2 = *p->mass2;</p>
<p>[&#47;code]</p>
<p>And the other function in our code from biquad.c - planet<em>set<&#47;em>. Well thats equivilant to Processing's <em>setup()<&#47;em> function. We'll come back to this in part 3 when we make a planet class in Processing. </p>
<p>[code lang="C" gutter="true"]<br />
static int planetset(CSOUND *csound, PLANET *p)<br />
{<br />
    if (*p->iskip==FL(0.0)) {<br />
      p->x  = *p->xval;  p->y  = *p->yval;  p->z  = *p->zval;<br />
      p->vx = *p->vxval; p->vy = *p->vyval; p->vz = *p->vzval;<br />
      p->ax = FL(0.0); p->ay = FL(0.0); p->az = FL(0.0);<br />
      p->hstep = *p->delta;<br />
      p->friction = FL(1.0) - *p->fric&#47;FL(10000.0);<br />
    }<br />
    return OK;<br />
} &#47;* end planetset(p) *&#47;<br />
[&#47;code]</p>
<p>Seeing the code in these three defined sections will help as we translate the Csound audio code to a 3D visual sketch.</p>
<p>Lets go back to the <strong>for<&#47;strong> loop -  our Processing <em>draw()<&#47;em> functton. </p>
<p>excpert of biquad.c<br />
[code gutter="true" firstline="39" collapse="true"]<br />
 for (n=0; n<nsmps; n++) {<br />
      xxpyy = p->x * p->x + p->y * p->y;<br />
      dz1 = p->s1z - p->z;</p>
<p>      &#47;* Calculate Acceleration *&#47;<br />
      sqradius1 = xxpyy + dz1 * dz1 + FL(1.0);<br />
      radius1 = SQRT(sqradius1);<br />
      msqror1 = mass1&#47;sqradius1&#47;radius1;</p>
<p>      p->ax = msqror1 * -p->x;<br />
      p->ay = msqror1 * -p->y;<br />
      p->az = msqror1 * dz1;</p>
<p>      dz2 = p->s2z - p->z;</p>
<p>      &#47;* Calculate Acceleration *&#47;<br />
      sqradius2 = xxpyy + dz2 * dz2 + FL(1.0);<br />
      radius2 = SQRT(sqradius2);<br />
      msqror2 = mass2&#47;sqradius2&#47;radius2;</p>
<p>      p->ax += msqror2 * -p->x;<br />
      p->ay += msqror2 * -p->y;<br />
      p->az += msqror2 * dz2;</p>
<p>      &#47;* Update Velocity *&#47;<br />
      p->vx = fric * p->vx + p->hstep * p->ax;<br />
      p->vy = fric * p->vy + p->hstep * p->ay;<br />
      p->vz = fric * p->vz + p->hstep * p->az;</p>
<p>      &#47;* Update Position *&#47;<br />
      p->x += p->hstep * p->vx;<br />
      p->y += p->hstep * p->vy;<br />
      p->z += p->hstep * p->vz;</p>
<p>      &#47;* Output the results *&#47;<br />
      outx[n] = p->x;<br />
      outy[n] = p->y;<br />
      outz[n] = p->z;<br />
    }<br />
[&#47;code]</p>
<p>Hans was kind enough to comment the 4 overall tasks of this loop.</p>
<p>1. Calculate Acceleration 2. Update Velocity 3.Update Position, 4. Output the results.</p>
<p>Lets start backwards with  # 4.Output the results. and # 3.Update Position</p>
<p>What we need for our Processing sketch is x,y,z positions, so step 4 is idiomatic to Csound, it has its own variable for audio output, our output is a visual screen, so we can delete lines 74-76.</p>
<p>If you're unfamiliar with C then the characters ->, they're <strong>pointers to structure members<&#47;strong>. </p>
<p>We dont need these in Processing. So we can just delete them.</p>
<p>our code with "->" deleted -<br />
[code gutter="true" firstline="39" collapse="true"]<br />
 for (n=0; n<nsmps; n++) {<br />
      xxpyy = x * x + y * y;<br />
      dz1 = s1z - z;</p>
<p>      &#47;* Calculate Acceleration *&#47;<br />
      sqradius1 = xxpyy + dz1 * dz1 + FL(1.0);<br />
      radius1 = SQRT(sqradius1);<br />
      msqror1 = mass1&#47;sqradius1&#47;radius1;</p>
<p>      ax = msqror1 * -x;<br />
      ay = msqror1 * -y;<br />
      az = msqror1 * dz1;</p>
<p>      dz2 = s2z - z;</p>
<p>      &#47;* Calculate Acceleration *&#47;<br />
      sqradius2 = xxpyy + dz2 * dz2 + FL(1.0);<br />
      radius2 = SQRT(sqradius2);<br />
      msqror2 = mass2&#47;sqradius2&#47;radius2;</p>
<p>      ax += msqror2 * -x;<br />
      ay += msqror2 * -y;<br />
      az += msqror2 * dz2;</p>
<p>      &#47;* Update Velocity *&#47;<br />
      vx = fric * vx + hstep * ax;<br />
      vy = fric * vy + hstep * ay;<br />
      vz = fric * vz + hstep * az;</p>
<p>      &#47;* Update Position *&#47;<br />
      x += hstep * vx;<br />
      y += hstep * vy;<br />
      z += hstep * vz;</p>
<p>    }<br />
[&#47;code]</p>
<p>We took the <em>p-><&#47;em> tag off of the following variables - x,y,z,vx,vy,vz,ax,ay,az,s2z,s1z,hsetp. - These will all be declared in the header of our Processing sketch. </p>
<p>We can assume that x,y,z are respective position of type float,<br />
vx,vy,vz are respective velocity also of type float,<br />
ax,ay,az are respective acceleration in float.<br />
And two mystery variables s2z,s1z in float.<br />
These variables will be declared global or outside the scope of Processing's <em>draw() <&#47;em>function.</p>
<p>hstep is the step rate. It scales the speed, so if we need to change how fast the planets are moving, we can edit the value in this variable.</p>
<p>for the variables we should declare inside the draw() function, lets take a look at the stuff outside of the Csound code <em>for<&#47;em> loop. </p>
<p>[code gutter="true" lang="c" firstline="22" highlight="22,23,24,25"]<br />
    MYFLT *outx, *outy, *outz;<br />
    MYFLT   sqradius1, sqradius2, radius1, radius2, fric;<br />
    MYFLT xxpyy, dz1, dz2, mass1, mass2, msqror1, msqror2;<br />
    int n, nsmps = csound->ksmps;</p>
<p>    fric = p->friction;</p>
<p>    outx = p->outx;<br />
    outy = p->outy;<br />
    outz = p->outz;</p>
<p>    p->s1z = *p->sep*FL(0.5);<br />
    p->s2z = -p->s1z;</p>
<p>    mass1 = *p->mass1;<br />
    mass2 = *p->mass2;</p>
<p>[&#47;code]</p>
<p><em>MYFLT<&#47;em> is equivalent to Processing's float type. </p>
<p>Line 22, *outx, *outy and *outz are idiomatic to Csound and not part of the planetary equation. So we can delete line 22. </p>
<p>line 25, n, nsmps = csound->ksmps relate to the for() loop. The part in the Csound C code that is equivilant to Processing's draw(). draw() uses frames and a frame rate, not samples and sample rate; so we can delete line 25 as well.</p>
<p>The highlighted lines </p>
<p>[code gutter="true" lang="c" firstline="22" highlight="27,29,30,31,36,37"]<br />
    MYFLT *outx, *outy, *outz;<br />
    MYFLT   sqradius1, sqradius2, radius1, radius2, fric;<br />
    MYFLT xxpyy, dz1, dz2, mass1, mass2, msqror1, msqror2;<br />
    int n, nsmps = csound->ksmps;</p>
<p>    fric = p->friction;</p>
<p>    outx = p->outx;<br />
    outy = p->outy;<br />
    outz = p->outz;</p>
<p>    p->s1z = *p->sep*FL(0.5);<br />
    p->s2z = -p->s1z;</p>
<p>    mass1 = *p->mass1;<br />
    mass2 = *p->mass2;</p>
<p>[&#47;code]</p>
<p>Like in our for loop excerpt, the variables with p-> will need to be declared globally in the header of our Processing sketch. The ones we haven't declared already are. </p>
<p>float mass1, mass2, fric.  </p>
<p>the lines below can be reworked</p>
<p>[code gutter="true" lang="c" highlight="4,5"]<br />
    MYFLT   sqradius1, sqradius2, radius1, radius2, fric;<br />
    MYFLT xxpyy, dz1, dz2, mass1, mass2, msqror1, msqror2;</p>
<p>    p->s1z = *p->sep*FL(0.5);<br />
    p->s2z = -p->s1z;<br />
[&#47;code]</p>
<p>to </p>
<p>[code gutter="true" lang="c" highlight="4,5"]<br />
    float   sqradius1, sqradius2, radius1, radius2, fric;<br />
    float xxpyy, dz1, dz2, mass1, mass2, msqror1, msqror2;</p>
<p>    s1z = sep*0.5;<br />
    s2z = -s1z;<br />
[&#47;code]</p>
<p><em>sep<&#47;em> is still unaccounted for, it is the <strong>seperation<&#47;strong> of the bodies(in arbitrary range), so we need to declare <em>sep<&#47;em> as a global variable also. </p>
<p>Our Processing code, with all the variables we'll need to run the planetary simulation -</p>
<p>[code lang="cpp" gutter="true" collapse="true"]<br />
import processing.opengl.*;</p>
<p>&#47;&#47;initalize these<br />
float x,<br />
      y,<br />
      z,<br />
     vx,<br />
     vy,<br />
     vz,<br />
   fric,<br />
  hstep,</p>
<p>  mass1,<br />
  mass2,<br />
    sep;</p>
<p>&#47;&#47;no init needed<br />
float ax,<br />
      ay,<br />
      az,<br />
     s2z,<br />
     s1z,<br />
     ss1;</p>
<p>void setup() {<br />
 size (640, 480, OPENGL);<br />
}</p>
<p>void draw() {<br />
    float sqradius1, sqradius2, radius1, radius2;<br />
    float xxpyy, dz1, dz2, msqror1, msqror2;</p>
<p>    s1z = sep*0.5;<br />
    s2z = -s1z;</p>
<p>      xxpyy = x * x + y * y;<br />
      dz1 = s1z - z;</p>
<p>      &#47;* Calculate Acceleration *&#47;<br />
      sqradius1 = xxpyy + dz1 * dz1 + 1.0;<br />
      radius1 = sqrt(sqradius1);<br />
      msqror1 = mass1&#47;sqradius1&#47;radius1;</p>
<p>      ax = msqror1 * -x;<br />
      ay = msqror1 * -y;<br />
      az = msqror1 * dz1;</p>
<p>      dz2 = s2z - z;</p>
<p>      &#47;* Calculate Acceleration *&#47;<br />
      sqradius2 = xxpyy + dz2 * dz2 + 1.0;<br />
      radius2 = sqrt(sqradius2);<br />
      msqror2 = mass2&#47;sqradius2&#47;radius2;</p>
<p>      ax += msqror2 * -x;<br />
      ay += msqror2 * -y;<br />
      az += msqror2 * dz2;</p>
<p>      &#47;* Update Velocity *&#47;<br />
      vx = fric * vx + hstep * ax;<br />
      vy = fric * vy + hstep * ay;<br />
      vz = fric * vz + hstep * az;</p>
<p>      &#47;* Update Position *&#47;<br />
      x += hstep * vx; &#47;&#47;scale these later<br />
      y += hstep * vy; &#47;&#47;<br />
      z += hstep * vz; &#47;&#47;</p>
<p>      println(x);<br />
      translate(x,y,z);<br />
      box(20);<br />
}<br />
[&#47;code]</p>
<p>In Part II, I'll start with an initialized version of this sketch.</p>
