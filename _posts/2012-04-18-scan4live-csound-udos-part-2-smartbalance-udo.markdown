---
layout: post
status: publish
published: true
title: Scanned Synthesis Modules Part 2 - Amplitude Control
author: Topher
date: '2012-04-18 15:48:44 -0700'
categories:
- Audio
- Code
tags:
- Csound
---

In this article I'll demonstrate a way you can keep 
[scanned synthesis from blowing out your speakers and eardrums! I'll give some audio and working .csd examples of how I solved the problem when designing and testing Scan4Live in Csound.](http://www.csounds.com/scanned/toot/index.html)

[]()[]()

In computing, greater flexibility (and thus greater creative possibility) comes at a price of greater complexity and greater possibility of 
**fatal errors.**

In Csound this means you might accidentally code something that will send an enormously loud signal to your speakers! Dr. B explains this concept very well in 
[Chapter 1 of the Csound book. But we're talking about a situation where simply turning down the volume 
**wont help. (More on why later)**](http://www.csounds.com/chapter1/index.html#AmplitudesAndClipping)

Here's an example of some Csound code that can be tamed with the smartBalance 
[user-defined opcode



**The following .csd WILL blow up your speakers. 



(I suggest running it on a rival DJ's computer)**](http://en.flossmanuals.net/csound/ch021_f-user-defined-opcodes/)

[sourcecode]


; SmartBalance UDO example


;www.tophersaunders.com/wp



nchnls = 2


sr = 44100


ksmps = 256


0dbfs = 1


; NOTE THIS CSD WILL NOT RUN UNLESS


;IT IS IN THE SAME FOLDER AS THE FILE "STRING-128"


instr 1


ipos     ftgen 1, 0, 128  ,  10, 1


irate = .007


ifnvel   ftgen 6, 0, 128  ,  -7, 0, 128, 0.1


ifnmass  ftgen 2, 0, 128  ,  -7, 1, 128, 1


ifnstif  ftgen 3, 0, 16384, -23, "string-128"


ifncentr ftgen 4, 0, 128  ,  -7, 1, 128, 2


ifndamp  ftgen 5, 0, 128  ,  -7, 1, 128, 1

kmass = 1


kstif = 0.1


kcentr = .01


kdamp = 1

ileft = 0


iright = 1


kpos = 0


kstrngth = 0.


ain = 0


idisp = 1


id = 22


scanu ipos, irate, ifnvel, ifnmass, \


ifnstif, ifncentr, ifndamp, kmass,  \


kstif, kcentr, kdamp, ileft, iright,\


kpos, kstrngth, ain, idisp, id


kamp = 0dbfs*.2


kfreq = 200


ifn ftgen 7, 0, 128, -5, .001, 128, 128.


a1 scans kamp, kfreq, ifn, id


a1 dcblock2 a1


iatt = .005


idec = 1


islev = 1


irel = 2


aenv adsr iatt, idec, islev, irel


	outs		a1*aenv,a1*aenv


	endin






f8 0 8192 10 1;


i 1 0 5








[/sourcecode]

[scanBLOWS_UP.zip](http://www.tophersaunders.com/csd/scan_blows_up.zip)

The problem is in this line of code



kdamp = .1

.1 is not exactly a "safe" value for this argument, in fact, any value above 0 for this argument will cause chaos. You say "But I didn't know! The manual and tutorials never said anything about what ranges make the thing to go crazy!" Good thing you found this article!

I hate to ruin it for you, its actually impossible to determine in such a complicated system what are "safe" ranges for values like this. It would take a skilled mathematician to map out safe possible ranges for all the arguments of scanu. I figured out these values through a mix of trial and error and studying other folk's code. Yup, this is the closest you'll ever get to someone saying "Here are some plug-and-play numbers for you scanned synthesis pleasure."

The argument kdamp was put into the opcode scanu, so that the user can interact with the mass and spring system, by updating the value at the control rate. If we make this value a safe constant. like



kdamp = -0.01





We end up with a stable sound, but completely ignore the expressive capabilities scanned synthesis provides. This value could (and should) be updated at the control rate!

So let's find a suitable range of values and then map our controller to those values

Example:



kdamp midic7 ictlno, -1. , -0.01

Now time to take over the world with scanned synthesis, right? However, move that knob fast enough back and forth and you'll get an eventual blow up. "Back to the drawing board."

It turns out the scanned synthesis model's stability is not just influenced by values given, 
**but also the rate at which values change.**

Lets try taming audio levels, something Csound, 
is very good at.

Csound has an opcode that could help us out. 
[balance
ares balance asig, acomp](http://www.csounds.com/manual/html/balance.html)

Where asig is the audio we want to tame


acomp is a signal we know and trust (a sine wave oscillator works great at this)


and ares is asig but with the amplitude values of acomp.

[sourcecode]


; SmartBalance UDO example


;www.tophersaunders.com/wp



nchnls = 2


sr = 44100


ksmps = 256


0dbfs = 1


; NOTE THIS CSD WILL NOT RUN UNLESS


;IT IS IN THE SAME FOLDER AS THE FILE "STRING-128"


instr 1


ipos     ftgen 1, 0, 128  ,  10, 1


irate = .007


ifnvel   ftgen 6, 0, 128  ,  -7, 0, 128, 0.1


ifnmass  ftgen 2, 0, 128  ,  -7, 1, 128, 1


ifnstif  ftgen 3, 0, 16384, -23, "string-128"


ifncentr ftgen 4, 0, 128  ,  -7, 1, 128, 2


ifndamp  ftgen 5, 0, 128  ,  -7, 1, 128, 1

kmass = 1


kstif = 0.1


kcentr = .01


kdamp = -0.01

ileft = 0


iright = 1


kpos = 0


kstrngth = 0.


ain = 0


idisp = 1


id = 22


scanu ipos, irate, ifnvel, ifnmass, \


ifnstif, ifncentr, ifndamp, kmass,  \


kstif, kcentr, kdamp, ileft, iright,\


kpos, kstrngth, ain, idisp, id


kamp = 0dbfs*.2


kfreq = 200


ifn ftgen 7, 0, 128, -5, .001, 128, 128.


a1 scans kamp, kfreq, ifn, id


a1 dcblock2 a1


ifnsine ftgen 8, 0, 8192, 10, 1


a2 oscil kamp, kfreq, ifnsine


a1 balance a1, a2


iatt = .005


idec = 1


islev = 1


irel = 2


aenv adsr iatt, idec, islev, irel


	outs		a1*aenv,a1*aenv


	endin






f8 0 8192 10 1;


i 1 0 5








[/sourcecode]

[scan_safe.zip](http://www.tophersaunders.com/csd/scanSafe.zip)

No warnings, no broken speakers, no tinnitus.

However, we still have a loud click at the beginning of the note.

This click is there because it takes the balance opcode a couple milliseconds to calculate the rms amplitude of the safe signal.

So what we need to is start with just enough problem signal to create an attack, and quickly mix in the balanced signal and quickly mix out the ultra loud signal (it takes it a couple milliseconds to get out of control).

[sourcecode]


ab balance a1, a2


amix linseg .001, iatt+.0000001, 1 , 1, 1


aout = ab*(amix) + a1*(1-amix)


[/sourcecode]

And an example of the .udo in action

[sourcecode]


; SmartBalance UDO example


;www.tophersaunders.com/wp



nchnls = 2


sr = 44100


ksmps = 256


0dbfs = 1


; NOTE THIS CSD WILL NOT RUN UNLESS


;IT IS IN THE SAME FOLDER AS THE FILE "STRING-128"


#include "smartBalance.udo";


instr 1


ipos     ftgen 1, 0, 128  ,  10, 1


irate = .007


ifnvel   ftgen 6, 0, 128  ,  -7, 0, 128, 0.1


ifnmass  ftgen 2, 0, 128  ,  -7, 1, 128, 1


ifnstif  ftgen 3, 0, 16384, -23, "string-128"


ifncentr ftgen 4, 0, 128  ,  -7, 1, 128, 2


ifndamp  ftgen 5, 0, 128  ,  -7, 1, 128, 1

kmass = 1


kstif = 0.1


kcentr = .01


kdamp = .1

ileft = 0


iright = 1


kpos = 0


kstrngth = 0.


ain = 0


idisp = 1


id = 22


scanu ipos, irate, ifnvel, ifnmass, \


ifnstif, ifncentr, ifndamp, kmass,  \


kstif, kcentr, kdamp, ileft, iright,\


kpos, kstrngth, ain, idisp, id


kamp = 0dbfs*.2


kfreq = 200


ifn ftgen 7, 0, 128, -5, .001, 128, 128.


a1 scans kamp, kfreq, ifn, id


a1 dcblock2 a1


ifnsine ftgen 8, 0, 8192, 10, 1


a2 oscil kamp, kfreq, ifnsine


iatt = .05


a1 smartBalance a1, a2, iatt+.2


idec = 1


islev = 1


irel = 2


aenv adsr iatt, idec, islev, irel


	outs		a1*aenv,a1*aenv


	endin






f8 0 8192 10 1;


i 1 0 5








[/sourcecode]

*Update April 18, 2012*


Well it turns out this method still *exasperated sigh* will blow up if you hold a note for about 2 minutes straight. My hypothesis is that this has to do with trying to store a continously increasing floating point number, after a while it reaches beyond the 32-bit word size.  I haven't been able to re-create this problem with csound running in 64-bit.](\"http://www.csounds.com/scanned/toot/index.html\")
