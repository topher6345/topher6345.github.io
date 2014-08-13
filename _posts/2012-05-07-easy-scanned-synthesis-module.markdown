---
layout: post
status: publish
published: true
title: Easy Scanned Synthesis Module
author: Topher
date: '2012-05-07 22:05:22 -0700'
categories:
- Audio
- Code
tags:
- Csound
---

In this article I'll demonstrate how to use an easy scanned synthesis module that's as easy to use as the oscil opcode.

First lets review oscil, an elegantly simple opcode. It takes just 3 input arguments.

ares oscil xamp, xcps, ifn

as far as Csound opcodes go this is one the most basic. Amplitude, pitch, and waveform (f-table) the only three things you need to make it work.

[]()[]()

[sourcecode gutter="true"]



sr=44100


kr=4410


ksmps=10


nchnls=2


0dbfs=1


gi1 ftgen 1, 0 8192, 10, 1


instr 1


a1 oscil .7 , 440, 1


    outs a1, a1


endin






i 1 0 5








[/sourcecode]

The above code plays a simple sine wave at A=440 for 3 seconds. As far as Csound goes it doesn't get any more simple than this, if you don't quite understand this I suggest checking out 
[Chapter 1 of the Csound Book, kindly made available online for free by Dr. Richard Boulanger. (The physical book is a must for any serious Csounder)](http://www.csounds.com/chapter1/index.html)

But say you can use the above Csound code but don't exactly get what scanned synthesis is about, well then this article is written for you.

[ezScan.zip 13.7 Kb](http://www.tophersaunders.com/csd/ezScan.zip)

Download the folder, and then run ezScan.csd. Heres what the code looks like

[sourcecode gutter="true"]



sr=44100


ksmps=256


nchnls=2


0dbfs= 1


#include "ezScan.h"


#include "ezScan.udo"


instr 1


a1 ezScan .3, 440 ,1


    outs a1, a1


endin






i 1 0 5








[/sourcecode]

Here we give the 
[user defined opcode three arguments, the same three arguments we give oscil!](http://en.flossmanuals.net/csound/f-user-defined-opcodes/)

One thing to point out is that you must run this code in the directory ezScan/ or Csound will give you all kinds of errors. Thats because of these two lines--

[sourcecode firstline="9" gutter="true"]


#include "ezScan.h"


#include "ezScan.udo"


[/sourcecode]

These lines are critical to running these examples, and using the UDO ezscan. Both of them must be included for a .csd using ezScan. These files tell Csound where to find our f-tables (in ezScan.h) and our UDO (in ezScan.udo) definition.


I'll explain them later in the article.

The usage of the ezScan UDO is

[sourcecode]


ares ezScan kamp, kcps, kmode


[/sourcecode]

kamp, and kcps act just like oscil. kmode is the real "meat" of this whole article though. Instead of a bunch of stuff about tables and profiles and trajectories, I took care of all that, and "saved" it as preset 1. All you have to do is tell ezScan to use preset 1 and it looks up all the other stuff.

It saves us the trouble of setting up 18 arguments, and creating 7 f-tables. Of course, actually using the scanu/scans combination gives us way more flexibility, but before learning how to use that flexibility, it'd be nice to hear scanned synthesis, and maybe use it to craft a MIDI instrument, so we can start using scanned in our sound design arsenal as soon as possible.

The rest of the article gets pretty advanced, but is worth a read if you're trying to learn how to become an expert user of Csound. You have enough to make some simple scores with ezScan, try using presets 2 and 3, notice the timbral range of Scanned Synthesis.

What the argument 
kmode does superficially is load an f-table. But you're saying "Wait, I thought Scanned Synthesis required a lot of f-tables?!" Well it does, kmode is an f-table that has the names of the 7 other f-tables to use. These f-tables can be found in the file ezScan.h. (Notice the different extension ezScan
.h and ezScan
.udo

It may look scary, but here's what the first preset in ezScan.h looks like.

[sourcecode gutter="true"]


;;ezScan.h


;; Presets of f-tables

#define  N  #1#


#define SIZE #128#

gipos$N.     ftgen 200+8*$N., 0,    $SIZE., 10,   1


gifnvel$N.   ftgen 201+8*$N., 0,    $SIZE., -7,   0,  $SIZE., 0


gifnmass$N.  ftgen 202+8*$N., 0,    $SIZE., -7,   1,  $SIZE., 1


gifnstif$N.  ftgen 203+8*$N., 0,  $SIZE.* $SIZE.,-23,"circularstring-$SIZE."


gifncentr$N. ftgen 204+8*$N., 0,    $SIZE., -7,   0,  $SIZE., 2


gifndamp$N.  ftgen 205+8*$N., 0,    $SIZE., -7,   1,  $SIZE., 1

gifntraj$N.  ftgen 206+8*$N., 0,    $SIZE., -7,   0,  $SIZE., $SIZE.


gid$N. = $N.

gifnptr$N.   ftgen $N., 0 , 8, -2,  gipos$N., gifnvel$N., gifnmass$N.,gifnstif$N., gifncentr$N., gifndamp$N., gifntraj$N., gid$N.

#undef N

#undef SIZE


[/sourcecode]

Wow, cryptic, but if you've read up on Csound's 
[Macro language extensions, it might make more sense.](http://booki.flossmanuals.net/csound/macros/)

But why use macros in the first place? 
To show off?

Macros let us make a template we can copy and paste 
**without having to meticulously change a lot of values. For example**

[sourcecode]


#define A #1#


gifn$A. ftgen $A., 0, 128, 10, 1


#undefine A

#define A #2#


gifn$A. ftgen $A., 0, 128, 10, 1


#undefine A

#define A #3#


gifn$A. ftgen $A., 0, 128, 10, 1


#undefine A

[/sourcecode]

Here all I had to do was write lines 1-3, and copy/paste them, after that all I had to do was change the number inside of the two #'s to change the f-table number and variable name of the f-table. This example may seem redundant, because we generate a sine wave in each one. But if you notice in the file ezScan.h, we use one macro definition to replace the number in many areas.

This allows us to copy/past a template that we can work off. It ends up being a way to "plan ahead" for more presets.

Macros are replaced literally; we can even use it in a variable name like.


[sourcecode]


gipos$N.


[/sourcecode]


In ezScan.h, our ftable number is


[sourcecode]


200+8*$N.


[/sourcecode]


which seems kind of arbitrary, but I start the table at 200 so that one can label 1, and 2 and lower digit f-table numbers without worry that it'll conflict with f-tables needed by ezScanUDO.

Plus an offset determined by the value N multiplied by 8 (the size of how many tables there are total, when copied this means the table numbers won't "step on" each other.

Using macro's this way,I've ensured variables, f-table numbers, and scan id numbers don't "get in the way" of each other when copy/pasted. As long as N is always a unique number, you can copy/paste this template and make as many presets as you want, in an organized way.

Also there is a macro for Size, which gives the user to make presets that use different sizes than 128. Remember that this number must be a power of two or csound will give an error. Equally as crucial, the file circularstring-N must be in the same directory.

[caption id="attachment_877" align="aligncenter" width="333" caption="How the directory should stay organized."]
![scanned synthesis](http://www.tophersaunders.com/wp/wp-content/uploads/2012/05/Screen-shot-2012-05-07-at-9.54.07-PM.png)[/caption]

I've included common power of two sizes in case you want to make templates to experiment, or you can keep this number after you copy paste it.

I just want to point out the idea of a "table of tables." The ftable generated by the following line


[sourcecode gutter="true" firstline="17"]


gifnptr$N. ftgen $N., 0 , 8, -2, gipos$N., gifnvel$N., gifnmass$N.,gifnstif$N., gifncentr$N., gifndamp$N., gifntraj$N., gid$N.


[/sourcecode]


is like a list of all the other tables, packed for our convenience into one number. If a particular UDO is looking for

"a number, that is the ftable number generated to be a list of other valid ftable numbers generated earlier"

an f-table of names of other ftables.

there are alot of ways to think about this. ONe of the most helpful ways is using C and arrays and pointers.

We think of the ftable number as the 
address. For example, the number 1 as kmode is not what ezScan uses directly. It needs more than just the value 1. But the number 1 tells where the to go to ge a list of more useful information. And that information is not waveforms, but rather a number that tells ezScan where to go to find values of the waveform. In C programming this is a "pointer to an array of pointers."

An analogy: The number of a mailbox full of slips of paper with other mailbox numbers on them. Inside those other mailboxes there are the actual numbers we need. The mailman must know what to do with the just one number. Luckily in the UDO, I've arranged a smart mailman using the table opcode.

[sourcecode]


opcode ezScan, a, kki


kamp, kcps, ifnp xin

ifinit    table 0,ifnp


ifnvel   table 1,ifnp


ifnmass  table 2,ifnp


ifnstif  table 3,ifnp


ifncentr table 4,ifnp


ifndamp  table 5,ifnp


ifntraj  table 6,ifnp


id       table 7,ifnp

irate = .005


imass = 2


istif = 1.1


icentr = .1


idamp = -0.01


ileft = 0.


iright = .5


ipos = 0.


istrngth = 0.


ain = 0


idisp = 0


;scanu ipos, irate, ifnvel, ifnmass, ifnstif, ifncentr, ifndamp, imass,  istif, icentr, idamp, ileft, iright, ipos, istrngth, ain, idisp, id


scanu ifinit, irate, ifnvel, ifnmass, ifnstif, ifncentr, ifndamp, imass,  istif, icentr, idamp, ileft, iright, ipos, istrngth, ain, idisp, id

;scanu	1,.007,6,2,3,4,5, 2, 1.10 ,.10 ,0 ,.1 ,.5, 0, 0,ain,1,2;


a1 scans kamp, kcps, ifntraj, id, 4


a1 dcblock a1


xout a1


endop


[/sourcecode]

lines 3-11, the table opcode


[sourcecode]


ires table indx, ifn


[/sourcecode]

says "I will look in table 
ifn, take the 
indx value and put that into 
ires.

This is our way to "unpack" our list

[sourcecode]


ifinit   table 0,ifnp


ifnvel   table 1,ifnp


ifnmass  table 2,ifnp


ifnstif  table 3,ifnp


ifncentr table 4,ifnp


ifndamp  table 5,ifnp


ifntraj  table 6,ifnp


id       table 7,ifnp


[/sourcecode]

all the f-tables we need squished into 1 number.

Hopefully you've learned a couple strategies for making your own .udo and .h files. This is an efficient (an easy to share) way of organizing your instruments in the Csound orchestra. Write instruments once instead for every .csd. You could slowly add more features to the UDO as your understanding of scanned synthesis increases. For example heres our mod to ezScan with a k-rate centering control, I call it ezScanC.

[sourcecode]


opcode ezScanC, a, kkik


kamp, kcps, ifnp, kcentr xin

ifinit    table 0,ifnp


ifnvel   table 1,ifnp


ifnmass  table 2,ifnp


ifnstif  table 3,ifnp


ifncentr table 4,ifnp


ifndamp  table 5,ifnp


ifntraj  table 6,ifnp


id       table 7,ifnp

irate = .005


imass = 2


istif = 1.1


kcentr = .1


idamp = -0.01


ileft = 0.


iright = .5


ipos = 0.


istrngth = 0.


ain = 0


idisp = 0


scanu ifinit, irate, ifnvel, ifnmass, ifnstif, ifncentr, ifndamp, imass,  istif, kcentr, idamp, ileft, iright, ipos, istrngth, ain, idisp, id

a1 scans kamp, kcps, ifntraj, id, 4


a1 dcblock a1


xout a1


endop


[/sourcecode]

and its usage

[sourcecode gutter="true"]



sr=44100


ksmps=256


nchnls=2


0dbfs= 1


#include "ezScan.h"


#include "ezScanC.udo"


instr 1


kamp       = .7


kcps       = 440


kmode     = 1


kcentering =  .2


a1 ezScanC kamp, kcps, kmode, kcentering


    outs a1, a1


endin






i 1 0 5








[/sourcecode]
