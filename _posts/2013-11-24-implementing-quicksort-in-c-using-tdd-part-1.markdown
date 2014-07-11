---
layout: post
status: publish
published: true
title: Implementing quicksort in C using TDD Part 1
author:
  display_name: Topher
  login: admin
  email: csaunders@berklee.net
  url: http://www.tophersaunders.com
author_login: admin
author_email: csaunders@berklee.net
author_url: http://www.tophersaunders.com
excerpt: "Let's examine a classic computer science question - <em>how to alphabetically
  sort words.<&#47;em>\r\n\r\nIn the first part, we'll examine the problem and set
  up a test-driven-development template. \r\n\r\nIn part 2 we'll examine the quicksort
  algorithm, and implement it to get our test to pass. \r\n\r\nHeres our list of words
  (or 'strings' in C speak). They're the names of some of my friend's cats. \r\n\r\nWe'll
  be using this list throughout the tutorial.\r\n<ol>\r\n  <li>Bryaxis<&#47;li>\r\n
  \ <li>Batman<&#47;li>\r\n  <li>Sadie<&#47;li>\r\n  <li>Milo<&#47;li>\r\n  <li>Lou<&#47;li>\r\n<&#47;ol>\r\n\r\n"
wordpress_id: 1587
wordpress_url: http://www.tophersaunders.com/wp/?p=1587
date: '2013-11-24 15:23:10 -0800'
date_gmt: '2013-11-24 20:23:10 -0800'
categories:
- Code
tags: []
---
<p>Let's examine a classic computer science question - <em>how to alphabetically sort words.<&#47;em></p>
<p>In the first part, we'll examine the problem and set up a test-driven-development template. </p>
<p>In part 2 we'll examine the quicksort algorithm, and implement it to get our test to pass. </p>
<p>Heres our list of words (or 'strings' in C speak). They're the names of some of my friend's cats. </p>
<p>We'll be using this list throughout the tutorial.</p>
<ol>
<li>Bryaxis<&#47;li>
<li>Batman<&#47;li>
<li>Sadie<&#47;li>
<li>Milo<&#47;li>
<li>Lou<&#47;li><br />
<&#47;ol></p>
<p><a id="more"></a><a id="more-1587"></a></p>
<p><a href="https:&#47;&#47;github.com&#47;topher6345&#47;sort-strings-alphabetically-in-c">On github<&#47;a></p>
<p><a href="https:&#47;&#47;github.com&#47;topher6345&#47;sort-strings-alphabetically-in-c&#47;archive&#47;master.zip">Download example files<&#47;a><br />
In Ruby, my weapon of choice for dealing with strings, it goes like this.</p>
<p>fire up irb in your terminal window and type<br />
[code lang="ruby"]<br />
@names = ['Bryaxis', 'Batman', 'Sadie', 'Milo', 'Lou']<br />
@names.sort<br />
[&#47;code]</p>
<p>Python is also good with strings </p>
<p>Open the python interpreter and type<br />
[code lang="python"]<br />
names = ['Bryaxis', 'Batman', 'Sadie', 'Milo', 'Lou']<br />
sorted(names)<br />
[&#47;code]</p>
<p>In these languages, string sorting has already be implemented, but we want to examine <em>how<&#47;em> an algorithm like this is structured and implemented. So let's get low-level and work it out in C.</p>
<p>If we're gonna reinvent the wheel, let's do it right and use <a href="http:&#47;&#47;en.wikipedia.org&#47;wiki&#47;Test-driven_development" target="_blank">test driven development<&#47;a>. A software development technique designed to reduce frustration and make software development FUN. </p>
<p>The idea is simple, you write a <em>failing test<&#47;em> and then you write the code required to pass it. Its a built in reward system. Instead of wondering "did my program do what I wanted it to do?" you can have the software <em>tell you<&#47;em> it works. </p>
<p>We'll start with a simple C file </p>
<p>[code lang="c"]<br />
#include <stdio.h><br />
#include <assert.h></p>
<p>int main() {<br />
    assert(0);<br />
    return 0;<br />
}<br />
[&#47;code]</p>
<p>Compile and run this and you should see<br />
[code gutter="false"]<br />
Assertion failed: (0), function main, file main.c, line 5.<br />
Abort trap<br />
[&#47;code]</p>
<p>If you are unfamiliar with TDD, you might be wondering what assert() is all about. </p>
<p>'assert()' is like a sanity test. It passes if true (the integer 1 in C) and fails if false (0). Our first bit of code here tests the test. We can make sure it passes on true by inserting a positive assert.<br />
This way, our code compiles without errors, but stops on execution if our algorithm isn't doing what we want it to.<br />
[code lang="c"]<br />
#include <stdio.h><br />
#include <assert.h></p>
<p>int main() {<br />
    assert(1);<br />
    assert(0);<br />
    return 0;<br />
}<br />
[&#47;code]</p>
<p>Compile and run this and you should see<br />
[code gutter="false"]<br />
Assertion failed: (0), function main, file main.c, line 6.<br />
Abort trap<br />
[&#47;code]</p>
<p>Notice that it failed on line 6, but not on line 5. this should make you comfortable enough with the assert() function to continue on. </p>
<p>Since we will be dealing with words, lets add the string.h header, and some string comparison assertions to our code.</p>
<p>[code highlight="3,5,6,7,8" language="c"]<br />
#include <stdio.h><br />
#include <assert.h><br />
#include <string.h><br />
int main() {<br />
	char unsortedWords[] = "false";<br />
	char alphabetizedWords[] = "true";<br />
	assert(!strcmp(unsortedWords,unsortedWords));<br />
	assert(!strcmp(unsortedWords,alphabetizedWords));<br />
	return 0;<br />
}<br />
[&#47;code]</p>
<p>Compile and run this and you should see<br />
[code gutter="false"]<br />
Assertion failed: (!strcmp(unsortedWords,sortedWords)), function main, file main.c, line 8.<br />
Abort trap<br />
[&#47;code]</p>
<p>We are using the strcmp() function to compare two strings, notice the ! before strcmp(), because strcmp() is weird and returns 0 if the strings don't match and 1 if they do. (welcome to C, where up is down and down is up, I miss ruby already)</p>
<p>This gets us closer to being able to test if we correctly implemented a way to alphabetize words. We're not all the way there yet, because we can only test if one word is the same as another, so lets modify our code further to make a robust failing test to see if two arrays of strings are the same.</p>
<p>We'll need a way to iterate through an array of strings and compare each individual string in the array.</p>
<p>[code highlight="5,6,7,8" language="c"]<br />
#include <stdio.h><br />
#include <assert.h><br />
#include <string.h><br />
int main() {<br />
	char      *unsortedWords[5] = {"Bryaxis", "Batman" , "Sadie", "Milo", "Lou"  };<br />
	char  *alphabetizedWords[5] = {"Batman" , "Bryaxis", "Lou"  , "Milo", "Sadie"};<br />
	assert(!strcmp(unsortedWords[0],    unsortedWords[0]));<br />
	assert(!strcmp(unsortedWords[0],alphabetizedWords[0]));<br />
	return 0;<br />
}<br />
[&#47;code]</p>
<p>If we run this, then we should get this message<br />
[code]<br />
Assertion failed: (!strcmp(unsortedWords[0],alphabetizedWords[0])), function main, file main.c, line 8.<br />
Abort trap<br />
[&#47;code]</p>
<p>Which tells us that the first word (aka string) in the array is not the same. </p>
<p>So lets modify our code furthur to check every single word in the array. </p>
<p>[code collapse="true" language="c"]<br />
#include <stdio.h><br />
#include <assert.h><br />
#include <string.h><br />
int main() {<br />
	char      *unsortedWords[5] = {"Bryaxis", "Batman" , "Sadie", "Milo", "Lou"  };<br />
	char  *alphabetizedWords[5] = {"Batman" , "Bryaxis", "Lou"  , "Milo", "Sadie"};<br />
	int  metaTest[5];<br />
	int  realTest[5];<br />
	int i;<br />
	for (i=0; i < 5; i++){<br />
		metaTest[i] = (!strcmp(unsortedWords[i], unsortedWords[i]));<br />
		realTest[i] = (!strcmp(unsortedWords[i],alphabetizedWords[i]));<br />
	}<br />
	printf("MetaTest:\n");<br />
	for (i=0; i < 5; i++){<br />
		printf("Success! unsortedWords[%d] '%s' matches unsortedWords[%d] '%s'.\n", i, unsortedWords[i], i,  unsortedWords[i] );<br />
	}<br />
	printf("RealTest:\n");<br />
	for (i=0; i < 5; i++){</p>
<p>		if (realTest[i]) {<br />
			printf("Success! unsortedWords[%d] '%s' matches unsortedWords[%d] '%s'.\n", i, unsortedWords[i], i,  unsortedWords[i] );<br />
		}<br />
		else {<br />
			printf("Failure! unsortedWords[%d] '%s' doesn't match alphabetizedWords[%d] '%s'.\n", i, unsortedWords[i],i,  alphabetizedWords[i] );<br />
		}<br />
	}<br />
	return 0;<br />
}<br />
[&#47;code]</p>
<p>Compile and run this code and you should see<br />
[code]<br />
MetaTest:<br />
Success! unsortedWords[0] 'Bryaxis' matches unsortedWords[0] 'Bryaxis'.<br />
Success! unsortedWords[1] 'Batman' matches unsortedWords[1] 'Batman'.<br />
Success! unsortedWords[2] 'Sadie' matches unsortedWords[2] 'Sadie'.<br />
Success! unsortedWords[3] 'Milo' matches unsortedWords[3] 'Milo'.<br />
Success! unsortedWords[4] 'Lou' matches unsortedWords[4] 'Lou'.<br />
RealTest:<br />
Failure! unsortedWords[0] 'Bryaxis' doesn't match alphabetizedWords[0] 'Batman'.<br />
Failure! unsortedWords[1] 'Batman' doesn't match alphabetizedWords[1] 'Bryaxis'.<br />
Failure! unsortedWords[2] 'Sadie' doesn't match alphabetizedWords[2] 'Lou'.<br />
Success! unsortedWords[3] 'Milo' matches unsortedWords[3] 'Milo'.<br />
Failure! unsortedWords[4] 'Lou' doesn't match alphabetizedWords[4] 'Sadie'.<br />
[&#47;code]</p>
<p>We have a automatic way to test if two arrays of words are the same. But its a little hard to infer that so, at the risk of going on a tangent here, I'm going to add some terminal colors to this output. Here I should mention I'm on OSX 10.6 so this color codes might not work for you. Along the way I'll enforce some better coding style-like not having lines longer than 79 columns.</p>
<p>[code collapse="true" language="c"]<br />
#include <stdio.h><br />
#include <assert.h><br />
#include <string.h><br />
#define RESET   "&#92;&#48;33[0m"<br />
#define BLACK   "&#92;&#48;33[30m"      &#47;* Black *&#47;<br />
#define RED     "&#92;&#48;33[31m"      &#47;* Red *&#47;<br />
#define GREEN   "&#92;&#48;33[32m"      &#47;* Green *&#47;<br />
int main() {<br />
	char      *unsortedWords[5] = {"Bryaxis",<br />
									"Batman",<br />
									 "Sadie",<br />
									  "Milo",<br />
									   "Lou"};<br />
	char  *alphabetizedWords[5] = {"Batman",<br />
	              				  "Bryaxis",<br />
	              				      "Lou",<br />
	              				     "Milo",<br />
	              				    "Sadie"};<br />
	int  metaTest[5];<br />
	int  realTest[5];<br />
	int i;<br />
	for (i=0; i < 5; i++){<br />
		metaTest[i] = (!strcmp(unsortedWords[i], unsortedWords[i]));<br />
		realTest[i] = (!strcmp(unsortedWords[i],alphabetizedWords[i]));<br />
	}<br />
	printf("MetaTest:\n");<br />
	for (i=0; i < 5; i++){<br />
		printf(GREEN);<br />
		printf("Success! unsortedWords[%d] '%s'",i, unsortedWords[i]);<br />
		printf("matches");<br />
		printf("unsortedWords[%d] '%s'.\n", i,  unsortedWords[i]);<br />
		printf(RESET);<br />
	}<br />
	printf("RealTest:\n");<br />
	for (i=0; i < 5; i++){</p>
<p>		if (realTest[i]) {<br />
			printf(GREEN);<br />
			printf("Success! unsortedWords[%d] '%s'",i, unsortedWords[i]);<br />
			printf("matches");<br />
			printf("alphabetizedWords[%d] '%s'.\n", i,  unsortedWords[i]);<br />
			printf(RESET);</p>
<p>		}<br />
		else {<br />
			printf(RED);<br />
			printf("Failure! unsortedWords[%d] '%s'",i, unsortedWords[i]);<br />
			printf("doesn't match");<br />
			printf("alphabetizedWords[%d] '%s'.\n", i,  alphabetizedWords[i]);<br />
			printf(RESET);<br />
		}<br />
	}<br />
	return 0;<br />
}<br />
[&#47;code]</p>
<p>Our code is getting a little verbose, so we put our test into a function. And comment out our metatest</p>
<p>[code collapse="true" language="c"]<br />
#include <stdio.h><br />
#include <assert.h><br />
#include <string.h><br />
#define RESET   "&#92;&#48;33[0m"<br />
#define BLACK   "&#92;&#48;33[30m"      &#47;* Black *&#47;<br />
#define RED     "&#92;&#48;33[31m"      &#47;* Red *&#47;<br />
#define GREEN   "&#92;&#48;33[32m"      &#47;* Green *&#47;</p>
<p>void doesAlphabetizeWork(char** unsortedWords,<br />
	                 char** alphabetizedWords,<br />
	                         int howManyWords);<br />
int main() {<br />
	char      *unsortedWords[5] = {"Bryaxis",<br />
									"Batman",<br />
									 "Sadie",<br />
									  "Milo",<br />
									   "Lou"};<br />
	char  *alphabetizedWords[5] = {"Batman",<br />
	              				  "Bryaxis",<br />
	              				      "Lou",<br />
	              				     "Milo",<br />
	              				    "Sadie"};</p>
<p>	doesAlphabetizeWork(unsortedWords,alphabetizedWords, 5);</p>
<p>	return 0;<br />
}</p>
<p>void doesAlphabetizeWork(char** unsortedWords,<br />
	                 char** alphabetizedWords,<br />
	                         int howManyWords) {<br />
	int i;</p>
<p>	int  metaTest[howManyWords];<br />
	int  realTest[howManyWords];<br />
	for (i=0; i < howManyWords; i++){<br />
		metaTest[i] = (!strcmp(unsortedWords[i], unsortedWords[i]));<br />
		realTest[i] = (!strcmp(unsortedWords[i],alphabetizedWords[i]));<br />
	}<br />
&#47;&#47;	printf("MetaTest:\n");<br />
&#47;&#47;	for (i=0; i < howManyWords; i++){<br />
&#47;&#47;		printf(GREEN);<br />
&#47;&#47;		printf("Success! unsortedWords[%d] '%s'",i, unsortedWords[i]);<br />
&#47;&#47;		printf("matches");<br />
&#47;&#47;		printf("unsortedWords[%d] '%s'.\n", i,  unsortedWords[i]);<br />
&#47;&#47;		printf(RESET);<br />
&#47;&#47;	}<br />
&#47;&#47;	printf("RealTest:\n");<br />
	for (i=0; i < howManyWords; i++){</p>
<p>		if (realTest[i]) {<br />
			printf(GREEN);<br />
			printf("Success! unsortedWords[%d] '%s'",i, unsortedWords[i]);<br />
			printf("matches");<br />
			printf("alphabetizedWords[%d] '%s'.\n", i,  unsortedWords[i]);<br />
			printf(RESET);</p>
<p>		}<br />
		else {<br />
			printf(RED);<br />
			printf("Failure! unsortedWords[%d] '%s'",i, unsortedWords[i]);<br />
			printf("doesn't match");<br />
			printf("alphabetizedWords[%d] '%s'.\n", i,  alphabetizedWords[i]);<br />
			printf(RESET);<br />
		}<br />
	}<br />
}<br />
[&#47;code]</p>
<p>Now when we compile and run this code we should see (with colors of course)<br />
[code]<br />
Failure! unsortedWords[0] 'Bryaxis'doesn't matchalphabetizedWords[0] 'Batman'.<br />
Failure! unsortedWords[1] 'Batman'doesn't matchalphabetizedWords[1] 'Bryaxis'.<br />
Failure! unsortedWords[2] 'Sadie'doesn't matchalphabetizedWords[2] 'Lou'.<br />
Success! unsortedWords[3] 'Milo'matchesalphabetizedWords[3] 'Milo'.<br />
Failure! unsortedWords[4] 'Lou'doesn't matchalphabetizedWords[4] 'Sadie'.<br />
[&#47;code]</p>
<p>In Part 2 we'll explore a number of possible sorting algorithms and start to implement our alphabetize algorithm, and finally get our test to pass. </p>
