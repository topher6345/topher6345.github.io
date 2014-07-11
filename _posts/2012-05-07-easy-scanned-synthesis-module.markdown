---
layout: post
status: publish
published: true
title: Easy Scanned Synthesis Module
author:
  display_name: Topher
  login: admin
  email: csaunders@berklee.net
  url: http://www.tophersaunders.com
author_login: admin
author_email: csaunders@berklee.net
author_url: http://www.tophersaunders.com
excerpt: "In this article I'll demonstrate how to use an easy scanned synthesis module
  that's as easy to use as the oscil opcode.\r\n\r\nFirst lets review oscil, an elegantly
  simple opcode. It takes just 3 input arguments.\r\n\r\nares oscil xamp, xcps, ifn\r\n\r\nas
  far as Csound opcodes go this is one the most basic. Amplitude, pitch, and waveform
  (f-table) the only three things you need to make it work.\r\n\r\n"
wordpress_id: 861
wordpress_url: http://www.tophersaunders.com/wp/?p=861
date: '2012-05-07 22:05:22 -0700'
date_gmt: '2012-05-08 02:05:22 -0700'
categories:
- Audio
- Code
tags:
- Csound
---
<p>In this article I'll demonstrate how to use an easy scanned synthesis module that's as easy to use as the oscil opcode.</p>
<p>First lets review oscil, an elegantly simple opcode. It takes just 3 input arguments.</p>
<p>ares oscil xamp, xcps, ifn</p>
<p>as far as Csound opcodes go this is one the most basic. Amplitude, pitch, and waveform (f-table) the only three things you need to make it work.</p>
<p><a id="more"></a><a id="more-861"></a></p>
<p>[sourcecode gutter="true"]<br />
<CsoundSynthesizer><br />
<CsOptions><br />
<&#47;CsOptions><br />
<CsInstruments><br />
sr=44100<br />
kr=4410<br />
ksmps=10<br />
nchnls=2<br />
0dbfs=1<br />
gi1 ftgen 1, 0 8192, 10, 1<br />
instr 1<br />
a1 oscil .7 , 440, 1<br />
    outs a1, a1<br />
endin<br />
<&#47;CsInstruments><br />
<CsScore><br />
i 1 0 5<br />
<&#47;CsScore><br />
<&#47;CsoundSynthesizer><br />
[&#47;sourcecode]</p>
<p>The above code plays a simple sine wave at A=440 for 3 seconds. As far as Csound goes it doesn't get any more simple than this, if you don't quite understand this I suggest checking out <a href="http:&#47;&#47;www.csounds.com&#47;chapter1&#47;index.html" target="_blank">Chapter 1<&#47;a> of the Csound Book, kindly made available online for free by Dr. Richard Boulanger. (The physical book is a must for any serious Csounder)</p>
<p>But say you can use the above Csound code but don't exactly get what scanned synthesis is about, well then this article is written for you.</p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;csd&#47;ezScan.zip">ezScan.zip 13.7 Kb<&#47;a></p>
<p>Download the folder, and then run ezScan.csd. Heres what the code looks like</p>
<p>[sourcecode gutter="true"]<br />
<CsoundSynthesizer><br />
<CsOptions><br />
<&#47;CsOptions><br />
<CsInstruments><br />
sr=44100<br />
ksmps=256<br />
nchnls=2<br />
0dbfs= 1<br />
#include "ezScan.h"<br />
#include "ezScan.udo"<br />
instr 1<br />
a1 ezScan .3, 440 ,1<br />
    outs a1, a1<br />
endin<br />
<&#47;CsInstruments><br />
<CsScore><br />
i 1 0 5<br />
<&#47;CsScore><br />
<&#47;CsoundSynthesizer><br />
[&#47;sourcecode]</p>
<p>Here we give the <a href="http:&#47;&#47;en.flossmanuals.net&#47;csound&#47;f-user-defined-opcodes&#47;" target="_blank">user defined opcode<&#47;a> three arguments, the same three arguments we give oscil!</p>
<p>One thing to point out is that you must run this code in the directory ezScan&#47; or Csound will give you all kinds of errors. Thats because of these two lines--</p>
<p>[sourcecode firstline="9" gutter="true"]<br />
#include "ezScan.h"<br />
#include "ezScan.udo"<br />
[&#47;sourcecode]</p>
<p>These lines are critical to running these examples, and using the UDO ezscan. Both of them must be included for a .csd using ezScan. These files tell Csound where to find our f-tables (in ezScan.h) and our UDO (in ezScan.udo) definition.<br />
I'll explain them later in the article.</p>
<p>The usage of the ezScan UDO is</p>
<p>[sourcecode]<br />
ares ezScan kamp, kcps, kmode<br />
[&#47;sourcecode]</p>
<p>kamp, and kcps act just like oscil. kmode is the real "meat" of this whole article though. Instead of a bunch of stuff about tables and profiles and trajectories, I took care of all that, and "saved" it as preset 1. All you have to do is tell ezScan to use preset 1 and it looks up all the other stuff.</p>
<p>It saves us the trouble of setting up 18 arguments, and creating 7 f-tables. Of course, actually using the scanu&#47;scans combination gives us way more flexibility, but before learning how to use that flexibility, it'd be nice to hear scanned synthesis, and maybe use it to craft a MIDI instrument, so we can start using scanned in our sound design arsenal as soon as possible.</p>
<p>The rest of the article gets pretty advanced, but is worth a read if you're trying to learn how to become an expert user of Csound. You have enough to make some simple scores with ezScan, try using presets 2 and 3, notice the timbral range of Scanned Synthesis.</p>
<p>What the argument <em>kmode<&#47;em> does superficially is load an f-table. But you're saying "Wait, I thought Scanned Synthesis required a lot of f-tables?!" Well it does, kmode is an f-table that has the names of the 7 other f-tables to use. These f-tables can be found in the file ezScan.h. (Notice the different extension ezScan<em>.h <&#47;em>and ezScan<em>.udo<&#47;em></p>
<p>It may look scary, but here's what the first preset in ezScan.h looks like.</p>
<p>[sourcecode gutter="true"]<br />
;;ezScan.h<br />
;; Presets of f-tables</p>
<p>#define  N  #1#<br />
#define SIZE #128#</p>
<p>gipos$N.     ftgen 200+8*$N., 0,    $SIZE., 10,   1<br />
gifnvel$N.   ftgen 201+8*$N., 0,    $SIZE., -7,   0,  $SIZE., 0<br />
gifnmass$N.  ftgen 202+8*$N., 0,    $SIZE., -7,   1,  $SIZE., 1<br />
gifnstif$N.  ftgen 203+8*$N., 0,  $SIZE.* $SIZE.,-23,"circularstring-$SIZE."<br />
gifncentr$N. ftgen 204+8*$N., 0,    $SIZE., -7,   0,  $SIZE., 2<br />
gifndamp$N.  ftgen 205+8*$N., 0,    $SIZE., -7,   1,  $SIZE., 1</p>
<p>gifntraj$N.  ftgen 206+8*$N., 0,    $SIZE., -7,   0,  $SIZE., $SIZE.<br />
gid$N. = $N.</p>
<p>gifnptr$N.   ftgen $N., 0 , 8, -2,  gipos$N., gifnvel$N., gifnmass$N.,gifnstif$N., gifncentr$N., gifndamp$N., gifntraj$N., gid$N.</p>
<p>#undef N</p>
<p>#undef SIZE<br />
[&#47;sourcecode]</p>
<p>Wow, cryptic, but if you've read up on Csound's <a href="http:&#47;&#47;booki.flossmanuals.net&#47;csound&#47;macros&#47;" target="_blank">Macro<&#47;a> language extensions, it might make more sense.</p>
<p>But why use macros in the first place? <em>To show off?<&#47;em></p>
<p>Macros let us make a template we can copy and paste <strong>without<&#47;strong> having to meticulously change a lot of values. For example</p>
<p>[sourcecode]<br />
#define A #1#<br />
gifn$A. ftgen $A., 0, 128, 10, 1<br />
#undefine A</p>
<p>#define A #2#<br />
gifn$A. ftgen $A., 0, 128, 10, 1<br />
#undefine A</p>
<p>#define A #3#<br />
gifn$A. ftgen $A., 0, 128, 10, 1<br />
#undefine A</p>
<p>[&#47;sourcecode]</p>
<p>Here all I had to do was write lines 1-3, and copy&#47;paste them, after that all I had to do was change the number inside of the two #'s to change the f-table number and variable name of the f-table. This example may seem redundant, because we generate a sine wave in each one. But if you notice in the file ezScan.h, we use one macro definition to replace the number in many areas.</p>
<p>This allows us to copy&#47;past a template that we can work off. It ends up being a way to "plan ahead" for more presets.</p>
<p>Macros are replaced literally; we can even use it in a variable name like.<br />
[sourcecode]<br />
gipos$N.<br />
[&#47;sourcecode]<br />
In ezScan.h, our ftable number is<br />
[sourcecode]<br />
200+8*$N.<br />
[&#47;sourcecode]<br />
which seems kind of arbitrary, but I start the table at 200 so that one can label 1, and 2 and lower digit f-table numbers without worry that it'll conflict with f-tables needed by ezScanUDO.</p>
<p>Plus an offset determined by the value N multiplied by 8 (the size of how many tables there are total, when copied this means the table numbers won't "step on" each other.</p>
<p>Using macro's this way,I've ensured variables, f-table numbers, and scan id numbers don't "get in the way" of each other when copy&#47;pasted. As long as N is always a unique number, you can copy&#47;paste this template and make as many presets as you want, in an organized way.</p>
<p>Also there is a macro for Size, which gives the user to make presets that use different sizes than 128. Remember that this number must be a power of two or csound will give an error. Equally as crucial, the file circularstring-N must be in the same directory.</p>
<p>[caption id="attachment_877" align="aligncenter" width="333" caption="How the directory should stay organized."]<img class="size-full wp-image-877" title="ezScan Directory" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;05&#47;Screen-shot-2012-05-07-at-9.54.07-PM.png" alt="scanned synthesis" width="333" height="303" &#47;>[&#47;caption]</p>
<p>I've included common power of two sizes in case you want to make templates to experiment, or you can keep this number after you copy paste it.</p>
<p>I just want to point out the idea of a "table of tables." The ftable generated by the following line<br />
[sourcecode gutter="true" firstline="17"]<br />
gifnptr$N. ftgen $N., 0 , 8, -2, gipos$N., gifnvel$N., gifnmass$N.,gifnstif$N., gifncentr$N., gifndamp$N., gifntraj$N., gid$N.<br />
[&#47;sourcecode]<br />
is like a list of all the other tables, packed for our convenience into one number. If a particular UDO is looking for</p>
<p>"a number, that is the ftable number generated to be a list of other valid ftable numbers generated earlier"</p>
<p>an f-table of names of other ftables.</p>
<p>there are alot of ways to think about this. ONe of the most helpful ways is using C and arrays and pointers.</p>
<p>We think of the ftable number as the <em>address<&#47;em>. For example, the number 1 as kmode is not what ezScan uses directly. It needs more than just the value 1. But the number 1 tells where the to go to ge a list of more useful information. And that information is not waveforms, but rather a number that tells ezScan where to go to find values of the waveform. In C programming this is a "pointer to an array of pointers."</p>
<p>An analogy: The number of a mailbox full of slips of paper with other mailbox numbers on them. Inside those other mailboxes there are the actual numbers we need. The mailman must know what to do with the just one number. Luckily in the UDO, I've arranged a smart mailman using the table opcode.</p>
<p>[sourcecode]<br />
opcode ezScan, a, kki<br />
kamp, kcps, ifnp xin</p>
<p>ifinit    table 0,ifnp<br />
ifnvel   table 1,ifnp<br />
ifnmass  table 2,ifnp<br />
ifnstif  table 3,ifnp<br />
ifncentr table 4,ifnp<br />
ifndamp  table 5,ifnp<br />
ifntraj  table 6,ifnp<br />
id       table 7,ifnp</p>
<p>irate = .005<br />
imass = 2<br />
istif = 1.1<br />
icentr = .1<br />
idamp = -0.01<br />
ileft = 0.<br />
iright = .5<br />
ipos = 0.<br />
istrngth = 0.<br />
ain = 0<br />
idisp = 0<br />
;scanu ipos, irate, ifnvel, ifnmass, ifnstif, ifncentr, ifndamp, imass,  istif, icentr, idamp, ileft, iright, ipos, istrngth, ain, idisp, id<br />
scanu ifinit, irate, ifnvel, ifnmass, ifnstif, ifncentr, ifndamp, imass,  istif, icentr, idamp, ileft, iright, ipos, istrngth, ain, idisp, id</p>
<p>;scanu	1,.007,6,2,3,4,5, 2, 1.10 ,.10 ,0 ,.1 ,.5, 0, 0,ain,1,2;<br />
a1 scans kamp, kcps, ifntraj, id, 4<br />
a1 dcblock a1<br />
xout a1<br />
endop<br />
[&#47;sourcecode]</p>
<p>lines 3-11, the table opcode<br />
[sourcecode]<br />
ires table indx, ifn<br />
[&#47;sourcecode]</p>
<p>says "I will look in table <em>ifn<&#47;em>, take the <em>indx<&#47;em> value and put that into <em>ires<&#47;em>.</p>
<p>This is our way to "unpack" our list</p>
<p>[sourcecode]<br />
ifinit   table 0,ifnp<br />
ifnvel   table 1,ifnp<br />
ifnmass  table 2,ifnp<br />
ifnstif  table 3,ifnp<br />
ifncentr table 4,ifnp<br />
ifndamp  table 5,ifnp<br />
ifntraj  table 6,ifnp<br />
id       table 7,ifnp<br />
[&#47;sourcecode]</p>
<p>all the f-tables we need squished into 1 number.</p>
<p>Hopefully you've learned a couple strategies for making your own .udo and .h files. This is an efficient (an easy to share) way of organizing your instruments in the Csound orchestra. Write instruments once instead for every .csd. You could slowly add more features to the UDO as your understanding of scanned synthesis increases. For example heres our mod to ezScan with a k-rate centering control, I call it ezScanC.</p>
<p>[sourcecode]<br />
opcode ezScanC, a, kkik<br />
kamp, kcps, ifnp, kcentr xin</p>
<p>ifinit    table 0,ifnp<br />
ifnvel   table 1,ifnp<br />
ifnmass  table 2,ifnp<br />
ifnstif  table 3,ifnp<br />
ifncentr table 4,ifnp<br />
ifndamp  table 5,ifnp<br />
ifntraj  table 6,ifnp<br />
id       table 7,ifnp</p>
<p>irate = .005<br />
imass = 2<br />
istif = 1.1<br />
kcentr = .1<br />
idamp = -0.01<br />
ileft = 0.<br />
iright = .5<br />
ipos = 0.<br />
istrngth = 0.<br />
ain = 0<br />
idisp = 0<br />
scanu ifinit, irate, ifnvel, ifnmass, ifnstif, ifncentr, ifndamp, imass,  istif, kcentr, idamp, ileft, iright, ipos, istrngth, ain, idisp, id</p>
<p>a1 scans kamp, kcps, ifntraj, id, 4<br />
a1 dcblock a1<br />
xout a1<br />
endop<br />
[&#47;sourcecode]</p>
<p>and its usage</p>
<p>[sourcecode gutter="true"]<br />
<CsoundSynthesizer><br />
<CsOptions><br />
<&#47;CsOptions><br />
<CsInstruments><br />
sr=44100<br />
ksmps=256<br />
nchnls=2<br />
0dbfs= 1<br />
#include "ezScan.h"<br />
#include "ezScanC.udo"<br />
instr 1<br />
kamp       = .7<br />
kcps       = 440<br />
kmode     = 1<br />
kcentering =  .2<br />
a1 ezScanC kamp, kcps, kmode, kcentering<br />
    outs a1, a1<br />
endin<br />
<&#47;CsInstruments><br />
<CsScore><br />
i 1 0 5<br />
<&#47;CsScore><br />
<&#47;CsoundSynthesizer><br />
[&#47;sourcecode]</p>
