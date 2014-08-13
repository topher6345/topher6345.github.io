---
layout: post
status: publish
published: true
title: Modular Filter Bank Audio Effect
author: Topher
date: '2012-05-16 23:25:59 -0700'
date_gmt: '2012-05-17 03:25:59 -0700'
categories:
- Audio
- Code
tags:
- Csound
---

This article is about how you can use a bank of tunable high-resonance bandpass filters (inspired by 
[Max Mathews' Phaser Filters) in Csound to make some pretty awesome sounds.](http://www.csounds.com/max/index.html)

[]()[]()

[FilterBank6.zip 4 kB](http://www.tophersaunders.com/csd/FilterBank6.zip)

Your browser does not support the audio tag.





FilterBank6.csd


[sourcecode gutter="true" collapse="true"]


; Phaser Filter Emulation


;www.tophersaunders.com/wp



sr=44100


ksmps=10


nchnls=2


0dbfs=1


gipitchtable ftgen 44, 0, -6, -2 , 60, 65, 70, 75, 80, 85


gimorph1 ftgen 4, 0, -6, -2 , 60, 65, 70, 75, 80, 85


gimorph2 ftgen 5, 0, -6, -2 , 60, 64, 67, 71, 74, 79


giftfn  ftgen 9, 0, 2, -2, gimorph1 , gimorph2


instr 1


ain pinkish .8


kftndx line 0, p3, 1


ftmorf kftndx, giftfn, gipitchtable


#define K #1#


kcf$K. table $K., gipitchtable


a$K. reson ain, cpsmidinn(kcf$K.), 15


#undef K


#define K #2#


kcf$K. table $K., gipitchtable


a$K. reson ain, cpsmidinn(kcf$K.), 15


#undef K


#define K #3#


kcf$K. table $K., gipitchtable


a$K. reson ain, cpsmidinn(kcf$K.), 15


#undef K


#define K #4#


kcf$K. table $K., gipitchtable


a$K. reson ain, cpsmidinn(kcf$K.), 15


#undef K


#define K #5#


kcf$K. table $K., gipitchtable


a$K. reson ain, cpsmidinn(kcf$K.), 15


#undef K


#define K #6#


kcf$K. table $K., gipitchtable


a$K. reson ain, cpsmidinn(kcf$K.), 15


#undef K


ares = a1+a2+a3+a4+a5+a6


asig balance ares, ain


asig dcblock2 asig


    outs asig, asig


endin






i 1 0 10








[/sourcecode]

Unlike some of my previous Csound tutorials, this example will run if you copy/paste the above code, no extra files are needed.

The key opcode in this .csd is 
reson.  The usage of 
[reson is simple, it takes 3 input arguments and outputs a filtered audio signal.](http://www.csounds.com/manual/html/reson.html)

[sourcecode]


ares reson asig, kcf, kbw


[/sourcecode]

asig is our singal that we want to filter



kcf is our center frequency of the filter


and 
kbw is how wide, in Hz, we want the bandwidth of the filter to be.

The way I use it in my .csd is I use a couple variables and macros to make the chunk of code easier to copy/paste.

[sourcecode gutter="true" firstline="19"]


#define K #1#


kcf$K. table $K., gipitchtable


a$K. reson ain, cpsmidinn(kcf$K.), 15


#undef K


[/sourcecode]

lets look at line 21 first, the line where we use the reson opcode.



ain is our input signal



cpsmidinn(kcf$K.) converts a MIDI note stored into a table to a frequency in Hz value to tell where the center frequency of our bandpass filter.


and 
15 is our bandwidth in Hz.

the line above that 
20, reads from a table of stored MIDI note values, an easier way to store the frequency we want to tune the bandpass filter to rather than specifying the exact frequency in Hz.

The #define at the top is a little trick to allow us to copy/paste all four lines (line 19-23) as many times as we want, and it will be all ready and set up to go, as long as we change the number in between the two #'s.  To see another, more in-depth explanation of this trick, check out my article on
[a Scanned Synthesis UDO](http://www.tophersaunders.com/wp/?p=861)

I made this 4 lines of code a "template", and then copy/pasted it 5 more times to create 6 band pass filters.

Our audio signal processed by all these filters is 
ain, in this case pink noise, generated on line 16.

[sourcecode gutter="true" firstline="16"]


ain pinkish .8


[/sourcecode]

You could assign any audio signal to ain to process a sample, or incoming audio from your audio interface.

So we send this signal through 6 filters, and mix them together with simple addition on line 43.

[sourcecode gutter="true" firstline="43"]


ares = a1+a2+a3+a4+a5+a6


[/sourcecode]

resonate bandpass filters are notorious for generating extreme amplitudes, to tame this we can use the 
balance opcode to scale the filtered sound to the amplitude level of the input sound, ain.

[sourcecode gutter="true" firstline="44"]


asig balance ares, ain


[/sourcecode]

and for good measure, we dcblock the sound before we output it.

[sourcecode gutter="true" firstline="45"]


asig dcblock2 asig


    outs asig, asig


[/sourcecode]

Now I'll show you how to store center frequency values for each of the resonate bandpass filters in a table.

[sourcecode gutter="true" firstline="11"]


gipitchtable ftgen 44, 0, -6, -2 , 60, 65, 70, 75, 80, 85


[/sourcecode]

44 is arbitrary, I like to use higher numbers so that the user can modify the .csd and use ftable numbers like 1 or 2 without stepping on the ones built into the .csd.

our size is 6, in Csound when want to create an ftable thats not a power of 2 (2,4,8,16 etc.) one must specify the size as negative. Hence our p3 field is -6. The GEN routine used is GEN 2, which allows us to fill the table with arbitrary value, again this time negative, meaning that we bypass the ftable's default behavior to normalize the values.

This list of frequencies is fine, but wouldn't it be cool if we could morph between values using the 
ftmorf opcode and add motion to the sound?

We can do this in 3 steps.

Step 1. "allocate" an initial table

[sourcecode gutter="true" firstline="11"]


gipitchtable ftgen 44, 0, -6, -2 , 60, 65, 70, 75, 80, 85


[/sourcecode]

We already did this by generating this table. This is our starter table, just in case something goes wrong with the morphing, Csound will still have legitimate values to work with.

The next lines create ftables in a similar way.

The first one creates a 6 voice stacked fourths chord on C (its the same as our intial table)

[sourcecode gutter="true" firstline="12"]


gimorph1 ftgen 4, 0, -6, -2 , 60, 65, 70, 75, 80, 85


[/sourcecode]

The next is a C major chord.


[sourcecode gutter="true" firstline="13"]


gimorph2 ftgen 5, 0, -6, -2 , 60, 64, 67, 71, 74, 79


[/sourcecode]

in order to use 
ftmorf we have to give it a table of tables.  This concept is kind of confusing. I tried to make it simpler by using variable names instead of ftable numbers. Hopefully this is clear, we are filling a table with table numbers of other tables.

[sourcecode gutter="true" firstline="14"]


giftfn  ftgen 9, 0, 2, -2, gimorph1 , gimorph2


[/sourcecode]

this is the ftable we will use with 
ftmorf.

[sourcecode gutter="true" firstline="18"]


ftmorf kftndx, giftfn, gipitchtable


[/sourcecode]

ftmorf will change the values of the table 
gipitchtable by morphing between the tables in 
giftfn (remember this is a table of table numbers). We do this by giving a floating point value to 
kftndx.

For example if 
kftndx is 0.0, then the contents of 
gipitchtable(used by our bandpass filters) will be the first table in 
giftfn, which is the table 
gimorph1. Likewise if 
kftndx is 1.0 then the contents of 
gipitchtable will be the same as 
gimorph2.  If 
kftndx is .5, 
ftmorf will interpolate or "morph" between 
gimorph1 and 
gimorph2.

to "morph" between the two, we can use the line opcode...

[sourcecode gutter="true" firstline="17"]


kftndx line 0, p3, 1


[/sourcecode]

to draw a line or "interpolate" between the two tables.

In an early draft of the .csd I used the following line instead


[sourcecode gutter="true" firstline="17"]


kftndx invalue "morph"


[/sourcecode]

so that I could use a CsoundQt slider widget to "morph" between the tables.  The slider's output would, of course, have to be set in the range of 0. to 1.](\"http://www.csounds.com/max/index.html\")
