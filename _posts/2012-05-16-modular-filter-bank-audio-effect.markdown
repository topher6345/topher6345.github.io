---
layout: post
status: publish
published: true
title: Modular Filter Bank Audio Effect
author:
  display_name: Topher
  login: admin
  email: csaunders@berklee.net
  url: http://www.tophersaunders.com
author_login: admin
author_email: csaunders@berklee.net
author_url: http://www.tophersaunders.com
excerpt: "This article is about how you can use a bank of tunable high-resonance bandpass
  filters (inspired by <a href=\"http:&#47;&#47;www.csounds.com&#47;max&#47;index.html\">Max
  Mathews'<&#47;a> Phaser Filters) in Csound to make some pretty awesome sounds.\r\n\r\n
  \r\n"
wordpress_id: 911
wordpress_url: http://www.tophersaunders.com/wp/?p=911
date: '2012-05-16 23:25:59 -0700'
date_gmt: '2012-05-17 03:25:59 -0700'
categories:
- Audio
- Code
tags:
- Csound
---
<p>This article is about how you can use a bank of tunable high-resonance bandpass filters (inspired by <a href="http:&#47;&#47;www.csounds.com&#47;max&#47;index.html">Max Mathews'<&#47;a> Phaser Filters) in Csound to make some pretty awesome sounds.</p>
<p><a id="more"></a><a id="more-911"></a></p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;csd&#47;FilterBank6.zip">FilterBank6.zip 4 kB<&#47;a></p>
<p><audio controls="controls"><br />
  <source src="http:&#47;&#47;www.tophersaunders.com&#47;mp3s&#47;FilterBank6.ogg" type="audio&#47;ogg" &#47;><br />
  <source src="http:&#47;&#47;www.tophersaunders.com&#47;mp3s&#47;FilterBank6.mp3" type="audio&#47;mp3" &#47;><br />
  Your browser does not support the audio tag.<br />
<&#47;audio><br />
FilterBank6.csd<br />
[sourcecode gutter="true" collapse="true"]<br />
; Phaser Filter Emulation<br />
;www.tophersaunders.com&#47;wp<br />
<CsoundSynthesizer><br />
<CsOptions><br />
<&#47;CsOptions><br />
<CsInstruments><br />
sr=44100<br />
ksmps=10<br />
nchnls=2<br />
0dbfs=1<br />
gipitchtable ftgen 44, 0, -6, -2 , 60, 65, 70, 75, 80, 85<br />
gimorph1 ftgen 4, 0, -6, -2 , 60, 65, 70, 75, 80, 85<br />
gimorph2 ftgen 5, 0, -6, -2 , 60, 64, 67, 71, 74, 79<br />
giftfn  ftgen 9, 0, 2, -2, gimorph1 , gimorph2<br />
instr 1<br />
ain pinkish .8<br />
kftndx line 0, p3, 1<br />
ftmorf kftndx, giftfn, gipitchtable<br />
#define K #1#<br />
kcf$K. table $K., gipitchtable<br />
a$K. reson ain, cpsmidinn(kcf$K.), 15<br />
#undef K<br />
#define K #2#<br />
kcf$K. table $K., gipitchtable<br />
a$K. reson ain, cpsmidinn(kcf$K.), 15<br />
#undef K<br />
#define K #3#<br />
kcf$K. table $K., gipitchtable<br />
a$K. reson ain, cpsmidinn(kcf$K.), 15<br />
#undef K<br />
#define K #4#<br />
kcf$K. table $K., gipitchtable<br />
a$K. reson ain, cpsmidinn(kcf$K.), 15<br />
#undef K<br />
#define K #5#<br />
kcf$K. table $K., gipitchtable<br />
a$K. reson ain, cpsmidinn(kcf$K.), 15<br />
#undef K<br />
#define K #6#<br />
kcf$K. table $K., gipitchtable<br />
a$K. reson ain, cpsmidinn(kcf$K.), 15<br />
#undef K<br />
ares = a1+a2+a3+a4+a5+a6<br />
asig balance ares, ain<br />
asig dcblock2 asig<br />
    outs asig, asig<br />
endin<br />
<&#47;CsInstruments><br />
<CsScore><br />
i 1 0 10<br />
<&#47;CsScore><br />
<&#47;CsoundSynthesizer><br />
[&#47;sourcecode]</p>
<p>Unlike some of my previous Csound tutorials, this example will run if you copy&#47;paste the above code, no extra files are needed. </p>
<p>The key opcode in this .csd is <em>reson<&#47;em>.  The usage of <a href="http:&#47;&#47;www.csounds.com&#47;manual&#47;html&#47;reson.html">reson<&#47;a> is simple, it takes 3 input arguments and outputs a filtered audio signal.</p>
<p>[sourcecode]<br />
ares reson asig, kcf, kbw<br />
[&#47;sourcecode]</p>
<p><em>asig<&#47;em> is our singal that we want to filter<br />
<em>kcf<&#47;em> is our center frequency of the filter<br />
and <em>kbw<&#47;em> is how wide, in Hz, we want the bandwidth of the filter to be.</p>
<p>The way I use it in my .csd is I use a couple variables and macros to make the chunk of code easier to copy&#47;paste.</p>
<p>[sourcecode gutter="true" firstline="19"]<br />
#define K #1#<br />
kcf$K. table $K., gipitchtable<br />
a$K. reson ain, cpsmidinn(kcf$K.), 15<br />
#undef K<br />
[&#47;sourcecode]</p>
<p>lets look at line 21 first, the line where we use the reson opcode.<br />
<em>ain<&#47;em> is our input signal<br />
<em>cpsmidinn(kcf$K.)<&#47;em> converts a MIDI note stored into a table to a frequency in Hz value to tell where the center frequency of our bandpass filter.<br />
and <em>15<&#47;em> is our bandwidth in Hz.</p>
<p>the line above that <em>20<&#47;em>, reads from a table of stored MIDI note values, an easier way to store the frequency we want to tune the bandpass filter to rather than specifying the exact frequency in Hz. </p>
<p>The #define at the top is a little trick to allow us to copy&#47;paste all four lines (line 19-23) as many times as we want, and it will be all ready and set up to go, as long as we change the number in between the two #'s.  To see another, more in-depth explanation of this trick, check out my article on<a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;?p=861">a Scanned Synthesis UDO<&#47;a></p>
<p>I made this 4 lines of code a "template", and then copy&#47;pasted it 5 more times to create 6 band pass filters.</p>
<p>Our audio signal processed by all these filters is <em>ain<&#47;em>, in this case pink noise, generated on line 16.</p>
<p>[sourcecode gutter="true" firstline="16"]<br />
ain pinkish .8<br />
[&#47;sourcecode]</p>
<p>You could assign any audio signal to ain to process a sample, or incoming audio from your audio interface.</p>
<p>So we send this signal through 6 filters, and mix them together with simple addition on line 43.</p>
<p>[sourcecode gutter="true" firstline="43"]<br />
ares = a1+a2+a3+a4+a5+a6<br />
[&#47;sourcecode]</p>
<p>resonate bandpass filters are notorious for generating extreme amplitudes, to tame this we can use the <em>balance<&#47;em> opcode to scale the filtered sound to the amplitude level of the input sound, ain. </p>
<p>[sourcecode gutter="true" firstline="44"]<br />
asig balance ares, ain<br />
[&#47;sourcecode]</p>
<p>and for good measure, we dcblock the sound before we output it. </p>
<p>[sourcecode gutter="true" firstline="45"]<br />
asig dcblock2 asig<br />
    outs asig, asig<br />
[&#47;sourcecode]</p>
<p>Now I'll show you how to store center frequency values for each of the resonate bandpass filters in a table.</p>
<p>[sourcecode gutter="true" firstline="11"]<br />
gipitchtable ftgen 44, 0, -6, -2 , 60, 65, 70, 75, 80, 85<br />
[&#47;sourcecode]</p>
<p>44 is arbitrary, I like to use higher numbers so that the user can modify the .csd and use ftable numbers like 1 or 2 without stepping on the ones built into the .csd.  </p>
<p>our size is 6, in Csound when want to create an ftable thats not a power of 2 (2,4,8,16 etc.) one must specify the size as negative. Hence our p3 field is -6. The GEN routine used is GEN 2, which allows us to fill the table with arbitrary value, again this time negative, meaning that we bypass the ftable's default behavior to normalize the values.  </p>
<p>This list of frequencies is fine, but wouldn't it be cool if we could morph between values using the <em>ftmorf<&#47;em> opcode and add motion to the sound?</p>
<p>We can do this in 3 steps.</p>
<p>Step 1. "allocate" an initial table</p>
<p>[sourcecode gutter="true" firstline="11"]<br />
gipitchtable ftgen 44, 0, -6, -2 , 60, 65, 70, 75, 80, 85<br />
[&#47;sourcecode]</p>
<p>We already did this by generating this table. This is our starter table, just in case something goes wrong with the morphing, Csound will still have legitimate values to work with.</p>
<p>The next lines create ftables in a similar way.  </p>
<p>The first one creates a 6 voice stacked fourths chord on C (its the same as our intial table)</p>
<p>[sourcecode gutter="true" firstline="12"]<br />
gimorph1 ftgen 4, 0, -6, -2 , 60, 65, 70, 75, 80, 85<br />
[&#47;sourcecode]</p>
<p>The next is a C major chord.<br />
[sourcecode gutter="true" firstline="13"]<br />
gimorph2 ftgen 5, 0, -6, -2 , 60, 64, 67, 71, 74, 79<br />
[&#47;sourcecode]</p>
<p>in order to use <em>ftmorf<&#47;em> we have to give it a table of tables.  This concept is kind of confusing. I tried to make it simpler by using variable names instead of ftable numbers. Hopefully this is clear, we are filling a table with table numbers of other tables.</p>
<p>[sourcecode gutter="true" firstline="14"]<br />
giftfn  ftgen 9, 0, 2, -2, gimorph1 , gimorph2<br />
[&#47;sourcecode]</p>
<p>this is the ftable we will use with <em>ftmorf<&#47;em>.</p>
<p>[sourcecode gutter="true" firstline="18"]<br />
ftmorf kftndx, giftfn, gipitchtable<br />
[&#47;sourcecode]</p>
<p>ftmorf will change the values of the table <em>gipitchtable<&#47;em> by morphing between the tables in <em>giftfn<&#47;em> (remember this is a table of table numbers). We do this by giving a floating point value to <em>kftndx<&#47;em>.  </p>
<p>For example if <em>kftndx<&#47;em> is 0.0, then the contents of <em>gipitchtable<&#47;em>(used by our bandpass filters) will be the first table in <em>giftfn<&#47;em>, which is the table <em>gimorph1<&#47;em>. Likewise if <em>kftndx<&#47;em> is 1.0 then the contents of <em>gipitchtable<&#47;em> will be the same as <em>gimorph2<&#47;em>.  If <em>kftndx<&#47;em> is .5, <em>ftmorf<&#47;em> will interpolate or "morph" between <em>gimorph1<&#47;em> and <em>gimorph2<&#47;em>.</p>
<p>to "morph" between the two, we can use the line opcode...</p>
<p>[sourcecode gutter="true" firstline="17"]<br />
kftndx line 0, p3, 1<br />
[&#47;sourcecode]</p>
<p>to draw a line or "interpolate" between the two tables. </p>
<p>In an early draft of the .csd I used the following line instead<br />
[sourcecode gutter="true" firstline="17"]<br />
kftndx invalue "morph"<br />
[&#47;sourcecode]</p>
<p>so that I could use a CsoundQt slider widget to "morph" between the tables.  The slider's output would, of course, have to be set in the range of 0. to 1. </p>
