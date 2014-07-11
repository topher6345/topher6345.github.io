---
layout: post
status: publish
published: true
title: Implementing quicksort in C using TDD Part 2
author:
  display_name: Topher
  login: admin
  email: csaunders@berklee.net
  url: http://www.tophersaunders.com
author_login: admin
author_email: csaunders@berklee.net
author_url: http://www.tophersaunders.com
excerpt: "<a href=\"sort-strings-alphabetically-in-c-part-1\">Part 1<&#47;a>\r\n\r\n<a
  href=\"https:&#47;&#47;github.com&#47;topher6345&#47;sort-strings-alphabetically-in-c\">On
  GitHub<&#47;a>\r\n\r\n<a href=\"https:&#47;&#47;github.com&#47;topher6345&#47;sort-strings-alphabetically-in-c&#47;archive&#47;master.zip\">Download
  example files<&#47;a>\r\n\r\nIn the previous article, we established our goal of
  implementing a word sorting algorithm by writing a test.\r\n\r\nThis test fails,
  because we have not actually alphabetized our words. But the red and green test
  results give us a reward mechanism that lets us measure our success.\r\n\r\nA string
  in C is an array of characters. These characters have integer values which, fortunately
  for this task, can be sorted using number sorting algorithms. \r\n\r\nMy favorite
  is quicksort. You can watch a very clear explanation of this algorithm on one of
  my favorite Youtube channels - Computerphile. \r\n\r\n"
wordpress_id: 1590
wordpress_url: http://www.tophersaunders.com/wp/?p=1590
date: '2013-11-24 15:24:00 -0800'
date_gmt: '2013-11-24 20:24:00 -0800'
categories:
- Code
tags: []
---
<p><a href="sort-strings-alphabetically-in-c-part-1">Part 1<&#47;a></p>
<p><a href="https:&#47;&#47;github.com&#47;topher6345&#47;sort-strings-alphabetically-in-c">On GitHub<&#47;a></p>
<p><a href="https:&#47;&#47;github.com&#47;topher6345&#47;sort-strings-alphabetically-in-c&#47;archive&#47;master.zip">Download example files<&#47;a></p>
<p>In the previous article, we established our goal of implementing a word sorting algorithm by writing a test.</p>
<p>This test fails, because we have not actually alphabetized our words. But the red and green test results give us a reward mechanism that lets us measure our success.</p>
<p>A string in C is an array of characters. These characters have integer values which, fortunately for this task, can be sorted using number sorting algorithms. </p>
<p>My favorite is quicksort. You can watch a very clear explanation of this algorithm on one of my favorite Youtube channels - Computerphile. </p>
<p><a id="more"></a><a id="more-1590"></a></p>
<p><a href="http:&#47;&#47;www.youtube.com&#47;watch?v=XE4VP_8Y0BU" target="_blank">Quick Sort - Computerphile<&#47;a></p>
<p>The C header <em>stdlib.h<&#47;em> includes the function qsort(), which we could apply to this situation, but all the implementation details of the function are hidden. I'm gonna wait until the end to show you how to use it.</p>
<p>We will implement quick sort first, then apply it to our array of strings from Part 1. </p>
<p>[code language="c" collapse="true"]<br />
#include <stdio.h><br />
#define RESET   "&#92;&#48;33[0m"<br />
#define BLACK   "&#92;&#48;33[30m"      &#47;* Black *&#47;<br />
#define RED     "&#92;&#48;33[31m"      &#47;* Red *&#47;<br />
#define GREEN   "&#92;&#48;33[32m"      &#47;* Green *&#47;</p>
<p>void quickSort( int[], int, int);<br />
int partition( int[], int, int);</p>
<p>int main()<br />
{<br />
	int unsorted[] = { 7, 12, 1, -2, 0, 15, 4, 11, 9};<br />
  int sorted[] = {-2, 0, 1, 4, 7, 9, 11, 12, 15};</p>
<p>	int i;</p>
<p>	quickSort( unsorted, 0, 8);</p>
<p>  &#47;&#47; TEST<br />
  for(i = 0; i < 9; ++i){<br />
    if (unsorted[i] != sorted[i]){<br />
      printf(RED);<br />
      printf("\nSort failed - unsorted[%d] %d", i, unsorted[i]);<br />
      printf("is not equal to sorted[%d] %d",i, sorted[i]);<br />
      printf(RESET);<br />
      return 1;<br />
    }<br />
  }<br />
  printf(GREEN);<br />
  printf("\nTest Passed! Quicksort Works.\n\n");<br />
  printf(RESET);<br />
  return 0;<br />
}</p>
<p>void quickSort( int unsorted[], int l, int r)<br />
{<br />
   int pivot;</p>
<p>   if( l < r )<br />
   {<br />
   	&#47;&#47; divide and conquer<br />
       pivot = partition( unsorted, l, r);<br />
       quickSort( unsorted, l, pivot-1);<br />
       quickSort( unsorted, pivot+1, r);<br />
   }</p>
<p>}</p>
<p>int partition( int currentPartition[], int firstPosition, int lastPosition) {<br />
   int pivot, i, j, tmp;</p>
<p>   &#47;&#47;set pivot to be the first element in the partition<br />
   pivot = currentPartition[firstPosition];</p>
<p>   i = firstPosition; </p>
<p>   &#47;&#47; set j to be one beyond the last poisition<br />
   j = lastPosition+1;</p>
<p>   while( 1)<br />
   {<br />
    &#47;&#47; increment i as long as<br />
    &#47;&#47; 1. currentPartition[i] is less than or equal to the pivot<br />
    &#47;&#47; 2. i is at the last position<br />
   	do ++i; while( currentPartition[i] <= pivot &amp;&amp; i <= lastPosition );</p>
<p>    &#47;&#47; decrement j as long as<br />
    &#47;&#47; currentPartition[j] is greater than the pivot<br />
    do --j; while( currentPartition[j] > pivot );</p>
<p>   	if( i >= j ) break;</p>
<p>    &#47;&#47; swap currentPartition[i] and currentPartition[j]<br />
   	tmp = currentPartition[i];<br />
    currentPartition[i] = currentPartition[j];<br />
    currentPartition[j] = tmp;<br />
   }</p>
<p>   &#47;&#47; swap currentPartition[l] and currentPartition[j]<br />
   tmp = currentPartition[firstPosition];<br />
   currentPartition[firstPosition] = currentPartition[j];<br />
   currentPartition[j] = tmp;</p>
<p>   &#47;&#47; return new pivot<br />
   return j;<br />
}</p>
<p>[&#47;code]</p>
<p>If you compile and run this code you should see </p>
<p>[code]</p>
<p>Test Passed! Quicksort Works.</p>
<p>[&#47;code]</p>
<p>Lets start to pick apart this code. </p>
<p>In our main() function we first declare two arrays of integers.</p>
<p>[code language="c"]<br />
int unsorted[] = { 7, 12, 1, -2, 0, 15, 4, 11, 9};<br />
int sorted[] = {-2, 0, 1, 4, 7, 9, 11, 12, 15};<br />
[&#47;code]</p>
<p>Below it, we call our quickSort() function to sort the arrays. With 3 arguments -<br />
1. the array of integers to be sorted<br />
2. A lower bound for the array (0 in this case)<br />
3. The number of elements in the array (8).<br />
[code language="c"]<br />
quickSort( unsorted, 0, 8);<br />
[&#47;code]</p>
<p>Below this in main, I've written a test to see if my hand sorted array <em>sorted<&#47;em> matches the output of quicksort.</p>
<p>[code language="c"]<br />
  &#47;&#47; TEST<br />
  for(i = 0; i < 9; ++i){<br />
    if (unsorted[i] != sorted[i]){<br />
      printf(RED);<br />
      printf("\nSort failed - unsorted[%d] %d", i, unsorted[i]);<br />
      printf("is not equal to sorted[%d] %d",i, sorted[i]);<br />
      printf(RESET);<br />
      return 1;<br />
    }<br />
  }<br />
  printf(GREEN);<br />
  printf("\nTest Passed! Quicksort Works.\n\n");<br />
  printf(RESET);<br />
  return 0;<br />
[&#47;code]</p>
<p>Our second function in this example is quickSort()<br />
[code language="c"]<br />
void quickSort( int unsorted[], int l, int r)<br />
{<br />
   int pivot;</p>
<p>   if( l < r )<br />
   {<br />
   	&#47;&#47; divide and conquer<br />
       pivot = partition( unsorted, l, r);<br />
       quickSort( unsorted, l, pivot-1);<br />
       quickSort( unsorted, pivot+1, r);<br />
   }</p>
<p>}<br />
[&#47;code]</p>
<p>Once again, we see the three arguments declared. </p>
<p>We also declare an int, a variable we call pivot, this variable is an index that will split the list into two sub-lists, an upper list with indexes above the pivot and a lower list with indexes below the pivot.</p>
<p>Searching the list of elements and selecting a pivot is its own algorithm. We've abstracted it into a function called partition() that returns an index. I'll finish discussing the quickiSort() function and then move on to explaining the partition() function</p>
<p>Once the list is split, quickSort() is called on the upper list and the lower lists.</p>
<p>[code language="c"]<br />
       quickSort( unsorted, l, pivot-1);<br />
       quickSort( unsorted, pivot+1, r);<br />
[&#47;code]</p>
<p>Since the algorithm is the same for the sublists as it is for the whole list, its a perfect opportunity to use recursion. The function calls itself.</p>
<p>Lets move on to the function partition();</p>
<p>[code language="c"]<br />
int partition( int currentPartition[], int firstPosition, int lastPosition) {<br />
   int pivot, i, j, tmp;</p>
<p>   &#47;&#47; set pivot to be the first element in the partition<br />
   pivot = currentPartition[firstPosition];</p>
<p>   i = firstPosition; </p>
<p>   &#47;&#47; set j to be one beyond the last position<br />
   j = lastPosition+1;</p>
<p>   while( 1)<br />
   {<br />
    &#47;&#47; increment i as long as<br />
    &#47;&#47; 1. currentPartition[i] is less than or equal to the pivot<br />
    &#47;&#47; 2. i is at the last position<br />
   	do ++i; while( currentPartition[i] <= pivot &amp;&amp; i <= lastPosition );</p>
<p>    &#47;&#47; decrement j as long as<br />
    &#47;&#47; currentPartition[j] is greater than the pivot<br />
    do --j; while( currentPartition[j] > pivot );</p>
<p>   	if( i >= j ) break;</p>
<p>    &#47;&#47; swap currentPartition[i] and currentPartition[j]<br />
    tmp = currentPartition[i];<br />
    currentPartition[i] = currentPartition[j];<br />
    currentPartition[j] = tmp;<br />
   }</p>
<p>   &#47;&#47; swap currentPartition[l] and currentPartition[j]<br />
   tmp = currentPartition[firstPosition];<br />
   currentPartition[firstPosition] = currentPartition[j];<br />
   currentPartition[j] = tmp;</p>
<p>   &#47;&#47; return new pivot<br />
   return j;<br />
}<br />
[&#47;code]</p>
<p>I've done my best to comment and self-document this as clearly as possible.</p>
<p>This function of course returns an index, but partition() also has the other job of swapping elements which ultimatley modifies the order of our unsorted[] array of ints. This swapping function is the key to this algorithm. </p>
<p>A number of other implementations of quick sort move the elements into another memory location, but for our purposes we will swap them in place. This has to do with being efficient with memory and not allocating more than you need. </p>
<p>[code language="c"]<br />
    &#47;&#47; swap currentPartition[i] and currentPartition[j]<br />
    tmp = currentPartition[i];<br />
    currentPartition[i] = currentPartition[j];<br />
    currentPartition[j] = tmp;<br />
   }</p>
<p>   &#47;&#47; swap currentPartition[l] and currentPartition[j]<br />
   tmp = currentPartition[firstPosition];<br />
   currentPartition[firstPosition] = currentPartition[j];<br />
   currentPartition[j] = tmp;<br />
[&#47;code]</p>
<p>This is the clearest and most basic example of Quick Sort'ing integers I could muster. We'll modify this code to sort characters and finally strings in the next examples.</p>
<p>Our next example sorts characters in a similar way </p>
<p>[code language="c" collapse="true"]<br />
#include <stdio.h><br />
#define RESET   "&#92;&#48;33[0m"<br />
#define BLACK   "&#92;&#48;33[30m"      &#47;* Black *&#47;<br />
#define RED     "&#92;&#48;33[31m"      &#47;* Red *&#47;<br />
#define GREEN   "&#92;&#48;33[32m"      &#47;* Green *&#47;</p>
<p>void quickSort( char[], int, int);<br />
int partition( char[], int, int);</p>
<p>int main()<br />
{<br />
	char unsorted[] = { 'g', 'l', 'b', 'c', 'a', 'm', 'e', 'k', 'i'};<br />
  char sorted[] = { 'a', 'b','c', 'e', 'g', 'i', 'k', 'l', 'm'};</p>
<p>	int i;</p>
<p>	quickSort( unsorted, 0, 8);</p>
<p>  &#47;&#47; TEST<br />
  for(i = 0; i < 9; ++i){<br />
    if (unsorted[i] != sorted[i]){<br />
      printf(RED);<br />
      printf("\nSort failed - unsorted[%d] %c ", i, unsorted[i]);<br />
      printf("is not equal to sorted[%d] %c ",i, sorted[i]);<br />
      printf(RESET);<br />
      return 1;<br />
    }<br />
  }<br />
  printf(GREEN);<br />
  printf("\nTest Passed! Quicksort Works.\n\n");<br />
  printf(RESET);<br />
  return 0;<br />
}</p>
<p>void quickSort( char unsorted[], int l, int r)<br />
{<br />
   int pivot;</p>
<p>   if( l < r )<br />
   {<br />
   	&#47;&#47; divide and conquer<br />
       pivot = partition( unsorted, l, r);<br />
       quickSort( unsorted, l, pivot-1);<br />
       quickSort( unsorted, pivot+1, r);<br />
   }</p>
<p>}</p>
<p>int partition( char currentPartition[], int firstPosition, int lastPosition) {<br />
   int  i, j;<br />
   char pivotElement, tmp;</p>
<p>   &#47;&#47;set pivot to be the first element in the partition<br />
   pivotElement = currentPartition[firstPosition];</p>
<p>   i = firstPosition; </p>
<p>   &#47;&#47; set j to be one beyond the last position<br />
   j = lastPosition+1;</p>
<p>   while( 1)<br />
   {<br />
    &#47;&#47; increment i as long as<br />
    &#47;&#47; 1. currentPartition[i] is less than or equal to the pivotElement<br />
    &#47;&#47; 2. i is at the last position<br />
   	do ++i; while( currentPartition[i] <= pivotElement &amp;&amp; i <= lastPosition );</p>
<p>    &#47;&#47; decrement j as long as<br />
    &#47;&#47; currentPartition[j] is greater than the pivot<br />
    do --j; while( currentPartition[j] > pivotElement );</p>
<p>   	if( i >= j ) break;</p>
<p>    &#47;&#47; swap currentPartition[i] and currentPartition[j]<br />
   	tmp = currentPartition[i];<br />
    currentPartition[i] = currentPartition[j];<br />
    currentPartition[j] = tmp;<br />
   }</p>
<p>   &#47;&#47; swap currentPartition[l] and currentPartition[j]<br />
   tmp = currentPartition[firstPosition];<br />
   currentPartition[firstPosition] = currentPartition[j];<br />
   currentPartition[j] = tmp;</p>
<p>   &#47;&#47; return new pivot<br />
   return j;<br />
}<br />
[&#47;code]</p>
<p>If you compile and run this code you should see the same output as before.</p>
<p>[code]<br />
#include <stdio.h><br />
#define RESET   "&#92;&#48;33[0m"<br />
#define BLACK   "&#92;&#48;33[30m"      &#47;* Black *&#47;<br />
#define RED     "&#92;&#48;33[31m"      &#47;* Red *&#47;<br />
#define GREEN   "&#92;&#48;33[32m"      &#47;* Green *&#47;</p>
<p>void quickSort( char[], int, int);<br />
int partition( char[], int, int);</p>
<p>int main()<br />
{<br />
	char unsorted[] = { 'g', 'l', 'b', 'c', 'a', 'm', 'e', 'k', 'i'};<br />
  char sorted[] = { 'a', 'b','c', 'e', 'g', 'i', 'k', 'l', 'm'};</p>
<p>	int i;</p>
<p>	quickSort( unsorted, 0, 8);</p>
<p>  &#47;&#47; TEST<br />
  for(i = 0; i < 9; ++i){<br />
    if (unsorted[i] != sorted[i]){<br />
      printf(RED);<br />
      printf("\nSort failed - unsorted[%d] %c ", i, unsorted[i]);<br />
      printf("is not equal to sorted[%d] %c ",i, sorted[i]);<br />
      printf(RESET);<br />
      return 1;<br />
    }<br />
  }<br />
  printf(GREEN);<br />
  printf("\nTest Passed! Quicksort Works.\n\n");<br />
  printf(RESET);<br />
  return 0;<br />
}</p>
<p>void quickSort( char unsorted[], int l, int r)<br />
{<br />
   int pivot;</p>
<p>   if( l < r )<br />
   {<br />
   	&#47;&#47; divide and conquer<br />
       pivot = partition( unsorted, l, r);<br />
       quickSort( unsorted, l, pivot-1);<br />
       quickSort( unsorted, pivot+1, r);<br />
   }</p>
<p>}</p>
<p>int partition( char currentPartition[], int firstPosition, int lastPosition) {<br />
   int  i, j;<br />
   char pivotElement, tmp;</p>
<p>   &#47;&#47;set pivot to be the first element in the partition<br />
   pivotElement = currentPartition[firstPosition];</p>
<p>   i = firstPosition; </p>
<p>   &#47;&#47; set j to be one beyond the last position<br />
   j = lastPosition+1;</p>
<p>   while( 1)<br />
   {<br />
    &#47;&#47; increment i as long as<br />
    &#47;&#47; 1. currentPartition[i] is less than or equal to the pivotElement<br />
    &#47;&#47; 2. i is at the last position<br />
   	do ++i; while( currentPartition[i] <= pivotElement &amp;&amp; i <= lastPosition );</p>
<p>    &#47;&#47; decrement j as long as<br />
    &#47;&#47; currentPartition[j] is greater than the pivot<br />
    do --j; while( currentPartition[j] > pivotElement );</p>
<p>   	if( i >= j ) break;</p>
<p>    &#47;&#47; swap currentPartition[i] and currentPartition[j]<br />
   	tmp = currentPartition[i];<br />
    currentPartition[i] = currentPartition[j];<br />
    currentPartition[j] = tmp;<br />
   }</p>
<p>   &#47;&#47; swap currentPartition[l] and currentPartition[j]<br />
   tmp = currentPartition[firstPosition];<br />
   currentPartition[firstPosition] = currentPartition[j];<br />
   currentPartition[j] = tmp;</p>
<p>   &#47;&#47; return new pivot<br />
   return j;<br />
}<br />
[&#47;code]</p>
<p>All I've really done here is refactored the previous integer Quick Sort example. I was able to do this with confidence because of the test I wrote. When I messed up the functionality the test failed, and when I safely refactored the test continued to pass. </p>
<p>Lets check out what is different about this example.</p>
<p>Our function declarations are different, now partition() and quickSort() take char arrays as the first argument<br />
[code language="c"]<br />
void quickSort( char[], int, int);<br />
int partition( char[], int, int);<br />
[&#47;code]</p>
<p>Also remembering to make this change in the function definitions.<br />
[code language="c" highlight="1"]<br />
void quickSort( char unsorted[], int l, int r)<br />
{<br />
   int pivot;</p>
<p>   if( l < r )<br />
   {<br />
   	&#47;&#47; divide and conquer<br />
       pivot = partition( unsorted, l, r);<br />
       quickSort( unsorted, l, pivot-1);<br />
       quickSort( unsorted, pivot+1, r);<br />
   }</p>
<p>}<br />
[&#47;code]</p>
<p>Because now we are reordering and swapping chars, the corresponding variables used to swap these elements of the list have to declared as chars.<br />
[code language="c" highlight="1,3"]<br />
int partition( char currentPartition[], int firstPosition, int lastPosition) {<br />
   int  i, j;<br />
   char pivotElement, tmp;</p>
<p>   &#47;&#47;set pivot to be the first element in the partition<br />
   pivotElement = currentPartition[firstPosition];</p>
<p>   i = firstPosition; </p>
<p>   &#47;&#47; set j to be one beyond the last position<br />
   j = lastPosition+1;</p>
<p>   while( 1)<br />
   {<br />
    &#47;&#47; increment i as long as<br />
    &#47;&#47; 1. currentPartition[i] is less than or equal to the pivotElement<br />
    &#47;&#47; 2. i is at the last position<br />
   	do ++i; while( currentPartition[i] <= pivotElement &amp;&amp; i <= lastPosition );</p>
<p>    &#47;&#47; decrement j as long as<br />
    &#47;&#47; currentPartition[j] is greater than the pivot<br />
    do --j; while( currentPartition[j] > pivotElement );</p>
<p>   	if( i >= j ) break;</p>
<p>    &#47;&#47; swap currentPartition[i] and currentPartition[j]<br />
   	tmp = currentPartition[i];<br />
    currentPartition[i] = currentPartition[j];<br />
    currentPartition[j] = tmp;<br />
   }</p>
<p>   &#47;&#47; swap currentPartition[l] and currentPartition[j]<br />
   tmp = currentPartition[firstPosition];<br />
   currentPartition[firstPosition] = currentPartition[j];<br />
   currentPartition[j] = tmp;</p>
<p>   &#47;&#47; return new pivot<br />
   return j;<br />
}<br />
[&#47;code]</p>
<p>And of course, now our arrays to be sorted are fully of chars not ints.<br />
[code language="c"]<br />
char unsorted[] = { 'g', 'l', 'b', 'c', 'a', 'm', 'e', 'k', 'i'};<br />
char sorted[] = { 'a', 'b','c', 'e', 'g', 'i', 'k', 'l', 'm'};<br />
[&#47;code]</p>
<p>Since we now have some working code that alphabetizes chars, we can apply that to our strings, which are arrays of chars, by sorting by the first element of the array. </p>
<p>(For brevities sake I've defined the test function in a different file and included it on the highlighted line below. </p>
<p>[code language="c" collapse="true"]<br />
#include <stdio.h><br />
#include <string.h><br />
#include <stdlib.h><br />
#include "doesAlphabetizeWork.c"</p>
<p>void quickSort( char**, int, int);<br />
int partition( char**, int, int);<br />
void doesAlphabetizeWork(char** unsortedWords,<br />
                     char** alphabetizedWords,<br />
                             int howManyWords);</p>
<p>int main()<br />
{<br />
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
<p>	int i;</p>
<p>	quickSort( unsortedWords, 0, 5);</p>
<p>    doesAlphabetizeWork(unsortedWords,alphabetizedWords, 5);</p>
<p>}</p>
<p>void quickSort( char **unsorted, int l, int r)<br />
{<br />
   int pivot;</p>
<p>   if( l < r )<br />
   {<br />
   	&#47;&#47; divide and conquer<br />
       pivot = partition( unsorted, l, r);<br />
       quickSort( unsorted, l, pivot-1);<br />
       quickSort( unsorted, pivot+1, r);<br />
   }</p>
<p>}</p>
<p>int partition( char** currentPartition, int firstPosition, int lastPosition) {<br />
   int  i, j;<br />
   char* pivotElement;<br />
   char* tmp;</p>
<p>   &#47;&#47;set pivot to be the first element in the partition<br />
   pivotElement = currentPartition[firstPosition];</p>
<p>   i = firstPosition; </p>
<p>   &#47;&#47; set j to be one beyond the last position<br />
   j = lastPosition+1;</p>
<p>   while( 1)<br />
   {<br />
    &#47;&#47; increment i as long as<br />
    &#47;&#47; 1. currentPartition[i] is less than or equal to the pivotElement<br />
    &#47;&#47; 2. i is at the last position<br />
   	do ++i; while(currentPartition[i][0] <= pivotElement[0] &amp;&amp; i <= lastPosition );</p>
<p>    &#47;&#47; decrement j as long as<br />
    &#47;&#47; currentPartition[j] is greater than the pivot<br />
    do --j; while( currentPartition[j][0] > pivotElement[0] );</p>
<p>   	if( i >= j ) break;</p>
<p>    &#47;&#47; swap currentPartition[i] and currentPartition[j]<br />
   	tmp = currentPartition[i];<br />
    currentPartition[i] = currentPartition[j];<br />
    currentPartition[j] = tmp;<br />
   }</p>
<p>   &#47;&#47; swap currentPartition[l] and currentPartition[j]<br />
   tmp = currentPartition[firstPosition];<br />
   currentPartition[firstPosition] = currentPartition[j];<br />
   currentPartition[j] = tmp;</p>
<p>   &#47;&#47; return new pivot<br />
   return j;<br />
}<br />
[&#47;code]</p>
<p>If you compile and run this code you should see this<br />
[code]<br />
Failure! unsortedWords[0] '����'doesn't matchalphabetizedWords[0] 'Batman'.<br />
Failure! unsortedWords[1] 'Batman'doesn't matchalphabetizedWords[1] 'Bryaxis'.<br />
Failure! unsortedWords[2] 'Bryaxis'doesn't matchalphabetizedWords[2] 'Lou'.<br />
Failure! unsortedWords[3] 'Lou'doesn't matchalphabetizedWords[3] 'Milo'.<br />
Failure! unsortedWords[4] 'Milo'doesn't matchalphabetizedWords[4] 'Sadie'.<br />
[&#47;code]</p>
<p>Don't worry, code that passes our test is given below!<br />
Our code fails because there is some problems with the implementation of our algorithm. char and int types can be compared with the == operator, but we really should be using strcmp() when dealing with char arrays. </p>
<p>Also our swap function is attempting to assign a char array, and we should really be using strcpy() for that.</p>
<p>Finally our working code, that passes the test we wrote in Part 1 </p>
<p>[code language="c" collapse="true"]<br />
#include <stdio.h><br />
#include <string.h><br />
#include "doesAlphabetizeWork.c"<br />
void quickSortMain(char unsortedWords[][10], int count);<br />
void quickSort(char unsortedWords[][10], int left, int right);<br />
void doesAlphabetizeWork(char unsortedWords[][10],<br />
                     char alphabetizedWords[][10],<br />
                             int howManyWords);<br />
int main(void)<br />
{<br />
  int i;<br />
  char unsortedWords[][10] = {"Bryaxis",<br />
                               "Batman",<br />
                                "Sadie",<br />
                                 "Milo",<br />
                                  "Lou"};<br />
  char alphabetizedWords[][10] = {"Batman",<br />
                                 "Bryaxis",<br />
                                     "Lou",<br />
                                    "Milo",<br />
                                   "Sadie"};</p>
<p>  quickSortMain(unsortedWords, 5);</p>
<p>  doesAlphabetizeWork(unsortedWords,alphabetizedWords, 5);</p>
<p>  return 0;<br />
}</p>
<p>void quickSortMain(char items[][10], int count)<br />
{<br />
  quickSort(items, 0, count-1);<br />
}</p>
<p>void quickSort(char items[][10], int left, int right)<br />
{<br />
  int i, j;<br />
  char *x;<br />
  char temp[10];</p>
<p>  i = left;<br />
  j = right;<br />
  x = items[(left+right)&#47;2];</p>
<p>  do {<br />
    while((strcmp(items[i],x) < 0) &amp;&amp; (i < right)) {<br />
       i++;<br />
    }<br />
    while((strcmp(items[j],x) > 0) &amp;&amp; (j > left)) {<br />
        j--;<br />
    }<br />
    if(i <= j) {<br />
      strcpy(temp, items[i]);<br />
      strcpy(items[i], items[j]);<br />
      strcpy(items[j], temp);<br />
      i++;<br />
      j--;<br />
   }<br />
  } while(i <= j);</p>
<p>  if(left < j) {<br />
     quickSort(items, left, j);<br />
  }<br />
  if(i < right) {<br />
     quickSort(items, i, right);<br />
  }<br />
}<br />
[&#47;code]</p>
<p>if you compile and run this code you should see </p>
<p>[code]<br />
Success! unsortedWords[0] 'Batman'matchesalphabetizedWords[0] 'Batman'.<br />
Success! unsortedWords[1] 'Bryaxis'matchesalphabetizedWords[1] 'Bryaxis'.<br />
Success! unsortedWords[2] 'Lou'matchesalphabetizedWords[2] 'Lou'.<br />
Success! unsortedWords[3] 'Milo'matchesalphabetizedWords[3] 'Milo'.<br />
Success! unsortedWords[4] 'Sadie'matchesalphabetizedWords[4] 'Sadie'.<br />
[&#47;code]</p>
<p>Like I mentioned earlier, c has its own implementation of the quicksort algorithm defined in stdlib.h.</p>
<p>Its called qsort(). And it defines a subroutine for the algorithms we just wrote out by hand. </p>
<p>[code collapse="true" language="c"]<br />
#include <stdio.h><br />
#include <stdlib.h><br />
#include <string.h><br />
#include "doesAlphabetizeWork.c"</p>
<p>int cstring_cmp(const void *a, const void *b)<br />
{<br />
    const char **ia = (const char **)a;<br />
    const char **ib = (const char **)b;<br />
    return strcmp(*ia, *ib);</p>
<p>} </p>
<p>int main()<br />
{<br />
    char *unsortedWords[] = {"Bryaxis",<br />
                              "Batman",<br />
                               "Sadie",<br />
                                "Milo",<br />
                                "Lou"};<br />
    char *alphabetizedWords[] = {"Batman",<br />
                                "Bryaxis",<br />
                                    "Lou",<br />
                                   "Milo",<br />
                                 "Sadie"};</p>
<p>    size_t strings_len = sizeof(unsortedWords) &#47; sizeof(char *);</p>
<p>    qsort(unsortedWords,<br />
            strings_len,<br />
         sizeof(char *),<br />
           cstring_cmp);</p>
<p>    doesAlphabetizeWork(unsortedWords,alphabetizedWords, strings_len);</p>
<p>}<br />
[&#47;code]</p>
<p>Once again, we've defined our test function in a separate file. If you compile this code and run it you should see:</p>
<p>[code]<br />
Success! unsortedWords[0] 'Batman'matchesalphabetizedWords[0] 'Batman'.<br />
Success! unsortedWords[1] 'Bryaxis'matchesalphabetizedWords[1] 'Bryaxis'.<br />
Success! unsortedWords[2] 'Lou'matchesalphabetizedWords[2] 'Lou'.<br />
Success! unsortedWords[3] 'Milo'matchesalphabetizedWords[3] 'Milo'.<br />
Success! unsortedWords[4] 'Sadie'matchesalphabetizedWords[4] 'Sadie'.<br />
[&#47;code]</p>
<p>Lets discuss the qsort() function. </p>
<p>C library function definition:<br />
[code language="c"]<br />
void qsort(void *base, size_t nitems, size_t size, int (*compar)(const void *, const void*))<br />
[&#47;code]</p>
<p>Our usage in main.c<br />
[code language="c"]<br />
qsort(unsortedWords,<br />
        strings_len,<br />
     sizeof(char *),<br />
       cstring_cmp);<br />
[&#47;code]</p>
<p>qsort() takes 4 arguments<br />
1. an collection to be sorted in terms of a pointer to an array.<br />
2. an integer of how many elements are in the collection<br />
3. the size of the individual elements in the collection to be sorted.<br />
4. a comparison function that returns an int.</p>
<p>Argument # 4 takes a pointer to a function, a callback routine. Typical in C, callback functions are executed by their parent functions. In other words, qsort() will decide when its necessary to utilize the callback function you give it. </p>
<p>Heres our callback function cstring_cmp():</p>
<p>[code language="c"]<br />
int cstring_cmp(const void *a, const void *b)<br />
{<br />
    const char **ia = (const char **)a;<br />
    const char **ib = (const char **)b;<br />
    return strcmp(*ia, *ib);</p>
<p>}<br />
[&#47;code]</p>
<p>The reason qsort() needs this callback function is pertinent to our usage of it. qsort() can sort integers, chars, strings, or any C data structure, this callback function specifies how elements are compared. Comparing ints in C is different from comparing strings, this callback function must implement a comparison that is useful to the collection you are trying to sort. In our case, this callback function compares strings, and returns an int back to qsort() to let qsort() know wether to swap the two elements. </p>
<hr>
<p>Hopefully these articles will be a good reference on sorting algorithms and test-driven development. </p>
<p>In closing, I'd like to point out that TDD was essential to implementing this.<br />
1. I google searched "sort c strings alphabetically", found some code.<br />
2. wrote some test to prove that it worked (often it didn't)<br />
3. Refactored and commented it until it was clear, readable and understandable.</p>
