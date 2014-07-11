---
layout: post
status: publish
published: true
title: How to use Audacity to Glitch Images
author:
  display_name: Topher
  login: admin
  email: csaunders@berklee.net
  url: http://www.tophersaunders.com
author_login: admin
author_email: csaunders@berklee.net
author_url: http://www.tophersaunders.com
excerpt: "[caption id=\"attachment_1007\" align=\"aligncenter\" width=\"300\"]<a href=\"http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;kramerDual.png\"
  target=\"_blank\"><img class=\"size-medium wp-image-1007\" title=\"kramerDual\"
  alt=\"\" src=\"http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;kramerDual-300x196.png\"
  width=\"300\" height=\"196\" &#47;><&#47;a> Before and After Processing with Audacity[&#47;caption]\r\n\r\nIn
  this article I'll show you how to use a free, open source audio editor - Audacity
  to glitch images.\r\n\r\n"
wordpress_id: 1006
wordpress_url: http://www.tophersaunders.com/wp/?p=1006
date: '2012-06-25 21:17:18 -0700'
date_gmt: '2012-06-26 01:17:18 -0700'
categories:
- Audio
- Graphics
tags:
- Audacity
- featured
---
<p>[caption id="attachment_1007" align="aligncenter" width="300"]<a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;kramerDual.png" target="_blank"><img class="size-medium wp-image-1007" title="kramerDual" alt="" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;kramerDual-300x196.png" width="300" height="196" &#47;><&#47;a> Before and After Processing with Audacity[&#47;caption]</p>
<p>In this article I'll show you how to use a free, open source audio editor - Audacity to glitch images.</p>
<p><a id="more"></a><a id="more-1006"></a></p>
<p>[caption id="attachment_1010" align="aligncenter" width="300"]<a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;topherface7.png"><img class="size-medium wp-image-1010" title="topherface7" alt="" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;topherface7-300x225.png" width="300" height="225" &#47;><&#47;a> A picture of my face processed by audacity[&#47;caption]</p>
<p><strong>Step 1: download the right version of Audacity.<&#47;strong></p>
<p>The version I use for doing image processing is ver 1.2.5. <em>This is not the latest version<&#47;em>. go here get this older version <a href="http:&#47;&#47;sourceforge.net&#47;projects&#47;audacity&#47;files&#47;audacity&#47;">http:&#47;&#47;sourceforge.net&#47;projects&#47;audacity&#47;files&#47;audacity&#47;<&#47;a></p>
<p>Edit: May 21, 2013 - On Mac OSX Mountain Lion you <em>can<&#47;em> use the latest version of Audacity (ver. 2.3.0)</p>
<p><strong>Step 2: Configure Audacity Preferences<&#47;strong></p>
<p>Open Audacity's preferences by finding it the menu bar, or by using the Command-, (Command and the comma key) shortcut.</p>
<p>[caption id="attachment_1016" align="aligncenter" width="300"]<a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;Screen-Shot-2012-06-25-at-8.32.22-PM.png" target="_blank"><img class="size-medium wp-image-1016" title="Screen Shot 2012-06-25 at 8.32.22 PM" alt="" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;Screen-Shot-2012-06-25-at-8.32.22-PM-300x247.png" width="300" height="247" &#47;><&#47;a> Click to enlarge[&#47;caption]</p>
<p>Make your preferences look like the screenshot above. You will have to navigate to the "File Formats" tab, choose "other" from the "Uncompressed Export Format" menu. When you click "other" a pop up menu will appear.</p>
<p><img class="aligncenter size-full wp-image-1020" title="Screen Shot 2012-06-25 at 8.37.02 PM" alt="" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;Screen-Shot-2012-06-25-at-8.37.02-PM.png" width="234" height="172" &#47;></p>
<p>Like the screenshot above, select RAW(header-less) as the Header option and A-Law as the encoding format. Essentially this lets Audacity export files with image headers. If these preferences are set incorrectly, Audacity might attach some sound file header, which screws up our game.</p>
<p><strong>Step 3: Use Import Raw to import a .bmp file into Audacity.<&#47;strong></p>
<p>Audacity has a neat "Import Raw Data" feature that most DAW's don't have. This is what we'll exploit in order to process images with audio effects.</p>
<p><img class="size-medium wp-image-1023 aligncenter" title="" alt="" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;Screen-Shot-2012-06-25-at-8.45.13-PM-223x300.png" width="223" height="300" &#47;></p>
<p>What's important here is that we need to import a <em>.bmp<&#47;em> (windows bitmap) file. Not .<em>jpeg <&#47;em>or <em>.tiff <&#47;em>or anything else.</p>
<p>When you choose your .bmp file, then this menu appears asking how you would like to import it. Choose the options so that it's like the screenshot</p>
<p>[caption id="attachment_1030" align="aligncenter" width="300"]<a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;Screen-Shot-2012-06-25-at-8.52.00-PM.png" target="_blank"><img class="size-medium wp-image-1030" title="Screen Shot 2012-06-25 at 8.52.00 PM" alt="" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;Screen-Shot-2012-06-25-at-8.52.00-PM-300x204.png" width="300" height="204" &#47;><&#47;a> Click to Enlarge[&#47;caption]</p>
<p>Choose <em>A-Law<&#47;em> as the sample format; <em>Big-endian<&#47;em> as the sample order; and <em>1 Channel Mono<&#47;em>. And then click import.</p>
<p>[caption id="attachment_1032" align="aligncenter" width="300"]<a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;Screen-Shot-2012-06-25-at-8.56.11-PM.png"><img class="size-medium wp-image-1032" title="Screen Shot 2012-06-25 at 8.56.11 PM" alt="" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;Screen-Shot-2012-06-25-at-8.56.11-PM-300x27.png" width="300" height="27" &#47;><&#47;a> You should end up with something that looks like this.[&#47;caption]</p>
<p>You don't have to listen to the audio. Its usually unpleasant. But go ahead, you know you're curious.</p>
<p><strong>Step 4: Apply Audio effects without messing up header.<br />
<&#47;strong><br />
The first quarter of a second is usually the .bmp header, <em>don't apply effects to the header.<&#47;em> If you mess up the header you'll end up with a file your operating system won't know what to do with, therefore it won't open in any application and be just some mysterious collection of junk data.</p>
<p>[caption id="attachment_1036" align="aligncenter" width="300"]<img class="size-medium wp-image-1036" title="Screen Shot 2012-06-25 at 9.04.10 PM" alt="" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;Screen-Shot-2012-06-25-at-9.04.10-PM-300x33.png" width="300" height="33" &#47;> Don't screw up the header!![&#47;caption]</p>
<p>I repeat: Don't apply effects to the header.</p>
<p>To export your audio-processed image click on File> Exmport as Raw...</p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;Screen-Shot-2012-06-25-at-9.18.02-PM.png"><img class="aligncenter size-medium wp-image-1043" title="Screen Shot 2012-06-25 at 9.18.02 PM" alt="" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;Screen-Shot-2012-06-25-at-9.18.02-PM-206x300.png" width="206" height="300" &#47;><&#47;a></p>
<p>The file will export as a .raw file. This file can be opened by Preview and other Mac programs because OSX reads the header file regardless of the file extension. You can also open this type of file in photoshop. To save as another file type in OSX, simply open in preview and save as or export to .jpeg or .png or what have you.</p>
<p>You can experiment with all kinds of audio effects on your image files. I find the echo effect to be the most effective. It tends to smear multicolored copies of the image all over the place.</p>
<p>[caption id="attachment_1038" align="aligncenter" width="228"]<a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;kramer2.png" target="_blank"><img class="size-medium wp-image-1038" title="kramer2" alt="" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;kramer2-228x300.png" width="228" height="300" &#47;><&#47;a> More Pronounced Echo[&#47;caption]</p>
<p>High Pass filter takes out alot of the darker colors</p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;kramerHP.png" target="_blank"><img class="aligncenter size-medium wp-image-1039" title="kramerHP" alt="" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;kramerHP-228x300.png" width="228" height="300" &#47;><&#47;a></p>
<p>Low Pass filter makes things more grayscale and pastel-ish.</p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;kramerLP.png" target="_blank"><img class="aligncenter size-medium wp-image-1040" title="kramerLP" alt="" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;kramerLP-228x300.png" width="228" height="300" &#47;><&#47;a></p>
<p>Tremolo adds repeating lines to the picture</p>
<p><a href="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;kramerTrem.png" target="_blank"><img class="aligncenter size-medium wp-image-1041" title="kramerTrem" alt="" src="http:&#47;&#47;www.tophersaunders.com&#47;wp&#47;wp-content&#47;uploads&#47;2012&#47;06&#47;kramerTrem-228x300.png" width="228" height="300" &#47;><&#47;a></p>
<p>Notice how the top of the picture is not processed, this is because I left room for the header. You can experiment with how far towards the start of the file you can process, but know that .bmp headers have unpredictable size (unless you get real deep into the formatting.)</p>
<p>Theres nothing stopping you from layering images in multiple Audacity audio tracks.(make sure theres only one track that has any information for the first .25 seconds to protect the header) Also since most of the effects seem to work from top to bottom, you might want to bounce out an image, rotate it in an image program, and then process it again in Audacity, so that your effects can come from all sides.</p>
<p>I learned how to do this from this blog post - <a href="http:&#47;&#47;www.hellocatfood.com&#47;2009&#47;11&#47;16&#47;databending-using-audacity&#47;" target="_blank">http:&#47;&#47;www.hellocatfood.com&#47;2009&#47;11&#47;16&#47;databending-using-audacity&#47;<&#47;a> However this guy's tutorial is for linux, and leaves out some crucial instructions for OSX.</p>
