---
layout: post
status: publish
published: true
title: Scanned Synthesis Modules Part 2 - Amplitude Control
author:
  display_name: Topher
  login: admin
  email: csaunders@berklee.net
  url: http://www.tophersaunders.com
author_login: admin
author_email: csaunders@berklee.net
author_url: http://www.tophersaunders.com
excerpt: "In this article I'll demonstrate a way you can keep <a href=\"http:&#47;&#47;www.csounds.com&#47;scanned&#47;toot&#47;index.html\"
  target=\"_blank\">scanned synthesis<&#47;a> from blowing out your speakers and eardrums!
  I'll give some audio and working .csd examples of how I solved the problem when
  designing and testing Scan4Live in Csound.\r\n\r\n"
wordpress_id: 672
wordpress_url: http://www.tophersaunders.com/wp/?p=672
date: '2012-04-18 15:48:44 -0700'
date_gmt: '2012-04-18 19:48:44 -0700'
categories:
- Audio
- Code
tags:
- Csound
---
<p>In this article I'll demonstrate a way you can keep <a href="http:&#47;&#47;www.csounds.com&#47;scanned&#47;toot&#47;index.html" target="_blank">scanned synthesis<&#47;a> from blowing out your speakers and eardrums! I'll give some audio and working .csd examples of how I solved the problem when designing and testing Scan4Live in Csound.</p>
<p><a id="more"></a><a id="more-672"></a></p>
<p>In computing, greater flexibility (and thus greater creative possibility) comes at a price of greater complexity and greater possibility of <strong>fatal errors<&#47;strong>.</p>
<p>In Csound this means you might accidentally code something that will send an enormously loud signal to your speakers! Dr. B explains this concept very well in <a href="http:&#47;&#47;www.csounds.com&#47;chapter1&#47;index.html#AmplitudesAndClipping" target="_blank">Chapter 1<&#47;a> of the Csound book. But we're talking about a situation where simply turning down the volume <strong>wont<&#47;strong> help. (More on why later)</p>
<p>Here's an example of some Csound code that can be tamed with the smartBalance <a href="http:&#47;&#47;en.flossmanuals.net&#47;csound&#47;ch021_f-user-defined-opcodes&#47;" target="_blank">user-defined opcode<&#47;a><br />
<strong>The following .csd WILL blow up your speakers. <&#47;strong><br />
<em>(I suggest running it on a rival DJ's computer)<&#47;em></p>
<p>[sourcecode]<br />
; SmartBalance UDO example<br />
;www.tophersaunders.com&#47;wp<br />
<CsoundSynthesizer><br />
<CsOptions><br />
<&#47;CsOptions><br />
<CsInstruments><br />
nchnls = 2<br />
sr = 44100<br />
ksmps = 256<br />
0dbfs = 1<br />
; NOTE THIS CSD WILL NOT RUN UNLESS<br />
;IT IS IN THE SAME FOLDER AS THE FILE "STRING-128"<br />
instr 1<br />
ipos     ftgen 1, 0, 128  ,  10, 1<br />
irate = .007<br />
ifnvel   ftgen 6, 0, 128  ,  -7, 0, 128, 0.1<br />
ifnmass  ftgen 2, 0, 128  ,  -7, 1, 128, 1<br />
ifnstif  ftgen 3, 0, 16384, -23, "string-128"<br />
ifncentr ftgen 4, 0, 128  ,  -7, 1, 128, 2<br />
ifndamp  ftgen 5, 0, 128  ,  -7, 1, 128, 1</p>
<p>kmass = 1<br />
kstif = 0.1<br />
kcentr = .01<br />
kdamp = 1</p>
<p>ileft = 0<br />
iright = 1<br />
kpos = 0<br />
kstrngth = 0.<br />
ain = 0<br />
idisp = 1<br />
id = 22<br />
scanu ipos, irate, ifnvel, ifnmass, \<br />
ifnstif, ifncentr, ifndamp, kmass,  \<br />
kstif, kcentr, kdamp, ileft, iright,\<br />
kpos, kstrngth, ain, idisp, id<br />
kamp = 0dbfs*.2<br />
kfreq = 200<br />
ifn ftgen 7, 0, 128, -5, .001, 128, 128.<br />
a1 scans kamp, kfreq, ifn, id<br />
a1 dcblock2 a1<br />
iatt = .005<br />
idec = 1<br />
islev = 1<br />
irel = 2<br />
aenv adsr iatt, idec, islev, irel<br />
	outs		a1*aenv,a1*aenv<br />
	endin<br />
<&#47;CsInstruments><br />
<CsScore><br />
f8 0 8192 10 1;<br />
i 1 0 5<br />
<&#47;CsScore><br />
<&#47;CsoundSynthesizer><br />
[&#47;sourcecode]</p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;csd&#47;scan_blows_up.zip">scanBLOWS_UP.zip<&#47;a><br />
<audio width="300" height="32" controls="controls"><source src="http:&#47;&#47;www.tophersaunders.com&#47;mp3s&#47;scan_blows_up.ogg" type="audio&#47;ogg" &#47;><source src="http:&#47;&#47;www.tophersaunders.com&#47;mp3s&#47;scan_blows_up.mp3" type="audio&#47;mp3" &#47;><&#47;audio></p>
<p>The problem is in this line of code<br />
<code><br />
kdamp = .1<br />
<&#47;code></p>
<p>.1 is not exactly a "safe" value for this argument, in fact, any value above 0 for this argument will cause chaos. You say "But I didn't know! The manual and tutorials never said anything about what ranges make the thing to go crazy!" Good thing you found this article!</p>
<p>I hate to ruin it for you, its actually impossible to determine in such a complicated system what are "safe" ranges for values like this. It would take a skilled mathematician to map out safe possible ranges for all the arguments of scanu. I figured out these values through a mix of trial and error and studying other folk's code. Yup, this is the closest you'll ever get to someone saying "Here are some plug-and-play numbers for you scanned synthesis pleasure."</p>
<p>The argument kdamp was put into the opcode scanu, so that the user can interact with the mass and spring system, by updating the value at the control rate. If we make this value a safe constant. like<br />
<code><br />
kdamp = -0.01<br />
<&#47;code><br />
We end up with a stable sound, but completely ignore the expressive capabilities scanned synthesis provides. This value could (and should) be updated at the control rate!</p>
<p>So let's find a suitable range of values and then map our controller to those values</p>
<p>Example:<br />
<code><br />
kdamp midic7 ictlno, -1. , -0.01<br />
<&#47;code></p>
<p>Now time to take over the world with scanned synthesis, right? However, move that knob fast enough back and forth and you'll get an eventual blow up. "Back to the drawing board."</p>
<p>It turns out the scanned synthesis model's stability is not just influenced by values given, <strong>but also the rate at which values change<&#47;strong>.</p>
<p>Lets try taming audio levels, something Csound, <em>is very good at.<&#47;em></p>
<p>Csound has an opcode that could help us out. <a href="http:&#47;&#47;www.csounds.com&#47;manual&#47;html&#47;balance.html" target="_blank">balance<&#47;a><code><br />
ares balance asig, acomp<&#47;code></p>
<p>Where asig is the audio we want to tame<br />
acomp is a signal we know and trust (a sine wave oscillator works great at this)<br />
and ares is asig but with the amplitude values of acomp.</p>
<p>[sourcecode]<br />
; SmartBalance UDO example<br />
;www.tophersaunders.com&#47;wp<br />
<CsoundSynthesizer><br />
<CsOptions><br />
<&#47;CsOptions><br />
<CsInstruments><br />
nchnls = 2<br />
sr = 44100<br />
ksmps = 256<br />
0dbfs = 1<br />
; NOTE THIS CSD WILL NOT RUN UNLESS<br />
;IT IS IN THE SAME FOLDER AS THE FILE "STRING-128"<br />
instr 1<br />
ipos     ftgen 1, 0, 128  ,  10, 1<br />
irate = .007<br />
ifnvel   ftgen 6, 0, 128  ,  -7, 0, 128, 0.1<br />
ifnmass  ftgen 2, 0, 128  ,  -7, 1, 128, 1<br />
ifnstif  ftgen 3, 0, 16384, -23, "string-128"<br />
ifncentr ftgen 4, 0, 128  ,  -7, 1, 128, 2<br />
ifndamp  ftgen 5, 0, 128  ,  -7, 1, 128, 1</p>
<p>kmass = 1<br />
kstif = 0.1<br />
kcentr = .01<br />
kdamp = -0.01</p>
<p>ileft = 0<br />
iright = 1<br />
kpos = 0<br />
kstrngth = 0.<br />
ain = 0<br />
idisp = 1<br />
id = 22<br />
scanu ipos, irate, ifnvel, ifnmass, \<br />
ifnstif, ifncentr, ifndamp, kmass,  \<br />
kstif, kcentr, kdamp, ileft, iright,\<br />
kpos, kstrngth, ain, idisp, id<br />
kamp = 0dbfs*.2<br />
kfreq = 200<br />
ifn ftgen 7, 0, 128, -5, .001, 128, 128.<br />
a1 scans kamp, kfreq, ifn, id<br />
a1 dcblock2 a1<br />
ifnsine ftgen 8, 0, 8192, 10, 1<br />
a2 oscil kamp, kfreq, ifnsine<br />
a1 balance a1, a2<br />
iatt = .005<br />
idec = 1<br />
islev = 1<br />
irel = 2<br />
aenv adsr iatt, idec, islev, irel<br />
	outs		a1*aenv,a1*aenv<br />
	endin<br />
<&#47;CsInstruments><br />
<CsScore><br />
f8 0 8192 10 1;<br />
i 1 0 5<br />
<&#47;CsScore><br />
<&#47;CsoundSynthesizer><br />
[&#47;sourcecode]</p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;csd&#47;scanSafe.zip">scan_safe.zip<&#47;a><br />
<audio width="300" height="32" controls="controls"><source src="http:&#47;&#47;www.tophersaunders.com&#47;mp3s&#47;scan_safe.ogg" type="audio&#47;ogg" &#47;><source src="http:&#47;&#47;www.tophersaunders.com&#47;mp3s&#47;scan_safe.mp3" type="audio&#47;mp3" &#47;><&#47;audio></p>
<p>No warnings, no broken speakers, no tinnitus.</p>
<p>However, we still have a loud click at the beginning of the note.</p>
<p>This click is there because it takes the balance opcode a couple milliseconds to calculate the rms amplitude of the safe signal.</p>
<p>So what we need to is start with just enough problem signal to create an attack, and quickly mix in the balanced signal and quickly mix out the ultra loud signal (it takes it a couple milliseconds to get out of control).</p>
<p>[sourcecode]<br />
ab balance a1, a2<br />
amix linseg .001, iatt+.0000001, 1 , 1, 1<br />
aout = ab*(amix) + a1*(1-amix)<br />
[&#47;sourcecode]</p>
<p>And an example of the .udo in action</p>
<p>[sourcecode]<br />
; SmartBalance UDO example<br />
;www.tophersaunders.com&#47;wp<br />
<CsoundSynthesizer><br />
<CsOptions><br />
<&#47;CsOptions><br />
<CsInstruments><br />
nchnls = 2<br />
sr = 44100<br />
ksmps = 256<br />
0dbfs = 1<br />
; NOTE THIS CSD WILL NOT RUN UNLESS<br />
;IT IS IN THE SAME FOLDER AS THE FILE "STRING-128"<br />
#include "smartBalance.udo";<br />
instr 1<br />
ipos     ftgen 1, 0, 128  ,  10, 1<br />
irate = .007<br />
ifnvel   ftgen 6, 0, 128  ,  -7, 0, 128, 0.1<br />
ifnmass  ftgen 2, 0, 128  ,  -7, 1, 128, 1<br />
ifnstif  ftgen 3, 0, 16384, -23, "string-128"<br />
ifncentr ftgen 4, 0, 128  ,  -7, 1, 128, 2<br />
ifndamp  ftgen 5, 0, 128  ,  -7, 1, 128, 1</p>
<p>kmass = 1<br />
kstif = 0.1<br />
kcentr = .01<br />
kdamp = .1</p>
<p>ileft = 0<br />
iright = 1<br />
kpos = 0<br />
kstrngth = 0.<br />
ain = 0<br />
idisp = 1<br />
id = 22<br />
scanu ipos, irate, ifnvel, ifnmass, \<br />
ifnstif, ifncentr, ifndamp, kmass,  \<br />
kstif, kcentr, kdamp, ileft, iright,\<br />
kpos, kstrngth, ain, idisp, id<br />
kamp = 0dbfs*.2<br />
kfreq = 200<br />
ifn ftgen 7, 0, 128, -5, .001, 128, 128.<br />
a1 scans kamp, kfreq, ifn, id<br />
a1 dcblock2 a1<br />
ifnsine ftgen 8, 0, 8192, 10, 1<br />
a2 oscil kamp, kfreq, ifnsine<br />
iatt = .05<br />
a1 smartBalance a1, a2, iatt+.2<br />
idec = 1<br />
islev = 1<br />
irel = 2<br />
aenv adsr iatt, idec, islev, irel<br />
	outs		a1*aenv,a1*aenv<br />
	endin<br />
<&#47;CsInstruments><br />
<CsScore><br />
f8 0 8192 10 1;<br />
i 1 0 5<br />
<&#47;CsScore><br />
<&#47;CsoundSynthesizer><br />
[&#47;sourcecode]</p>
<p>*Update April 18, 2012*<br />
Well it turns out this method still *exasperated sigh* will blow up if you hold a note for about 2 minutes straight. My hypothesis is that this has to do with trying to store a continously increasing floating point number, after a while it reaches beyond the 32-bit word size.  I haven't been able to re-create this problem with csound running in 64-bit. </p>
