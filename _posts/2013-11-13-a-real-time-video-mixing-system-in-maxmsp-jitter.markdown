---
layout: post
status: publish
published: true
title: A real-time video mixing system in MaxMSP-Jitter
author: Topher
author_login: admin
author_email: csaunders@berklee.net
author_url: http://www.tophersaunders.com
excerpt: "In this post I'll give a brief walkthrough of a live video performance
  system I use to real-time video mixing for my gigs as VJ.\r\n\r\n[caption
  id=\"attachment_1213\" align=\"aligncenter\" width=\"300\"]
[![\"Screen](\"http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/xcal1-300x177.png\") Click to view full size.[/caption]\r\n\r\n"
wordpress_id: 1584
wordpress_url: http://localhost:8888/wp/?p=1584
date: '2013-11-13 00:01:59 -0800'
date_gmt: '2013-11-13 05:01:59 -0800'
categories:
- Code
- Graphics
tags:
- featured
---

In this post I'll give a brief walkthrough of a live video performance system I use to real-time video mixing for my gigs as VJ.

[img](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/xcal1.png)

Step 1: download and install this -

[Auvi_Software.zip 1.4 Mb](http://auv-i.com/Auvi_Software.zip)

This zip file installs a bunch of cool video effects that I use in the patch.

Step 2: download the app xCalibur 1.3 -

[xCalibur1_3.zip~1.4 Mb](http://www.tophersaunders.com/VJ/xcalibur1_3.app.zip)

I made the program in Max/MSP Jitter. You 
**don't need Max to use xCalibur. But you do need a MIDI controller that sends CC messages.**

The zip file contains documentation, but whats a blog post without a little how-to. So I'll give you the rundown now.

xCalibur mixes two videos at a time, but you can have 3 videos queued up.

Step 1.) Load videos


Drag a folder onto the green area labeled "Drop Video Folder Here."

Heres some videos to get you started.

[VJ_clips.zip 40 Mb](http://www.tophersaunders.com/VJ/Vj_clips.zip)

(to make your own videos, make sure you save them as quicktime movies. PHOTO JPEG codec works best. 320x240 is a small size but makes the controls more responsive and more fun. But xCalibur can handle 640x480.)

Step 2.) Setup MIDI

Make sure your MIDI controller is plugged in!

This menu to the top left shows the available devices. Your MIDI controller should show up in the drop down menu where the screen says "IAC Driver Bus 1". If you plug in your device after you load the program, simply click "loadbang" to re-initialize the menu with the available devices.

[![Select MIDI in](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/midinn-300x43.png)](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/midinn.png)

xCalibur comes configured to my MIDI setup cause its my rig. To set it up for your controller click the white circle with an orange border labeled "Edit MIDI".

[![Edit MIDI screen shot](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/editmidi.png)](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/editmidi.png)

You should see this window.

[caption id="attachment_1222" align="aligncenter" width="226"]
[![Edit MIDI Setup Picture](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/editmidisetup.png) Use this window to hook up the effects to your MIDI controller[/caption]](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/editmidisetup.png)

Match the CC number of your MIDI controller with the effects that work best for you.

These are the video effects,

**Xfade - Crossfades between the two videos.



**Pan X - Moves the video horizontally in the frame.



**Pan Y - Moves the video vertically in the frame.



**Filter - A "double vision" effect.



**Hue - Changes the color palette.



**Zoom Out - Makes the video smaller in the frame.



**Feedback - Smears the video. *high values may cause whiteout so if you see a boring white screen turn this down.



**Contrast - Changes the color intensites. This MIDI CC is quantized to 3 settings - Normal, High, and Reverse Contrast.



**Brightness - How "loud" or white the pixels are.******************

Step 3.) Turn on the player.

Find the video player. It looks like this

[![Locate the first video player](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/Screen-Shot-2013-03-11-at-12.01.52-PM.png)](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/Screen-Shot-2013-03-11-at-12.01.52-PM.png)

To queue up a video. 1.) Select a video from the menu. If nothing is there then you didn't load the videos correctly and go back to Step 1. in this article. 2.) click the white box to turn on the preview. This white box with an orange background toggles a "Cue" that shows you how the video looks without any mixing or effects. 3.) Finally click the orange circle to send the video to the signal chain. This orange button acts as a "saftey"

Now that your video is queued, you can repeat this process for the second or third video players

[![The Three video Players](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/Screen-Shot-2013-03-11-at-12.06.24-PM-300x90.png)](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/Screen-Shot-2013-03-11-at-12.06.24-PM.png)

The white circles at the top of each player let you seek through the videos in the folder.

We're almost there! Finally, to get the videos to play turn your attention to the master on/off switch

[![Master Off](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/Screen-Shot-2013-03-11-at-12.08.33-PM.png)](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/Screen-Shot-2013-03-11-at-12.08.33-PM.png)

Click the orange circle button labeled "Master On/Off" to start your videos. This button keeps them all the frames synced together.

Once you click the orange button, the whole background of the program will turn to green to remind you that video is playing.

[![Master On](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/Screen-Shot-2013-03-11-at-12.10.44-PM.png)](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/Screen-Shot-2013-03-11-at-12.10.44-PM.png)

You may notice that your computer runs much slower now. Thats because it's processing video. Opening and closing windows takes a longer time. Better turn the thing off if you want to explore the patch.

Right now you should see a floating window with video in it. Get this video fullscreen, hit the Esc key on your computer's keyboard. If you have an external monitor or are hooked up to a projector via VGA or HDMI, you can drag this floating window to the second screen and then hit the esc key to fullscreen the video on the external display.

There's a "Cue" view - a smaller, embedded screen of what the final video output of the program is. The white box next to the "Hidden $1" toggles this. (having the "X" makes the video mix run faster.)

[![Hidden On](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/Screen-Shot-2013-03-11-at-12.23.18-PM-300x118.png)](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/Screen-Shot-2013-03-11-at-12.23.18-PM.png)

[![Toggle Cue Screen](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/Screen-Shot-2013-03-11-at-12.17.22-PM-300x123.png)](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/Screen-Shot-2013-03-11-at-12.17.22-PM.png)

From here on, its up to you to explore. There are some organizational things I built into the patch to keep you on the right path.

Anything Orange or with an orange border is a user control. Touch it! See what it does.

Anything with a black center and maroon border with white text is an expert control.

[![Screen Shot 2013-03-11 at 1.14.25 PM](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/Screen-Shot-2013-03-11-at-1.14.25-PM.png)](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/Screen-Shot-2013-03-11-at-1.14.25-PM.png)

[![VCR](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/Screen-Shot-2013-03-11-at-1.15.04-PM.png)](http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/Screen-Shot-2013-03-11-at-1.15.04-PM.png)

Anything that does NOT have a black center or orange border is something boring, so don't worry about those.

If you have any questions email me at 
[topher@tophersaunders.com](mailto:topher@tophersaunders.com)

-Topher](\"http://www.tophersaunders.com/wp/wp-content/uploads/2013/03/xcal1.png\")
