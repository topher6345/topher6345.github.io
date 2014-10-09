---
layout: post
status: publish
published: true
title: MIDI Scanned Synthesis in Csound
author: Topher
date: '2012-04-18 22:14:25 -0700'
categories:
- Audio
- Code
tags:
- Csound
---

MIDI Scanned Synthesis

In the spirit of Csound and open source software, I present my most refined standalone MIDI scanned synthesis Keyboard .csd.


This instrument will work with any MIDI controller or sequencer. If you check out Andreas Russo's 
[article about how to set up Csound MIDI with any DAW. This instrument will work with Andreas'configuration, and you'll be MIDI sequencing with scanned synthesis in no time!](http://www.csounds.com/journal/issue16/audiorouting.html)

![MIDI scanned synthesis](http://www.tophersaunders.com/wp/wp-content/uploads/2012/04/Screen-shot-2012-04-11-at-5.34.27-PM-300x244.png)

[ScanMidi.zip 4.57 KB](http://www.tophersaunders.com/csd/ScanMIDI.zip)

```
nchnls = 2
sr = 44100
ksmps = 128
0dbfs = 1
#define MATRIX       #"circularstring-128"#
;       Parameter        CC#
#define ATTACK       #  17  #
#define DECAY        #  18  #
#define SUSTAIN          #  19  #
#define RELEASE      #  20  #
#define FILTER           #  21  #
#define RESONANCE    #  22  #
#define SUBSINE          #   23   #
#define CENTERING    #   24   #
#define DAMPING          #   25   #
#define STEREOOFFSET     #   26   #
#define RATE         #   1   #
;Profiles
gipos     ftgen 1, 0, 128  ,  10, 1
gifnvel   ftgen 6, 0, 128  ,  -7, 0, 128, 0.1
gifnmass  ftgen 2, 0, 128  ,  -7, 1, 128, 1
gifnstif  ftgen 3, 0, 16384, -23, $MATRIX.
gifncentr ftgen 4, 0, 128  ,  -7, 1, 128, 2
gifndamp  ftgen 5, 0, 128  ,  -7, 1, 128, 1
gifntraj  ftgen 7, 0, 128, -5, .001, 128, 128.
gifnsine  ftgen 8, 0, 8192, 10, 1
turnon 2;Reverb instrument
#include "smartBalance.udo"
gkatt init .005
gkdec init .005
gksus init 1
gkrel init .002
gksin init .5
gkcentr init .1
gkdamp init -.01
gkstof init 0
gkfco init 100000
gkrez init .2
gkrate init .007
ctrlinit 1, $ATTACK, 3
ctrlinit 1, $DECAY, 3
ctrlinit 1, $SUSTAIN,  127
ctrlinit 1, $RELEASE,  1
ctrlinit 1, $SUBSINE, 64
ctrlinit 1, $CENTERING, 2
ctrlinit 1, $DAMPING, 0
ctrlinit 1, $STEREOOFFSET, 0
ctrlinit 1, $RATE, 64
ctrlinit 1, $FILTER, 64
ctrlinit 1, $RESONANCE, 10
            instr 1
        ;ADSR;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        gkatt midic7 $ATTACK , .0051 , 2
        gkdec midic7 $DECAY , .0051 ,2
        gksus midic7 $SUSTAIN , .0051 ,1
        gkrel midic7 $RELEASE ,  .002 , 2
        ;;FUNAMENTAL;;VOL;;;;;;;;;;;;;
        gksin midic7 $SUBSINE , 0  , 1
        ;;CENTERING;;SCALING;;;;;;;;;;;;;;
        gkcentr midic7 $CENTERING, 0 , .10
        ;;;DAMPING;;SCALING;;;;;;;;;;;;;;;;
        gkdamp midic7   $DAMPING , -.11 , 0
        ;;Stereo;;Offset;;;;;;;;;;;;;;;;;;;;;;
        gkstof midic7   $STEREOOFFSET , 0 , .1
        ;FILTER;;;;;;;;;;;;;;;;;;;;;;;;;;
        gkfco midic7 $FILTER , 100 , 10000 , gifntraj
        gkrez midic7 $RESONANCE , 0 , .7
        ;;;;;Rate;;;;;;;;;;;;;;;;;;;;;;;;;
        gkrate midic7   $RATE , .001 , .04
ain         = 0
;MIDI;VEL;to;SCAN;
istif ampmidi 1;
imass ampmidi 2  ;
;;MIDI;;VEL;;To VOLUME;
iamp ampmidi ampdb(75)/32767;
;MIDI;PCH;to;SCAN;
kcps cpsmidib 2  ;
;VOLUME;ADSR;;;;A;;;;;;;;;D;;;;;;;;;S;;;;;;;;;R;;;;;;
iatt = i (gkatt)
idec =  i (gkdec)
islev = i (gksus)
irel = i (gkrel)
aenv mxadsr iatt+.02, idec+.01, islev+.01, irel+.01 ;;
a2 oscil iamp, kcps, gifnsine;
irate = i(gkrate)
kmass = 1
kstif = 0.1
ileft = 0
iright = 1
kpos = 0
kstrngth = 0
ain = 0
idisp = 0
id = 22
scanu gipos, irate, gifnvel, gifnmass, \
gifnstif, gifncentr, gifndamp, kmass,  \
kstif, gkcentr, gkdamp, ileft, iright,\
kpos, kstrngth, ain, idisp, id
a1  scans   iamp, kcps,gifntraj, id,   4
a1 smartBalance a1, a2, iatt+.2
id2 = 23
scanu gipos, irate, gifnvel, gifnmass, \
gifnstif, gifncentr, gifndamp, kmass,  \
kstif, gkcentr+gkstof, gkdamp, ileft, iright,\
kpos, kstrngth, ain, idisp, id2
a3  scans   iamp, kcps,gifntraj, id2,   4
a3 smartBalance a3, a2, iatt+.2
asine upsamp gksin;
aoutleft = a1*aenv + a2*aenv*asine
aoutright = a3*aenv + a2*aenv*asine
gaoutleft moogvcf2 aoutleft, gkfco, gkrez;
gaoutright moogvcf2 aoutright, gkfco, gkrez;
    outs        gaoutleft,gaoutright;
;   outs a2, a2
    endin
    instr 2
    arevL, arevR reverbsc gaoutleft,gaoutright, .3, 18000
  kthresh = 0
  kloknee = 40
  khiknee = 60
  kratio  = 2
  katt    = 0.1
  krel    = .5
  ilook   = .02
arevL compress arevL, gaoutleft, kthresh, kloknee,\
 khiknee, kratio, katt, krel, ilook
arevR compress arevR, gaoutright, kthresh, kloknee,\
 khiknee, kratio, katt, krel, ilook
    outs arevL, arevR
    endin
;;TURNON;;
f0 360000;
} nchnls = 2
sr = 44100
ksmps = 128
0dbfs = 1
#define MATRIX       #"circularstring-128"#
;       Parameter        CC#
#define ATTACK       #  17  #
#define DECAY        #  18  #
#define SUSTAIN          #  19  #
#define RELEASE      #  20  #
#define FILTER           #  21  #
#define RESONANCE    #  22  #
#define SUBSINE          #   23   #
#define CENTERING    #   24   #
#define DAMPING          #   25   #
#define STEREOOFFSET     #   26   #
#define RATE         #   1   #
;Profiles
gipos     ftgen 1, 0, 128  ,  10, 1
gifnvel   ftgen 6, 0, 128  ,  -7, 0, 128, 0.1
gifnmass  ftgen 2, 0, 128  ,  -7, 1, 128, 1
gifnstif  ftgen 3, 0, 16384, -23, $MATRIX.
gifncentr ftgen 4, 0, 128  ,  -7, 1, 128, 2
gifndamp  ftgen 5, 0, 128  ,  -7, 1, 128, 1
gifntraj  ftgen 7, 0, 128, -5, .001, 128, 128.
gifnsine  ftgen 8, 0, 8192, 10, 1
turnon 2;Reverb instrument
#include "smartBalance.udo"
gkatt init .005
gkdec init .005
gksus init 1
gkrel init .002
gksin init .5
gkcentr init .1
gkdamp init -.01
gkstof init 0
gkfco init 100000
gkrez init .2
gkrate init .007
ctrlinit 1, $ATTACK, 3
ctrlinit 1, $DECAY, 3
ctrlinit 1, $SUSTAIN,  127
ctrlinit 1, $RELEASE,  1
ctrlinit 1, $SUBSINE, 64
ctrlinit 1, $CENTERING, 2
ctrlinit 1, $DAMPING, 0
ctrlinit 1, $STEREOOFFSET, 0
ctrlinit 1, $RATE, 64
ctrlinit 1, $FILTER, 64
ctrlinit 1, $RESONANCE, 10
            instr 1
        ;ADSR;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        gkatt midic7 $ATTACK , .0051 , 2
        gkdec midic7 $DECAY , .0051 ,2
        gksus midic7 $SUSTAIN , .0051 ,1
        gkrel midic7 $RELEASE ,  .002 , 2
        ;;FUNAMENTAL;;VOL;;;;;;;;;;;;;
        gksin midic7 $SUBSINE , 0  , 1
        ;;CENTERING;;SCALING;;;;;;;;;;;;;;
        gkcentr midic7 $CENTERING, 0 , .10
        ;;;DAMPING;;SCALING;;;;;;;;;;;;;;;;
        gkdamp midic7   $DAMPING , -.11 , 0
        ;;Stereo;;Offset;;;;;;;;;;;;;;;;;;;;;;
        gkstof midic7   $STEREOOFFSET , 0 , .1
        ;FILTER;;;;;;;;;;;;;;;;;;;;;;;;;;
        gkfco midic7 $FILTER , 100 , 10000 , gifntraj
        gkrez midic7 $RESONANCE , 0 , .7
        ;;;;;Rate;;;;;;;;;;;;;;;;;;;;;;;;;
        gkrate midic7   $RATE , .001 , .04
ain         = 0
;MIDI;VEL;to;SCAN;
istif ampmidi 1;
imass ampmidi 2  ;
;;MIDI;;VEL;;To VOLUME;
iamp ampmidi ampdb(75)/32767;
;MIDI;PCH;to;SCAN;
kcps cpsmidib 2  ;
;VOLUME;ADSR;;;;A;;;;;;;;;D;;;;;;;;;S;;;;;;;;;R;;;;;;
iatt = i (gkatt)
idec =  i (gkdec)
islev = i (gksus)
irel = i (gkrel)
aenv mxadsr iatt+.02, idec+.01, islev+.01, irel+.01 ;;
a2 oscil iamp, kcps, gifnsine;
irate = i(gkrate)
kmass = 1
kstif = 0.1
ileft = 0
iright = 1
kpos = 0
kstrngth = 0
ain = 0
idisp = 0
id = 22
scanu gipos, irate, gifnvel, gifnmass, \
gifnstif, gifncentr, gifndamp, kmass,  \
kstif, gkcentr, gkdamp, ileft, iright,\
kpos, kstrngth, ain, idisp, id
a1  scans   iamp, kcps,gifntraj, id,   4
a1 smartBalance a1, a2, iatt+.2
id2 = 23
scanu gipos, irate, gifnvel, gifnmass, \
gifnstif, gifncentr, gifndamp, kmass,  \
kstif, gkcentr+gkstof, gkdamp, ileft, iright,\
kpos, kstrngth, ain, idisp, id2
a3  scans   iamp, kcps,gifntraj, id2,   4
a3 smartBalance a3, a2, iatt+.2
asine upsamp gksin;
aoutleft = a1*aenv + a2*aenv*asine
aoutright = a3*aenv + a2*aenv*asine
gaoutleft moogvcf2 aoutleft, gkfco, gkrez;
gaoutright moogvcf2 aoutright, gkfco, gkrez;
    outs        gaoutleft,gaoutright;
;   outs a2, a2
    endin
    instr 2
    arevL, arevR reverbsc gaoutleft,gaoutright, .3, 18000
  kthresh = 0
  kloknee = 40
  khiknee = 60
  kratio  = 2
  katt    = 0.1
  krel    = .5
  ilook   = .02
arevL compress arevL, gaoutleft, kthresh, kloknee,\
 khiknee, kratio, katt, krel, ilook
arevR compress arevR, gaoutright, kthresh, kloknee,\
 khiknee, kratio, katt, krel, ilook
    outs arevL, arevR
    endin
;;TURNON;;
f0 360000;
```

To run this instrument you have to keep the .csd in the same folder as its helper files, circularstring-128 and smartBalance.udo. The download unzips ready to go.

If you copy and the paste the code and try to run the code, it will give you errors.

This instrument has 11 continuous controls, where you can map midi knobs to scanned synthesis controls, ADSR, a filter, and a sub oscillator. This instrument, by default, responds to MIDI Channel 1.

```


;       Parameter               CC#


#define ATTACK		 #	17	#


#define DECAY		 #	18	#


#define SUSTAIN	         #	19	#


#define RELEASE 	 #	20	#

#define FILTER           #	21	#


#define RESONANCE        #	22	#

#define SUBSINE          #      23      #

#define CENTERING        #      24      #


#define DAMPING          #      25      #


#define STEREOOFFSET     #      26      #


#define RATE 		 #      1       #


```

The rest of this article gets progressively more technical, you have enough so far to start making music with scanned synthesis.



[]()[]()

If you're an expert on scanned syntheis. You can edit the Profiles in this block-

```


;Profiles


gipos     ftgen 1, 0, 128  ,  10, 1


gifnvel   ftgen 6, 0, 128  ,  -7, 0, 128, 0.1


gifnmass  ftgen 2, 0, 128  ,  -7, 1, 128, 1


gifnstif  ftgen 3, 0, 16384, -23, $MATRIX.


gifncentr ftgen 4, 0, 128  ,  -7, 1, 128, 2


gifndamp  ftgen 5, 0, 128  ,  -7, 1, 128, 1


gifntraj  ftgen 7, 0, 128, -5, .001, 128, 128.


gifnsine  ftgen 8, 0, 8192, 10, 1


```

If you want to turn off the reverb, comment out the following line

```


turnon 2


```

The reverb is pretty nice, though. It uses Sean Costello's waveguide reverb opcode.

The signal going to Sean's opcode is put through an expander so that the louder dynamics reverberate more than softer dynamics.

Then the reverb is ducked by the dry signal, so that the reverb doesn't get in the way of the dry sound.

```


instr 2


arevL, arevR reverbsc gaoutleft,gaoutright, .3,\


 18000


  kthresh = 0


  kloknee = 40


  khiknee = 60


  kratio  = 2


  katt    = 0.1


  krel    = .5


  ilook   = .02


arevL compress arevL, gaoutleft, kthresh,\


kloknee,khiknee, kratio, katt, krel, ilook


arevR compress arevR, gaoutright, kthresh,\


kloknee,khiknee, kratio, katt, krel, ilook


	outs arevL, arevR


	endin


```

The next lines import a user defined opcode, a way of encapsulating code for easy re-use.

```


#include "smartBalance.udo"


```

Read more about this UDO 
[here](http://www.tophersaunders.com/wp/?p=672)

In order to use Csound with MIDI, you have to initialize not only the MIDI controls


```


ctrlinit 1, $ATTACK, 3


ctrlinit 1, $DECAY, 3


ctrlinit 1, $SUSTAIN, 127


ctrlinit 1, $RELEASE, 1

ctrlinit 1, $SUBSINE, 64


ctrlinit 1, $CENTERING, 2


ctrlinit 1, $DAMPING, 0


ctrlinit 1, $STEREOOFFSET, 0


ctrlinit 1, $RATE, 64

ctrlinit 1, $FILTER, 64


ctrlinit 1, $RESONANCE, 10


```

, but also you have to initialize the global variables used by the instrument, or the model(if you're thinking Model-View-Controller).

```


gkatt init .005


gkdec init .005


gksus init 1


gkrel init .002

gksin init .5


gkcentr init .1


gkdamp init -.01


gkstof init 0


gkfco init 100000


gkrez init .2


gkrate init .007


```

Ah so lets get to the instrument, here's where we actually read the values from the MIDI controller.

```


	instr 1


;ADSR;;;;;;;;;;;;;;;;;;;;;;;;;;;;


gkatt midic7 $ATTACK , .0051 , 2


gkdec midic7 $DECAY , .0051 ,2


gksus midic7 $SUSTAIN , .0051 ,1


gkrel midic7 $RELEASE ,  .002 , 2


;;FUNAMENTAL;;VOL;;;;;;;;;;;;;


gksin midic7 $SUBSINE , 0  , 1


;;CENTERING;;SCALING;;;;;;;;;;;;;;


gkcentr midic7 $CENTERING, 0 , .10


;;;DAMPING;;SCALING;;;;;;;;;;;;;;;;


gkdamp midic7	$DAMPING , -.11 , 0


;;Stereo;;Offset;;;;;;;;;;;;;;;;;;;;;;


gkstof midic7 	$STEREOOFFSET , 0 , .1


;FILTER;;;;;;;;;;;;;;;;;;;;;;;;;;


gkfco midic7 $FILTER , 100 , 10000 , gifntraj


gkrez midic7 $RESONANCE , 0 , .7


;;;;;Rate;;;;;;;;;;;;;;;;;;;;;;;;;


gkrate midic7	$RATE , .001 , .04


```

This instrument does not use audio injection so we set the required ain variable to 0

```


ain = 0


```

The mass and stiffness of the scanned system is influenced by MIDI velocity.

```


;MIDI;VEL;to;SCAN;


istif ampmidi 1;


imass ampmidi 2  ;


```

Also, MIDI key velocity should have an effect on overall amplitude.

```


;;MIDI;;VEL;;To VOLUME;


iamp ampmidi ampdb(75)/32767;


```

Lets get pitch from the key, with pitchbend.

```


kcps cpsmidib 2  ;


```

if you want to change the range of the pitch bend in semitones, you edit this line. Default is 2 semitones.

The lines below generate our ADSR envelope to be applied to the signal later. Notice the MIDI control of ADSR values.

```


;VOLUME;ADSR;


iatt = i (gkatt)     ; A


idec =  i (gkdec)    ; D


islev = i (gksus)    ; S


irel = i (gkrel)     ; R


aenv mxadsr iatt+.02,idec+.01,islev+.01,irel+.01


```

The next lines generate a sub oscillator tone

```


a2 oscil iamp, kcps, gifnsine;


```

If you wish to change the flavor of sub oscillator tone, (maybe you'd prefer a Sawtooth wave), edit this line of code, found back in the header with the profiles

```


gifnsine  ftgen 8, 0, 8192, 10, 1


```

The next lines set up Paris Smaragdis' opcode 
**scans. There are a total of 2 scanned oscillators, for stereo manipulation. This is the first one.**

```


irate = i(gkrate)


kmass = 1


kstif = 0.1


ileft = 0


iright = 1


kpos = 0


kstrngth = 0


ain = 0


idisp = 0


id = 22


scanu gipos, irate, gifnvel, gifnmass, \


gifnstif, gifncentr, gifndamp, kmass,  \


kstif, gkcentr, gkdamp, ileft, iright,\


kpos, kstrngth, ain, idisp, id


```

I tired to keep the same variable naming scheme for scanu as the Csound manual entry.

Now that our scanned wave is set up, lets scan it!

```


a1	scans	iamp, kcps,gifntraj, id,   4


```

we can edit scan trajectories in this line back in the profile header


```


gifntraj  ftgen 7, 0, 128, -5, .001, 128, 128.


```

Replacing this line with

```


gifntraj  ftgen 7, 0, 128, -7, 0, 128, 128.


```

is a quick hack to get a different sound.

our next line in the instrument calls the definition of the smart balance .udo I discussed in one of my previous 
[articles](http://www.tophersaunders.com/wp/?p=672)

```


a1 smartBalance a1, a2, iatt+.2


```

The next lines set up the second scanned oscillator


```

scanu gipos, irate, gifnvel, gifnmass, \


gifnstif, gifncentr, gifndamp, kmass, \


kstif, gkcentr+gkstof, gkdamp, ileft, iright,\


kpos, kstrngth, ain, idisp, id2


a3 scans iamp, kcps,gifntraj, id2, 4


```


except that now we have another variable gkstof in this part of the line


```


scanu gipos, irate, gifnvel, gifnmass, \


gifnstif, gifncentr, gifndamp, kmass, \


kstif, gkcentr+gkstof, gkdamp, ileft, iright,\


kpos, kstrngth, ain, idisp, id2


a3 scans iamp, kcps,gifntraj, id2, 4


```

gkstof sends a little bit more centering force to one of the oscillators, giving a stereo effect that is unique to scanned synthesis.

Next lets upsample our sub oscillator volume control and mix the sub oscillator with the scanned oscillators

```


asine upsamp gksin;


aoutleft = a1*aenv + a2*aenv*asine


aoutright = a3*aenv + a2*aenv*asine


```

at the final stage we apply Hans Mikelson and John Ffitch's opcode moogvcf, a warm filter with resonance.

```


gaoutleft moogvcf2 aoutleft, gkfco, gkrez;


gaoutright moogvcf2 aoutright, gkfco, gkrez;


```

and send our signal to the dac using the opcode outs. If you set up your configuration like Andrea's tutorial, then this is where the signal gets sent out to Soundflower, or JACK.

```


	outs		gaoutleft,gaoutright;


        endin


```

These are global variables so they can also be sent to the reverb instrument mentioned earlier in the article

Finally, this trick keeps Csound running for 360,000 seconds unless we quit, so that we can send Csound MIDI.

```






;;TURNON;;


f0 360000;








```

This line ensures that the instrument is compatible with earlier versions of Csound. I think the newest Csound version doesn't need this line


```






;;TURNON;;


f0 360000;








```


and will stay running if left blank until we quit Csound, but I like to keep it in there just in case someone has an old version.](\"http://www.tophersaunders.com/csd/ScanMIDI.zip\")
