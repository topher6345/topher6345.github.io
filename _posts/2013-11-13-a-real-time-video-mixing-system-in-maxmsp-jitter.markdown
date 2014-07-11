---
layout: post
status: publish
published: true
title: A real-time video mixing system in MaxMSP-Jitter
author:
  display_name: Topher
  login: admin
  email: csaunders@berklee.net
  url: http://www.tophersaunders.com
author_login: admin
author_email: csaunders@berklee.net
author_url: http://www.tophersaunders.com
excerpt: "<p>In this post I'll give a brief walkthrough of a live video performance
  system I use to real-time video mixing for my gigs as VJ.<&#47;p>\r\n\r\n<p>[caption
  id=\"attachment_1213\" align=\"aligncenter\" width=\"300\"]<a href=\"http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;xcal1.png\"><img
  class=\"size-medium wp-image-1213\" alt=\"Screen Shot of xCalibur 1.3\" src=\"http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;xcal1-300x177.png\"
  width=\"300\" height=\"177\" &#47;><&#47;a> Click to view full size.[&#47;caption]<&#47;p>\r\n\r\n"
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
<p>In this post I'll give a brief walkthrough of a live video performance system I use to real-time video mixing for my gigs as VJ.<&#47;p></p>
<p>[caption id="attachment_1213" align="aligncenter" width="300"]<a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;xcal1.png"><img class="size-medium wp-image-1213" alt="Screen Shot of xCalibur 1.3" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;xcal1-300x177.png" width="300" height="177" &#47;><&#47;a> Click to view full size.[&#47;caption]<&#47;p></p>
<p><a id="more"></a><a id="more-1584"></a></p>
<p>Step 1: download and install this -<&#47;p></p>
<p><a href="http:&#47;&#47;auv-i.com&#47;Auvi_Software.zip">Auvi_Software.zip<&#47;a> 1.4 Mb<&#47;p></p>
<p>This zip file installs a bunch of cool video effects that I use in the patch.<&#47;p></p>
<p>Step 2: download the app xCalibur 1.3 -<&#47;p></p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;VJ&#47;xcalibur1_3.app.zip">xCalibur1_3.zip<&#47;a>~1.4 Mb<&#47;p></p>
<p>I made the program in Max&#47;MSP Jitter. You <strong>don't<&#47;strong> need Max to use xCalibur. But you do need a MIDI controller that sends CC messages.<&#47;p></p>
<p>The zip file contains documentation, but whats a blog post without a little how-to. So I'll give you the rundown now.<&#47;p></p>
<p>xCalibur mixes two videos at a time, but you can have 3 videos queued up.<&#47;p></p>
<p>Step 1.) Load videos<br />
Drag a folder onto the green area labeled "Drop Video Folder Here."<&#47;p></p>
<p>Heres some videos to get you started.<&#47;p></p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;VJ&#47;Vj_clips.zip">VJ_clips.zip<&#47;a> 40 Mb<&#47;p></p>
<p>(to make your own videos, make sure you save them as quicktime movies. PHOTO JPEG codec works best. 320x240 is a small size but makes the controls more responsive and more fun. But xCalibur can handle 640x480.)<&#47;p></p>
<p>Step 2.) Setup MIDI<&#47;p></p>
<p>Make sure your MIDI controller is plugged in!<&#47;p></p>
<p>This menu to the top left shows the available devices. Your MIDI controller should show up in the drop down menu where the screen says "IAC Driver Bus 1". If you plug in your device after you load the program, simply click "loadbang" to re-initialize&nbsp;the menu with the&nbsp;available&nbsp;devices.<&#47;p></p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;midinn.png"><img class="aligncenter size-medium wp-image-1233" alt="Select MIDI in" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;midinn-300x43.png" width="300" height="43" &#47;><&#47;a><&#47;p></p>
<p>xCalibur comes configured to my MIDI setup cause its my rig. To set it up for your controller click the white circle with an orange border labeled "Edit MIDI".<&#47;p></p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;editmidi.png"><img class="aligncenter size-full wp-image-1226" alt="Edit MIDI screen shot" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;editmidi.png" width="254" height="128" &#47;><&#47;a><&#47;p></p>
<p>You should see this window.<&#47;p></p>
<p>[caption id="attachment_1222" align="aligncenter" width="226"]<a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;editmidisetup.png"><img class="size-full wp-image-1222" alt="Edit MIDI Setup Picture" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;editmidisetup.png" width="226" height="223" &#47;><&#47;a> Use this window to hook up the effects to your MIDI controller[&#47;caption]<&#47;p></p>
<p>Match the CC number of your MIDI controller with the effects that work best for you.<&#47;p></p>
<p>These are the video effects,<&#47;p></p>
<p><em><strong>Xfade<&#47;strong><&#47;em> - Crossfades between the two videos.<br />
<em><strong>Pan X<&#47;strong><&#47;em> - Moves the video horizontally in the frame.<br />
<em><strong>Pan Y<&#47;strong><&#47;em> - Moves the video vertically in the frame.<br />
<em><strong>Filter<&#47;strong><&#47;em> - A "double vision" effect.<br />
<em><strong>Hue<&#47;strong><&#47;em> - Changes the color palette.<br />
<em><strong>Zoom Out<&#47;strong><&#47;em> - Makes the video smaller in the frame.<br />
<em><strong>Feedback<&#47;strong><&#47;em> - Smears the video. *high values may cause whiteout so if you see a boring white screen turn this down.<br />
<em><strong>Contrast<&#47;strong><&#47;em> - Changes the color intensites. This MIDI CC is quantized to 3 settings - Normal, High, and Reverse Contrast.<br />
<em><strong>Brightness<&#47;strong><&#47;em> - How "loud" or white the pixels are.<&#47;p></p>
<p>Step 3.) Turn on the player.<&#47;p></p>
<p>Find the video player. It looks like this<&#47;p></p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;Screen-Shot-2013-03-11-at-12.01.52-PM.png"><img class="aligncenter size-full wp-image-1234" alt="Locate the first video player" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;Screen-Shot-2013-03-11-at-12.01.52-PM.png" width="237" height="217" &#47;><&#47;a><&#47;p></p>
<p>To queue up a video. 1.) Select a video from the menu. If nothing is there then you didn't load the videos correctly and go back to Step 1. in this article. 2.) click the white box to turn on the preview. This white box with an orange background toggles a "Cue" that shows you how the video looks without any mixing or effects. 3.) Finally click the&nbsp;orange&nbsp;circle to send the video to the signal chain. This orange button acts as a "saftey"<&#47;p></p>
<p>Now that your video is queued, you can repeat this process for the second or third video players<&#47;p></p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;Screen-Shot-2013-03-11-at-12.06.24-PM.png"><img class="aligncenter size-medium wp-image-1235" alt="The Three video Players" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;Screen-Shot-2013-03-11-at-12.06.24-PM-300x90.png" width="300" height="90" &#47;><&#47;a><&#47;p></p>
<p>The white circles at the top of each player let you seek through the videos in the folder.<&#47;p></p>
<p>We're almost there! Finally, to get the videos to play turn your attention to the master on&#47;off switch<&#47;p></p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;Screen-Shot-2013-03-11-at-12.08.33-PM.png"><img class="aligncenter size-full wp-image-1236" alt="Master Off" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;Screen-Shot-2013-03-11-at-12.08.33-PM.png" width="219" height="199" &#47;><&#47;a><&#47;p></p>
<p>Click the orange circle button labeled "Master On&#47;Off" to start your videos. This button keeps them all the frames synced together.<&#47;p></p>
<p>Once you click the orange button, the whole background of the program will turn to green to remind you that video is playing.<&#47;p></p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;Screen-Shot-2013-03-11-at-12.10.44-PM.png"><img class="aligncenter size-full wp-image-1237" alt="Master On" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;Screen-Shot-2013-03-11-at-12.10.44-PM.png" width="225" height="188" &#47;><&#47;a><&#47;p></p>
<p>You may notice that your computer runs much slower now. Thats because it's&nbsp;processing&nbsp;video. Opening and closing windows takes a longer time. Better turn the thing off if you want to explore the patch.<&#47;p></p>
<p>Right now you should see a floating window with video in it. Get this video fullscreen, hit the Esc key on your computer's keyboard. If you have an external monitor or are hooked up to a projector via VGA or HDMI, you can drag this floating window to the second screen and then hit the esc key to fullscreen the video on the external display.<&#47;p></p>
<p>There's a "Cue" view - a smaller, embedded screen of what the final video output of the program is. The white box next to the "Hidden $1" toggles this. (having the "X" makes the video mix run faster.)<&#47;p></p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;Screen-Shot-2013-03-11-at-12.23.18-PM.png"><img class="aligncenter size-medium wp-image-1239" alt="Hidden On" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;Screen-Shot-2013-03-11-at-12.23.18-PM-300x118.png" width="300" height="118" &#47;><&#47;a><&#47;p></p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;Screen-Shot-2013-03-11-at-12.17.22-PM.png"><img class="aligncenter size-medium wp-image-1238" alt="Toggle Cue Screen" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;Screen-Shot-2013-03-11-at-12.17.22-PM-300x123.png" width="300" height="123" &#47;><&#47;a><&#47;p></p>
<p>From here on, its up to you to explore. There are some organizational things I built into the patch to keep you on the right path.<&#47;p></p>
<p>Anything Orange or with an orange border is a user control. Touch it! See what it does.<&#47;p></p>
<p>Anything with a black center and maroon border with white text is an expert control.<&#47;p></p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;Screen-Shot-2013-03-11-at-1.14.25-PM.png"><img class="aligncenter size-full wp-image-1241" alt="Screen Shot 2013-03-11 at 1.14.25 PM" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;Screen-Shot-2013-03-11-at-1.14.25-PM.png" width="101" height="32" &#47;><&#47;a><&#47;p></p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;Screen-Shot-2013-03-11-at-1.15.04-PM.png"><img class="aligncenter size-full wp-image-1242" alt="VCR" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2013&#47;03&#47;Screen-Shot-2013-03-11-at-1.15.04-PM.png" width="101" height="33" &#47;><&#47;a><&#47;p></p>
<p>Anything that does NOT have a black center or orange border is something boring, so don't worry about those.<&#47;p></p>
<p>If you have any questions email me at <a href="mailto:topher@tophersaunders.com">topher@tophersaunders.com<&#47;a><&#47;p></p>
<p>-Topher<&#47;p></p>
