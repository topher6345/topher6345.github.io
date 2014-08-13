---
layout: post
status: publish
published: true
title: How to use Audacity to Glitch Images
author: Topher
date: '2012-06-25 21:17:18 -0700'
categories:
- Audio
- Graphics
tags:
- Audacity
- featured
---

[caption id="attachment_1007" align="aligncenter" width="300"]
[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/kramerDual-300x196.png) Before and After Processing with Audacity[/caption]](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/kramerDual.png)

In this article I'll show you how to use a free, open source audio editor - Audacity to glitch images.

[caption id="attachment_1010" align="aligncenter" width="300"]
[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/topherface7-300x225.png) A picture of my face processed by audacity[/caption]](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/topherface7.png)

**Step 1: download the right version of Audacity.**

The version I use for doing image processing is ver 1.2.5. 
This is not the latest version. go here get this older version 
[http://sourceforge.net/projects/audacity/files/audacity/](http://sourceforge.net/projects/audacity/files/audacity/)

Edit: May 21, 2013 - On Mac OSX Mountain Lion you 
can use the latest version of Audacity (ver. 2.3.0)

**Step 2: Configure Audacity Preferences**

Open Audacity's preferences by finding it the menu bar, or by using the Command-, (Command and the comma key) shortcut.

[caption id="attachment_1016" align="aligncenter" width="300"]
[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/Screen-Shot-2012-06-25-at-8.32.22-PM-300x247.png) Click to enlarge[/caption]](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/Screen-Shot-2012-06-25-at-8.32.22-PM.png)

Make your preferences look like the screenshot above. You will have to navigate to the "File Formats" tab, choose "other" from the "Uncompressed Export Format" menu. When you click "other" a pop up menu will appear.

![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/Screen-Shot-2012-06-25-at-8.37.02-PM.png)

Like the screenshot above, select RAW(header-less) as the Header option and A-Law as the encoding format. Essentially this lets Audacity export files with image headers. If these preferences are set incorrectly, Audacity might attach some sound file header, which screws up our game.

**Step 3: Use Import Raw to import a .bmp file into Audacity.**

Audacity has a neat "Import Raw Data" feature that most DAW's don't have. This is what we'll exploit in order to process images with audio effects.

![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/Screen-Shot-2012-06-25-at-8.45.13-PM-223x300.png)

What's important here is that we need to import a 
.bmp (windows bitmap) file. Not .
jpeg or 
.tiff or anything else.

When you choose your .bmp file, then this menu appears asking how you would like to import it. Choose the options so that it's like the screenshot

[caption id="attachment_1030" align="aligncenter" width="300"]
[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/Screen-Shot-2012-06-25-at-8.52.00-PM-300x204.png) Click to Enlarge[/caption]](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/Screen-Shot-2012-06-25-at-8.52.00-PM.png)

Choose 
A-Law as the sample format; 
Big-endian as the sample order; and 
1 Channel Mono. And then click import.

[caption id="attachment_1032" align="aligncenter" width="300"]
[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/Screen-Shot-2012-06-25-at-8.56.11-PM-300x27.png) You should end up with something that looks like this.[/caption]](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/Screen-Shot-2012-06-25-at-8.56.11-PM.png)

You don't have to listen to the audio. Its usually unpleasant. But go ahead, you know you're curious.

**Step 4: Apply Audio effects without messing up header.





The first quarter of a second is usually the .bmp header, 
don't apply effects to the header. If you mess up the header you'll end up with a file your operating system won't know what to do with, therefore it won't open in any application and be just some mysterious collection of junk data.**

[caption id="attachment_1036" align="aligncenter" width="300"]
![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/Screen-Shot-2012-06-25-at-9.04.10-PM-300x33.png) Don't screw up the header!![/caption]

I repeat: Don't apply effects to the header.

To export your audio-processed image click on File> Exmport as Raw...

[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/Screen-Shot-2012-06-25-at-9.18.02-PM-206x300.png)](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/Screen-Shot-2012-06-25-at-9.18.02-PM.png)

The file will export as a .raw file. This file can be opened by Preview and other Mac programs because OSX reads the header file regardless of the file extension. You can also open this type of file in photoshop. To save as another file type in OSX, simply open in preview and save as or export to .jpeg or .png or what have you.

You can experiment with all kinds of audio effects on your image files. I find the echo effect to be the most effective. It tends to smear multicolored copies of the image all over the place.

[caption id="attachment_1038" align="aligncenter" width="228"]
[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/kramer2-228x300.png) More Pronounced Echo[/caption]](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/kramer2.png)

High Pass filter takes out alot of the darker colors

[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/kramerHP-228x300.png)](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/kramerHP.png)

Low Pass filter makes things more grayscale and pastel-ish.

[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/kramerLP-228x300.png)](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/kramerLP.png)

Tremolo adds repeating lines to the picture

[![](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/kramerTrem-228x300.png)](http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/kramerTrem.png)

Notice how the top of the picture is not processed, this is because I left room for the header. You can experiment with how far towards the start of the file you can process, but know that .bmp headers have unpredictable size (unless you get real deep into the formatting.)

Theres nothing stopping you from layering images in multiple Audacity audio tracks.(make sure theres only one track that has any information for the first .25 seconds to protect the header) Also since most of the effects seem to work from top to bottom, you might want to bounce out an image, rotate it in an image program, and then process it again in Audacity, so that your effects can come from all sides.

I learned how to do this from this blog post - 
[http://www.hellocatfood.com/2009/11/16/databending-using-audacity/ However this guy's tutorial is for linux, and leaves out some crucial instructions for OSX.](http://www.hellocatfood.com/2009/11/16/databending-using-audacity/)](\"http://www.tophersaunders.com/wp/wp-content/uploads/2012/06/kramerDual.png\")
