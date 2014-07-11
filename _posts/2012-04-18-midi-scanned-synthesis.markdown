---
layout: post
status: publish
published: true
title: MIDI Scanned Synthesis in Csound
author:
  display_name: Topher
  login: admin
  email: csaunders@berklee.net
  url: http://www.tophersaunders.com
author_login: admin
author_email: csaunders@berklee.net
author_url: http://www.tophersaunders.com
excerpt: "MIDI Scanned Synthesis\r\n\r\nIn the spirit of Csound and open source software,
  I present my most refined standalone MIDI scanned synthesis Keyboard .csd.\r\nThis
  instrument will work with any MIDI controller or sequencer. If you check out Andreas
  Russo's <a href=\"http:&#47;&#47;www.csounds.com&#47;journal&#47;issue16&#47;audiorouting.html\"
  target=\"_blank\">article<&#47;a> about how to set up Csound MIDI with any DAW.
  This instrument will work with Andreas'configuration, and you'll be MIDI sequencing
  with scanned synthesis in no time!\r\n\r\n<img src=\"http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;04&#47;Screen-shot-2012-04-11-at-5.34.27-PM-300x244.png\"
  alt=\"MIDI scanned synthesis\" width=\"300\" height=\"244\" class=\"aligncenter
  size-medium wp-image-528\" &#47;>\r\n\r\n<a href=\"http:&#47;&#47;www.tophersaunders.com&#47;csd&#47;ScanMIDI.zip\">ScanMidi.zip
  4.57 KB<&#47;a>\r\n\r\n[sourcecode collapse=\"true\" gutter=\"true\"]\r\n\r\n<CsoundSynthesizer>\r\n<CsOptions>\r\n<&#47;CsOptions>\r\n<CsInstruments>\r\nnchnls
  = 2\r\nsr = 44100\r\nksmps = 128\r\n0dbfs = 1\r\n\r\n#define MATRIX\t\t #\"circularstring-128\"#\r\n\r\n;
  \      Parameter        CC#\r\n#define ATTACK\t\t #\t17\t#\r\n#define DECAY\t\t
  #\t18\t#\r\n#define SUSTAIN\t         #\t19\t#\r\n#define RELEASE \t #\t20\t#\r\n\r\n#define
  FILTER \t         #\t21\t# \r\n#define RESONANCE\t #\t22\t#\r\n\r\n#define SUBSINE
  \         #   23   #\r\n\r\n#define CENTERING\t #   24   #\r\n#define DAMPING\t
  \        #   25   #\r\n#define STEREOOFFSET     #   26   #\r\n#define RATE \t\t
  #   1   #\r\n\r\n;Profiles\r\ngipos     ftgen 1, 0, 128  ,  10, 1\r\ngifnvel   ftgen
  6, 0, 128  ,  -7, 0, 128, 0.1\r\ngifnmass  ftgen 2, 0, 128  ,  -7, 1, 128, 1\r\ngifnstif
  \ ftgen 3, 0, 16384, -23, $MATRIX.\r\ngifncentr ftgen 4, 0, 128  ,  -7, 1, 128,
  2\r\ngifndamp  ftgen 5, 0, 128  ,  -7, 1, 128, 1\r\ngifntraj  ftgen 7, 0, 128, -5,
  .001, 128, 128.\r\ngifnsine  ftgen 8, 0, 8192, 10, 1\r\n\r\nturnon 2;Reverb instrument\r\n\r\n#include
  \"smartBalance.udo\"\r\n\r\ngkatt init .005\r\ngkdec init .005\r\ngksus init 1\r\ngkrel
  init .002\r\n\r\ngksin init .5\r\ngkcentr init .1\r\ngkdamp init -.01\r\ngkstof
  init 0\r\ngkfco init 100000\r\ngkrez init .2\r\ngkrate init .007\r\n\r\nctrlinit
  1, $ATTACK, 3\r\nctrlinit 1, $DECAY, 3\r\nctrlinit 1, $SUSTAIN,  127\r\nctrlinit
  1, $RELEASE,  1\r\n\r\nctrlinit 1, $SUBSINE, 64\r\nctrlinit 1, $CENTERING, 2\r\nctrlinit
  1, $DAMPING, 0\r\nctrlinit 1, $STEREOOFFSET, 0\r\nctrlinit 1, $RATE, 64\r\n\r\nctrlinit
  1, $FILTER, 64\r\nctrlinit 1, $RESONANCE, 10\r\n\t\t\tinstr 1\r\n\t\t;ADSR;;;;;;;;;;;;;;;;;;;;;;;;;;;;\r\n\t\tgkatt
  midic7 $ATTACK , .0051 , 2\t\t\r\n\t\tgkdec midic7 $DECAY , .0051 ,2 \r\n\t\tgksus
  midic7 $SUSTAIN , .0051 ,1\r\n\t\tgkrel midic7 $RELEASE ,  .002 , 2\r\n\t\t;;FUNAMENTAL;;VOL;;;;;;;;;;;;;\r\n\t\tgksin
  midic7 $SUBSINE , 0  , 1\r\n\t\t;;CENTERING;;SCALING;;;;;;;;;;;;;;\r\n\t\tgkcentr
  midic7 $CENTERING, 0 , .10\r\n\t\t;;;DAMPING;;SCALING;;;;;;;;;;;;;;;;\r\n\t\tgkdamp
  midic7\t$DAMPING , -.11 , 0\r\n\t\t;;Stereo;;Offset;;;;;;;;;;;;;;;;;;;;;;\r\n\t\tgkstof
  midic7 \t$STEREOOFFSET , 0 , .1\r\n\t\t;FILTER;;;;;;;;;;;;;;;;;;;;;;;;;;\r\n\t\tgkfco
  midic7 $FILTER , 100 , 10000 , gifntraj\r\n\t\tgkrez midic7 $RESONANCE , 0 , .7\r\n\t\t;;;;;Rate;;;;;;;;;;;;;;;;;;;;;;;;;\r\n\t\tgkrate
  midic7\t$RATE , .001 , .04\r\nain\t\t\t= 0 \r\n;MIDI;VEL;to;SCAN;\r\nistif ampmidi
  1;\r\nimass ampmidi 2  ;\r\n;;MIDI;;VEL;;To VOLUME;\r\niamp ampmidi ampdb(75)&#47;32767;\r\n;MIDI;PCH;to;SCAN;\r\nkcps
  cpsmidib 2  ;\r\n;VOLUME;ADSR;;;;A;;;;;;;;;D;;;;;;;;;S;;;;;;;;;R;;;;;;\r\niatt =
  i (gkatt)\r\nidec =  i (gkdec)\r\nislev = i (gksus)\r\nirel = i (gkrel)\r\naenv
  mxadsr iatt+.02, idec+.01, islev+.01, irel+.01 ;;\r\na2 oscil iamp, kcps, gifnsine;\r\nirate
  = i(gkrate)\r\nkmass = 1\r\nkstif = 0.1\r\nileft = 0\r\niright = 1\r\nkpos = 0\r\nkstrngth
  = 0\r\nain = 0\r\nidisp = 0\r\nid = 22\r\nscanu gipos, irate, gifnvel, gifnmass,
  \\\r\ngifnstif, gifncentr, gifndamp, kmass,  \\\r\nkstif, gkcentr, gkdamp, ileft,
  iright,\\\r\nkpos, kstrngth, ain, idisp, id \r\na1\tscans\tiamp, kcps,gifntraj,
  id,   4   \r\na1 smartBalance a1, a2, iatt+.2\r\nid2 = 23\r\nscanu gipos, irate,
  gifnvel, gifnmass, \\\r\ngifnstif, gifncentr, gifndamp, kmass,  \\\r\nkstif, gkcentr+gkstof,
  gkdamp, ileft, iright,\\\r\nkpos, kstrngth, ain, idisp, id2\r\na3\tscans\tiamp,
  kcps,gifntraj, id2,   4   \r\na3 smartBalance a3, a2, iatt+.2\r\nasine upsamp gksin;
  \r\naoutleft = a1*aenv + a2*aenv*asine\r\naoutright = a3*aenv + a2*aenv*asine\r\ngaoutleft
  moogvcf2 aoutleft, gkfco, gkrez;\r\ngaoutright moogvcf2 aoutright, gkfco, gkrez;\r\n\touts\t\tgaoutleft,gaoutright;\r\n;\touts
  a2, a2\r\n\tendin\t\r\n\tinstr 2\t\r\n\tarevL, arevR reverbsc gaoutleft,gaoutright,
  .3, 18000\t\r\n  kthresh = 0\r\n  kloknee = 40\r\n  khiknee = 60\r\n  kratio  =
  2\r\n  katt    = 0.1\r\n  krel    = .5\r\n  ilook   = .02\r\narevL compress arevL,
  gaoutleft, kthresh, kloknee,\\\r\n khiknee, kratio, katt, krel, ilook\t\r\narevR
  compress arevR, gaoutright, kthresh, kloknee,\\\r\n khiknee, kratio, katt, krel,
  ilook\t\r\n\touts arevL, arevR\r\n\tendin \t\r\n<&#47;CsInstruments>\r\n<CsScore>\r\n;;TURNON;;\r\nf0
  360000;\r\n<&#47;CsScore>\r\n<&#47;CsoundSynthesizer>\r\n\r\n[&#47;sourcecode]\r\n\r\nTo
  run this instrument you have to keep the .csd in the same folder as its helper files,
  circularstring-128 and smartBalance.udo. The download unzips ready to go. \r\n\r\nIf
  you copy and the paste the code and try to run the code, it will give you errors.
  \r\n\r\nThis instrument has 11 continuous controls, where you can map midi knobs
  to scanned synthesis controls, ADSR, a filter, and a sub oscillator. This instrument,
  by default, responds to MIDI Channel 1.\r\n\r\n[sourcecode gutter=\"true\" firstline=\"12\"]\r\n;
  \      Parameter               CC#\r\n#define ATTACK\t\t #\t17\t#\r\n#define DECAY\t\t
  #\t18\t#\r\n#define SUSTAIN\t         #\t19\t#\r\n#define RELEASE \t #\t20\t#\r\n\r\n#define
  FILTER           #\t21\t#\r\n#define RESONANCE        #\t22\t#\r\n\r\n#define SUBSINE
  \         #      23      #\r\n\r\n#define CENTERING        #      24      #\r\n#define
  DAMPING          #      25      #\r\n#define STEREOOFFSET     #      26      #\r\n#define
  RATE \t\t #      1       #\r\n[&#47;sourcecode]\r\n\r\nThe rest of this article
  gets progressively more technical, you have enough so far to start making music
  with scanned synthesis.\r\n"
wordpress_id: 735
wordpress_url: http://www.tophersaunders.com/wp/?p=735
date: '2012-04-18 22:14:25 -0700'
date_gmt: '2012-04-19 02:14:25 -0700'
categories:
- Audio
- Code
tags:
- Csound
---
<p>MIDI Scanned Synthesis</p>
<p>In the spirit of Csound and open source software, I present my most refined standalone MIDI scanned synthesis Keyboard .csd.<br />
This instrument will work with any MIDI controller or sequencer. If you check out Andreas Russo's <a href="http:&#47;&#47;www.csounds.com&#47;journal&#47;issue16&#47;audiorouting.html" target="_blank">article<&#47;a> about how to set up Csound MIDI with any DAW. This instrument will work with Andreas'configuration, and you'll be MIDI sequencing with scanned synthesis in no time!</p>
<p><img src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;04&#47;Screen-shot-2012-04-11-at-5.34.27-PM-300x244.png" alt="MIDI scanned synthesis" width="300" height="244" class="aligncenter size-medium wp-image-528" &#47;></p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;csd&#47;ScanMIDI.zip">ScanMidi.zip 4.57 KB<&#47;a></p>
<p>[sourcecode collapse="true" gutter="true"]</p>
<p><CsoundSynthesizer><br />
<CsOptions><br />
<&#47;CsOptions><br />
<CsInstruments><br />
nchnls = 2<br />
sr = 44100<br />
ksmps = 128<br />
0dbfs = 1</p>
<p>#define MATRIX		 #"circularstring-128"#</p>
<p>;       Parameter        CC#<br />
#define ATTACK		 #	17	#<br />
#define DECAY		 #	18	#<br />
#define SUSTAIN	         #	19	#<br />
#define RELEASE 	 #	20	#</p>
<p>#define FILTER 	         #	21	#<br />
#define RESONANCE	 #	22	#</p>
<p>#define SUBSINE          #   23   #</p>
<p>#define CENTERING	 #   24   #<br />
#define DAMPING	         #   25   #<br />
#define STEREOOFFSET     #   26   #<br />
#define RATE 		 #   1   #</p>
<p>;Profiles<br />
gipos     ftgen 1, 0, 128  ,  10, 1<br />
gifnvel   ftgen 6, 0, 128  ,  -7, 0, 128, 0.1<br />
gifnmass  ftgen 2, 0, 128  ,  -7, 1, 128, 1<br />
gifnstif  ftgen 3, 0, 16384, -23, $MATRIX.<br />
gifncentr ftgen 4, 0, 128  ,  -7, 1, 128, 2<br />
gifndamp  ftgen 5, 0, 128  ,  -7, 1, 128, 1<br />
gifntraj  ftgen 7, 0, 128, -5, .001, 128, 128.<br />
gifnsine  ftgen 8, 0, 8192, 10, 1</p>
<p>turnon 2;Reverb instrument</p>
<p>#include "smartBalance.udo"</p>
<p>gkatt init .005<br />
gkdec init .005<br />
gksus init 1<br />
gkrel init .002</p>
<p>gksin init .5<br />
gkcentr init .1<br />
gkdamp init -.01<br />
gkstof init 0<br />
gkfco init 100000<br />
gkrez init .2<br />
gkrate init .007</p>
<p>ctrlinit 1, $ATTACK, 3<br />
ctrlinit 1, $DECAY, 3<br />
ctrlinit 1, $SUSTAIN,  127<br />
ctrlinit 1, $RELEASE,  1</p>
<p>ctrlinit 1, $SUBSINE, 64<br />
ctrlinit 1, $CENTERING, 2<br />
ctrlinit 1, $DAMPING, 0<br />
ctrlinit 1, $STEREOOFFSET, 0<br />
ctrlinit 1, $RATE, 64</p>
<p>ctrlinit 1, $FILTER, 64<br />
ctrlinit 1, $RESONANCE, 10<br />
			instr 1<br />
		;ADSR;;;;;;;;;;;;;;;;;;;;;;;;;;;;<br />
		gkatt midic7 $ATTACK , .0051 , 2<br />
		gkdec midic7 $DECAY , .0051 ,2<br />
		gksus midic7 $SUSTAIN , .0051 ,1<br />
		gkrel midic7 $RELEASE ,  .002 , 2<br />
		;;FUNAMENTAL;;VOL;;;;;;;;;;;;;<br />
		gksin midic7 $SUBSINE , 0  , 1<br />
		;;CENTERING;;SCALING;;;;;;;;;;;;;;<br />
		gkcentr midic7 $CENTERING, 0 , .10<br />
		;;;DAMPING;;SCALING;;;;;;;;;;;;;;;;<br />
		gkdamp midic7	$DAMPING , -.11 , 0<br />
		;;Stereo;;Offset;;;;;;;;;;;;;;;;;;;;;;<br />
		gkstof midic7 	$STEREOOFFSET , 0 , .1<br />
		;FILTER;;;;;;;;;;;;;;;;;;;;;;;;;;<br />
		gkfco midic7 $FILTER , 100 , 10000 , gifntraj<br />
		gkrez midic7 $RESONANCE , 0 , .7<br />
		;;;;;Rate;;;;;;;;;;;;;;;;;;;;;;;;;<br />
		gkrate midic7	$RATE , .001 , .04<br />
ain			= 0<br />
;MIDI;VEL;to;SCAN;<br />
istif ampmidi 1;<br />
imass ampmidi 2  ;<br />
;;MIDI;;VEL;;To VOLUME;<br />
iamp ampmidi ampdb(75)&#47;32767;<br />
;MIDI;PCH;to;SCAN;<br />
kcps cpsmidib 2  ;<br />
;VOLUME;ADSR;;;;A;;;;;;;;;D;;;;;;;;;S;;;;;;;;;R;;;;;;<br />
iatt = i (gkatt)<br />
idec =  i (gkdec)<br />
islev = i (gksus)<br />
irel = i (gkrel)<br />
aenv mxadsr iatt+.02, idec+.01, islev+.01, irel+.01 ;;<br />
a2 oscil iamp, kcps, gifnsine;<br />
irate = i(gkrate)<br />
kmass = 1<br />
kstif = 0.1<br />
ileft = 0<br />
iright = 1<br />
kpos = 0<br />
kstrngth = 0<br />
ain = 0<br />
idisp = 0<br />
id = 22<br />
scanu gipos, irate, gifnvel, gifnmass, \<br />
gifnstif, gifncentr, gifndamp, kmass,  \<br />
kstif, gkcentr, gkdamp, ileft, iright,\<br />
kpos, kstrngth, ain, idisp, id<br />
a1	scans	iamp, kcps,gifntraj, id,   4<br />
a1 smartBalance a1, a2, iatt+.2<br />
id2 = 23<br />
scanu gipos, irate, gifnvel, gifnmass, \<br />
gifnstif, gifncentr, gifndamp, kmass,  \<br />
kstif, gkcentr+gkstof, gkdamp, ileft, iright,\<br />
kpos, kstrngth, ain, idisp, id2<br />
a3	scans	iamp, kcps,gifntraj, id2,   4<br />
a3 smartBalance a3, a2, iatt+.2<br />
asine upsamp gksin;<br />
aoutleft = a1*aenv + a2*aenv*asine<br />
aoutright = a3*aenv + a2*aenv*asine<br />
gaoutleft moogvcf2 aoutleft, gkfco, gkrez;<br />
gaoutright moogvcf2 aoutright, gkfco, gkrez;<br />
	outs		gaoutleft,gaoutright;<br />
;	outs a2, a2<br />
	endin<br />
	instr 2<br />
	arevL, arevR reverbsc gaoutleft,gaoutright, .3, 18000<br />
  kthresh = 0<br />
  kloknee = 40<br />
  khiknee = 60<br />
  kratio  = 2<br />
  katt    = 0.1<br />
  krel    = .5<br />
  ilook   = .02<br />
arevL compress arevL, gaoutleft, kthresh, kloknee,\<br />
 khiknee, kratio, katt, krel, ilook<br />
arevR compress arevR, gaoutright, kthresh, kloknee,\<br />
 khiknee, kratio, katt, krel, ilook<br />
	outs arevL, arevR<br />
	endin<br />
<&#47;CsInstruments><br />
<CsScore><br />
;;TURNON;;<br />
f0 360000;<br />
<&#47;CsScore><br />
<&#47;CsoundSynthesizer></p>
<p>[&#47;sourcecode]</p>
<p>To run this instrument you have to keep the .csd in the same folder as its helper files, circularstring-128 and smartBalance.udo. The download unzips ready to go. </p>
<p>If you copy and the paste the code and try to run the code, it will give you errors. </p>
<p>This instrument has 11 continuous controls, where you can map midi knobs to scanned synthesis controls, ADSR, a filter, and a sub oscillator. This instrument, by default, responds to MIDI Channel 1.</p>
<p>[sourcecode gutter="true" firstline="12"]<br />
;       Parameter               CC#<br />
#define ATTACK		 #	17	#<br />
#define DECAY		 #	18	#<br />
#define SUSTAIN	         #	19	#<br />
#define RELEASE 	 #	20	#</p>
<p>#define FILTER           #	21	#<br />
#define RESONANCE        #	22	#</p>
<p>#define SUBSINE          #      23      #</p>
<p>#define CENTERING        #      24      #<br />
#define DAMPING          #      25      #<br />
#define STEREOOFFSET     #      26      #<br />
#define RATE 		 #      1       #<br />
[&#47;sourcecode]</p>
<p>The rest of this article gets progressively more technical, you have enough so far to start making music with scanned synthesis.<br />
<a id="more"></a><a id="more-735"></a></p>
<p>If you're an expert on scanned syntheis. You can edit the Profiles in this block-</p>
<p>[sourcecode firstline="28" gutter="true"]<br />
;Profiles<br />
gipos     ftgen 1, 0, 128  ,  10, 1<br />
gifnvel   ftgen 6, 0, 128  ,  -7, 0, 128, 0.1<br />
gifnmass  ftgen 2, 0, 128  ,  -7, 1, 128, 1<br />
gifnstif  ftgen 3, 0, 16384, -23, $MATRIX.<br />
gifncentr ftgen 4, 0, 128  ,  -7, 1, 128, 2<br />
gifndamp  ftgen 5, 0, 128  ,  -7, 1, 128, 1<br />
gifntraj  ftgen 7, 0, 128, -5, .001, 128, 128.<br />
gifnsine  ftgen 8, 0, 8192, 10, 1<br />
[&#47;sourcecode]</p>
<p>If you want to turn off the reverb, comment out the following line</p>
<p>[sourcecode firstline="38" gutter="true"]<br />
turnon 2<br />
[&#47;sourcecode]</p>
<p>The reverb is pretty nice, though. It uses Sean Costello's waveguide reverb opcode. </p>
<p>The signal going to Sean's opcode is put through an expander so that the louder dynamics reverberate more than softer dynamics. </p>
<p>Then the reverb is ducked by the dry signal, so that the reverb doesn't get in the way of the dry sound.</p>
<p>[sourcecode firstline="133" gutter="true"]<br />
instr 2<br />
arevL, arevR reverbsc gaoutleft,gaoutright, .3,\<br />
 18000<br />
  kthresh = 0<br />
  kloknee = 40<br />
  khiknee = 60<br />
  kratio  = 2<br />
  katt    = 0.1<br />
  krel    = .5<br />
  ilook   = .02<br />
arevL compress arevL, gaoutleft, kthresh,\<br />
kloknee,khiknee, kratio, katt, krel, ilook<br />
arevR compress arevR, gaoutright, kthresh,\<br />
kloknee,khiknee, kratio, katt, krel, ilook<br />
	outs arevL, arevR<br />
	endin<br />
[&#47;sourcecode]</p>
<p>The next lines import a user defined opcode, a way of encapsulating code for easy re-use.</p>
<p>[sourcecode firstline="40" gutter="true"]<br />
#include "smartBalance.udo"<br />
[&#47;sourcecode]</p>
<p>Read more about this UDO <a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;?p=672" target="_blank">here<&#47;a></p>
<p>In order to use Csound with MIDI, you have to initialize not only the MIDI controls<br />
[sourcecode firstline="42" gutter="true"]<br />
ctrlinit 1, $ATTACK, 3<br />
ctrlinit 1, $DECAY, 3<br />
ctrlinit 1, $SUSTAIN, 127<br />
ctrlinit 1, $RELEASE, 1</p>
<p>ctrlinit 1, $SUBSINE, 64<br />
ctrlinit 1, $CENTERING, 2<br />
ctrlinit 1, $DAMPING, 0<br />
ctrlinit 1, $STEREOOFFSET, 0<br />
ctrlinit 1, $RATE, 64</p>
<p>ctrlinit 1, $FILTER, 64<br />
ctrlinit 1, $RESONANCE, 10<br />
[&#47;sourcecode]</p>
<p>, but also you have to initialize the global variables used by the instrument, or the model(if you're thinking Model-View-Controller).</p>
<p>[sourcecode firstline="42"]<br />
gkatt init .005<br />
gkdec init .005<br />
gksus init 1<br />
gkrel init .002</p>
<p>gksin init .5<br />
gkcentr init .1<br />
gkdamp init -.01<br />
gkstof init 0<br />
gkfco init 100000<br />
gkrez init .2<br />
gkrate init .007<br />
[&#47;sourcecode]</p>
<p>Ah so lets get to the instrument, here's where we actually read the values from the MIDI controller.</p>
<p>[sourcecode firstline="68" gutter="true"]<br />
	instr 1<br />
;ADSR;;;;;;;;;;;;;;;;;;;;;;;;;;;;<br />
gkatt midic7 $ATTACK , .0051 , 2<br />
gkdec midic7 $DECAY , .0051 ,2<br />
gksus midic7 $SUSTAIN , .0051 ,1<br />
gkrel midic7 $RELEASE ,  .002 , 2<br />
;;FUNAMENTAL;;VOL;;;;;;;;;;;;;<br />
gksin midic7 $SUBSINE , 0  , 1<br />
;;CENTERING;;SCALING;;;;;;;;;;;;;;<br />
gkcentr midic7 $CENTERING, 0 , .10<br />
;;;DAMPING;;SCALING;;;;;;;;;;;;;;;;<br />
gkdamp midic7	$DAMPING , -.11 , 0<br />
;;Stereo;;Offset;;;;;;;;;;;;;;;;;;;;;;<br />
gkstof midic7 	$STEREOOFFSET , 0 , .1<br />
;FILTER;;;;;;;;;;;;;;;;;;;;;;;;;;<br />
gkfco midic7 $FILTER , 100 , 10000 , gifntraj<br />
gkrez midic7 $RESONANCE , 0 , .7<br />
;;;;;Rate;;;;;;;;;;;;;;;;;;;;;;;;;<br />
gkrate midic7	$RATE , .001 , .04<br />
[&#47;sourcecode]</p>
<p>This instrument does not use audio injection so we set the required ain variable to 0</p>
<p>[sourcecode firstline="87" gutter="true"]<br />
ain = 0<br />
[&#47;sourcecode]</p>
<p>The mass and stiffness of the scanned system is influenced by MIDI velocity.</p>
<p>[sourcecode firstline="88" gutter="true"]<br />
;MIDI;VEL;to;SCAN;<br />
istif ampmidi 1;<br />
imass ampmidi 2  ;<br />
[&#47;sourcecode]</p>
<p>Also, MIDI key velocity should have an effect on overall amplitude.</p>
<p>[sourcecode firstline="91"]<br />
;;MIDI;;VEL;;To VOLUME;<br />
iamp ampmidi ampdb(75)&#47;32767;<br />
[&#47;sourcecode]</p>
<p>Lets get pitch from the key, with pitchbend.</p>
<p>[sourcecode firstline="94" gutter="true"]<br />
kcps cpsmidib 2  ;<br />
[&#47;sourcecode]</p>
<p>if you want to change the range of the pitch bend in semitones, you edit this line. Default is 2 semitones.</p>
<p>The lines below generate our ADSR envelope to be applied to the signal later. Notice the MIDI control of ADSR values.</p>
<p>[sourcecode firstline="95" gutter="true"]<br />
;VOLUME;ADSR;<br />
iatt = i (gkatt)     ; A<br />
idec =  i (gkdec)    ; D<br />
islev = i (gksus)    ; S<br />
irel = i (gkrel)     ; R<br />
aenv mxadsr iatt+.02,idec+.01,islev+.01,irel+.01<br />
[&#47;sourcecode]</p>
<p>The next lines generate a sub oscillator tone</p>
<p>[sourcecode firstline="101" gutter="true"]<br />
a2 oscil iamp, kcps, gifnsine;<br />
[&#47;sourcecode]</p>
<p>If you wish to change the flavor of sub oscillator tone, (maybe you'd prefer a Sawtooth wave), edit this line of code, found back in the header with the profiles</p>
<p>[sourcecode firstline="36" gutter="true"]<br />
gifnsine  ftgen 8, 0, 8192, 10, 1<br />
[&#47;sourcecode]</p>
<p>The next lines set up Paris Smaragdis' opcode <strong>scans<&#47;strong>. There are a total of 2 scanned oscillators, for stereo manipulation. This is the first one.</p>
<p>[sourcecode firstline="102" gutter="true"]<br />
irate = i(gkrate)<br />
kmass = 1<br />
kstif = 0.1<br />
ileft = 0<br />
iright = 1<br />
kpos = 0<br />
kstrngth = 0<br />
ain = 0<br />
idisp = 0<br />
id = 22<br />
scanu gipos, irate, gifnvel, gifnmass, \<br />
gifnstif, gifncentr, gifndamp, kmass,  \<br />
kstif, gkcentr, gkdamp, ileft, iright,\<br />
kpos, kstrngth, ain, idisp, id<br />
[&#47;sourcecode]</p>
<p>I tired to keep the same variable naming scheme for scanu as the Csound manual entry.</p>
<p>Now that our scanned wave is set up, lets scan it!</p>
<p>[sourcecode firstline="116"]<br />
a1	scans	iamp, kcps,gifntraj, id,   4<br />
[&#47;sourcecode]</p>
<p>we can edit scan trajectories in this line back in the profile header<br />
[sourcecode firstline="35" gutter="true"]<br />
gifntraj  ftgen 7, 0, 128, -5, .001, 128, 128.<br />
[&#47;sourcecode]</p>
<p>Replacing this line with</p>
<p>[sourcecode firstline="35" gutter="true"]<br />
gifntraj  ftgen 7, 0, 128, -7, 0, 128, 128.<br />
[&#47;sourcecode]</p>
<p>is a quick hack to get a different sound.</p>
<p>our next line in the instrument calls the definition of the smart balance .udo I discussed in one of my previous <a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;?p=672" target="_blank">articles<&#47;a></p>
<p>[sourcecode firstline="117" gutter="true"]<br />
a1 smartBalance a1, a2, iatt+.2<br />
[&#47;sourcecode]</p>
<p>The next lines set up the second scanned oscillator<br />
[sourcecode firstline="119" gutter="true"]</p>
<p>scanu gipos, irate, gifnvel, gifnmass, \<br />
gifnstif, gifncentr, gifndamp, kmass, \<br />
kstif, gkcentr+gkstof, gkdamp, ileft, iright,\<br />
kpos, kstrngth, ain, idisp, id2<br />
a3 scans iamp, kcps,gifntraj, id2, 4<br />
[&#47;sourcecode]<br />
except that now we have another variable gkstof in this part of the line<br />
[sourcecode firstline="119" highlight="121" gutter="true"]<br />
scanu gipos, irate, gifnvel, gifnmass, \<br />
gifnstif, gifncentr, gifndamp, kmass, \<br />
kstif, gkcentr+gkstof, gkdamp, ileft, iright,\<br />
kpos, kstrngth, ain, idisp, id2<br />
a3 scans iamp, kcps,gifntraj, id2, 4<br />
[&#47;sourcecode]</p>
<p>gkstof sends a little bit more centering force to one of the oscillators, giving a stereo effect that is unique to scanned synthesis.</p>
<p>Next lets upsample our sub oscillator volume control and mix the sub oscillator with the scanned oscillators</p>
<p>[sourcecode firstline="125" gutter="true"]<br />
asine upsamp gksin;<br />
aoutleft = a1*aenv + a2*aenv*asine<br />
aoutright = a3*aenv + a2*aenv*asine<br />
[&#47;sourcecode]</p>
<p>at the final stage we apply Hans Mikelson and John Ffitch's opcode moogvcf, a warm filter with resonance.</p>
<p>[sourcecode firstline="128" gutter="true"]<br />
gaoutleft moogvcf2 aoutleft, gkfco, gkrez;<br />
gaoutright moogvcf2 aoutright, gkfco, gkrez;<br />
[&#47;sourcecode]</p>
<p>and send our signal to the dac using the opcode outs. If you set up your configuration like Andrea's tutorial, then this is where the signal gets sent out to Soundflower, or JACK.</p>
<p>[sourcecode firstline="132" gutter="true"]<br />
	outs		gaoutleft,gaoutright;<br />
        endin<br />
[&#47;sourcecode]</p>
<p>These are global variables so they can also be sent to the reverb instrument mentioned earlier in the article</p>
<p>Finally, this trick keeps Csound running for 360,000 seconds unless we quit, so that we can send Csound MIDI.</p>
<p>[sourcecode firstline="148" gutter="true"]<br />
<&#47;CsInstruments><br />
<CsScore><br />
;;TURNON;;<br />
f0 360000;<br />
<&#47;CsScore><br />
<&#47;CsoundSynthesizer><br />
[&#47;sourcecode]</p>
<p>This line ensures that the instrument is compatible with earlier versions of Csound. I think the newest Csound version doesn't need this line<br />
[sourcecode firstline="148" highlight="151" gutter="true"]<br />
<&#47;CsInstruments><br />
<CsScore><br />
;;TURNON;;<br />
f0 360000;<br />
<&#47;CsScore><br />
<&#47;CsoundSynthesizer><br />
[&#47;sourcecode]<br />
and will stay running if left blank until we quit Csound, but I like to keep it in there just in case someone has an old version.</p>
