---
layout: post
status: publish
published: true
title: Implementing quicksort Part 1
author:
  display_name: Topher
  login: admin
  email: csaunders@berklee.net
  url: http://www.tophersaunders.com
author_login: admin
author_email: csaunders@berklee.net
author_url: http://www.tophersaunders.com
excerpt: "Let's examine a classic computer science question - 
how to alphabetically
  sort words.\r\n\r\nIn the first part, we'll examine the problem and set
  up a test-driven-development template. \r\n\r\nIn part 2 we'll examine the quicksort
  algorithm, and implement it to get our test to pass. \r\n\r\nHeres our list of words
  (or 'strings' in C speak). They're the names of some of my friend's cats. \r\n\r\nWe'll
  be using this list throughout the tutorial.\r\n
\r\n  
*Bryaxis\r\n
  \
*Batman\r\n
*Sadie\r\n
*Milo\r\n
*Lou\r\n\r\n\r\n"
wordpress_id: 1587
wordpress_url: http://www.tophersaunders.com/wp/?p=1587
date: '2013-11-24 15:23:10 -0800'
date_gmt: '2013-11-24 20:23:10 -0800'
categories:
- Code
tags: []
---

Let's examine a classic computer science question - 
how to alphabetically sort words.

In the first part, we'll examine the problem and set up a test-driven-development template.

In part 2 we'll examine the quicksort algorithm, and implement it to get our test to pass.

Heres our list of words (or 'strings' in C speak). They're the names of some of my friend's cats.

We'll be using this list throughout the tutorial.

*Bryaxis
*Batman
*Sadie
*Milo
*Lou

[]()[]()

[On github](https://github.com/topher6345/sort-strings-alphabetically-in-c)

[Download example files


In Ruby, my weapon of choice for dealing with strings, it goes like this.](https://github.com/topher6345/sort-strings-alphabetically-in-c/archive/master.zip)

fire up irb in your terminal window and type


[code lang="ruby"]


@names = ['Bryaxis', 'Batman', 'Sadie', 'Milo', 'Lou']


@names.sort


[/code]

Python is also good with strings

Open the python interpreter and type


[code lang="python"]


names = ['Bryaxis', 'Batman', 'Sadie', 'Milo', 'Lou']


sorted(names)


[/code]

In these languages, string sorting has already be implemented, but we want to examine 
how an algorithm like this is structured and implemented. So let's get low-level and work it out in C.

If we're gonna reinvent the wheel, let's do it right and use 
[test driven development. A software development technique designed to reduce frustration and make software development FUN.](http://en.wikipedia.org/wiki/Test-driven_development)

The idea is simple, you write a 
failing test and then you write the code required to pass it. Its a built in reward system. Instead of wondering "did my program do what I wanted it to do?" you can have the software 
tell you it works.

We'll start with a simple C file

[code lang="c"]


#include 
#include

int main() {


    assert(0);


    return 0;


}


[/code]

Compile and run this and you should see


[code gutter="false"]


Assertion failed: (0), function main, file main.c, line 5.


Abort trap


[/code]

If you are unfamiliar with TDD, you might be wondering what assert() is all about.

'assert()' is like a sanity test. It passes if true (the integer 1 in C) and fails if false (0). Our first bit of code here tests the test. We can make sure it passes on true by inserting a positive assert.


This way, our code compiles without errors, but stops on execution if our algorithm isn't doing what we want it to.


[code lang="c"]


#include 
#include

int main() {


    assert(1);


    assert(0);


    return 0;


}


[/code]

Compile and run this and you should see


[code gutter="false"]


Assertion failed: (0), function main, file main.c, line 6.


Abort trap


[/code]

Notice that it failed on line 6, but not on line 5. this should make you comfortable enough with the assert() function to continue on.

Since we will be dealing with words, lets add the string.h header, and some string comparison assertions to our code.

[code highlight="3,5,6,7,8" language="c"]


#include 
#include 
#include 
int main() {


	char unsortedWords[] = "false";


	char alphabetizedWords[] = "true";


	assert(!strcmp(unsortedWords,unsortedWords));


	assert(!strcmp(unsortedWords,alphabetizedWords));


	return 0;


}


[/code]

Compile and run this and you should see


[code gutter="false"]


Assertion failed: (!strcmp(unsortedWords,sortedWords)), function main, file main.c, line 8.


Abort trap


[/code]

We are using the strcmp() function to compare two strings, notice the ! before strcmp(), because strcmp() is weird and returns 0 if the strings don't match and 1 if they do. (welcome to C, where up is down and down is up, I miss ruby already)

This gets us closer to being able to test if we correctly implemented a way to alphabetize words. We're not all the way there yet, because we can only test if one word is the same as another, so lets modify our code further to make a robust failing test to see if two arrays of strings are the same.

We'll need a way to iterate through an array of strings and compare each individual string in the array.

[code highlight="5,6,7,8" language="c"]


#include 
#include 
#include 
int main() {


	char      *unsortedWords[5] = {"Bryaxis", "Batman" , "Sadie", "Milo", "Lou"  };


	char  *alphabetizedWords[5] = {"Batman" , "Bryaxis", "Lou"  , "Milo", "Sadie"};


	assert(!strcmp(unsortedWords[0],    unsortedWords[0]));


	assert(!strcmp(unsortedWords[0],alphabetizedWords[0]));


	return 0;


}


[/code]

If we run this, then we should get this message


[code]


Assertion failed: (!strcmp(unsortedWords[0],alphabetizedWords[0])), function main, file main.c, line 8.


Abort trap


[/code]

Which tells us that the first word (aka string) in the array is not the same.

So lets modify our code furthur to check every single word in the array.

[code collapse="true" language="c"]


#include 
#include 
#include 
int main() {


	char      *unsortedWords[5] = {"Bryaxis", "Batman" , "Sadie", "Milo", "Lou"  };


	char  *alphabetizedWords[5] = {"Batman" , "Bryaxis", "Lou"  , "Milo", "Sadie"};


	int  metaTest[5];


	int  realTest[5];


	int i;


	for (i=0; i 
		metaTest[i] = (!strcmp(unsortedWords[i], unsortedWords[i]));


		realTest[i] = (!strcmp(unsortedWords[i],alphabetizedWords[i]));


	}


	printf("MetaTest:\n");


	for (i=0; i 
		printf("Success! unsortedWords[%d] '%s' matches unsortedWords[%d] '%s'.\n", i, unsortedWords[i], i,  unsortedWords[i] );


	}


	printf("RealTest:\n");


	for (i=0; i 

if (realTest[i]) {


			printf("Success! unsortedWords[%d] '%s' matches unsortedWords[%d] '%s'.\n", i, unsortedWords[i], i,  unsortedWords[i] );


		}


		else {


			printf("Failure! unsortedWords[%d] '%s' doesn't match alphabetizedWords[%d] '%s'.\n", i, unsortedWords[i],i,  alphabetizedWords[i] );


		}


	}


	return 0;


}


[/code]

Compile and run this code and you should see


[code]


MetaTest:


Success! unsortedWords[0] 'Bryaxis' matches unsortedWords[0] 'Bryaxis'.


Success! unsortedWords[1] 'Batman' matches unsortedWords[1] 'Batman'.


Success! unsortedWords[2] 'Sadie' matches unsortedWords[2] 'Sadie'.


Success! unsortedWords[3] 'Milo' matches unsortedWords[3] 'Milo'.


Success! unsortedWords[4] 'Lou' matches unsortedWords[4] 'Lou'.


RealTest:


Failure! unsortedWords[0] 'Bryaxis' doesn't match alphabetizedWords[0] 'Batman'.


Failure! unsortedWords[1] 'Batman' doesn't match alphabetizedWords[1] 'Bryaxis'.


Failure! unsortedWords[2] 'Sadie' doesn't match alphabetizedWords[2] 'Lou'.


Success! unsortedWords[3] 'Milo' matches unsortedWords[3] 'Milo'.


Failure! unsortedWords[4] 'Lou' doesn't match alphabetizedWords[4] 'Sadie'.


[/code]

We have a automatic way to test if two arrays of words are the same. But its a little hard to infer that so, at the risk of going on a tangent here, I'm going to add some terminal colors to this output. Here I should mention I'm on OSX 10.6 so this color codes might not work for you. Along the way I'll enforce some better coding style-like not having lines longer than 79 columns.

[code collapse="true" language="c"]


#include 
#include 
#include 
#define RESET   "\033[0m"


#define BLACK   "\033[30m"      /* Black */


#define RED     "\033[31m"      /* Red */


#define GREEN   "\033[32m"      /* Green */


int main() {


	char      *unsortedWords[5] = {"Bryaxis",


									"Batman",


									 "Sadie",


									  "Milo",


									   "Lou"};


	char  *alphabetizedWords[5] = {"Batman",


	              				  "Bryaxis",


	              				      "Lou",


	              				     "Milo",


	              				    "Sadie"};


	int  metaTest[5];


	int  realTest[5];


	int i;


	for (i=0; i 
		metaTest[i] = (!strcmp(unsortedWords[i], unsortedWords[i]));


		realTest[i] = (!strcmp(unsortedWords[i],alphabetizedWords[i]));


	}


	printf("MetaTest:\n");


	for (i=0; i 
		printf(GREEN);


		printf("Success! unsortedWords[%d] '%s'",i, unsortedWords[i]);


		printf("matches");


		printf("unsortedWords[%d] '%s'.\n", i,  unsortedWords[i]);


		printf(RESET);


	}


	printf("RealTest:\n");


	for (i=0; i 

if (realTest[i]) {


			printf(GREEN);


			printf("Success! unsortedWords[%d] '%s'",i, unsortedWords[i]);


			printf("matches");


			printf("alphabetizedWords[%d] '%s'.\n", i,  unsortedWords[i]);


			printf(RESET);

}


		else {


			printf(RED);


			printf("Failure! unsortedWords[%d] '%s'",i, unsortedWords[i]);


			printf("doesn't match");


			printf("alphabetizedWords[%d] '%s'.\n", i,  alphabetizedWords[i]);


			printf(RESET);


		}


	}


	return 0;


}


[/code]

Our code is getting a little verbose, so we put our test into a function. And comment out our metatest

[code collapse="true" language="c"]


#include 
#include 
#include 
#define RESET   "\033[0m"


#define BLACK   "\033[30m"      /* Black */


#define RED     "\033[31m"      /* Red */


#define GREEN   "\033[32m"      /* Green */

void doesAlphabetizeWork(char** unsortedWords,


	                 char** alphabetizedWords,


	                         int howManyWords);


int main() {


	char      *unsortedWords[5] = {"Bryaxis",


									"Batman",


									 "Sadie",


									  "Milo",


									   "Lou"};


	char  *alphabetizedWords[5] = {"Batman",


	              				  "Bryaxis",


	              				      "Lou",


	              				     "Milo",


	              				    "Sadie"};

doesAlphabetizeWork(unsortedWords,alphabetizedWords, 5);

return 0;


}

void doesAlphabetizeWork(char** unsortedWords,


	                 char** alphabetizedWords,


	                         int howManyWords) {


	int i;

int  metaTest[howManyWords];


	int  realTest[howManyWords];


	for (i=0; i 
		metaTest[i] = (!strcmp(unsortedWords[i], unsortedWords[i]));


		realTest[i] = (!strcmp(unsortedWords[i],alphabetizedWords[i]));


	}


//	printf("MetaTest:\n");


//	for (i=0; i 
//		printf(GREEN);


//		printf("Success! unsortedWords[%d] '%s'",i, unsortedWords[i]);


//		printf("matches");


//		printf("unsortedWords[%d] '%s'.\n", i,  unsortedWords[i]);


//		printf(RESET);


//	}


//	printf("RealTest:\n");


	for (i=0; iif (realTest[i]) {


			printf(GREEN);


			printf("Success! unsortedWords[%d] '%s'",i, unsortedWords[i]);


			printf("matches");


			printf("alphabetizedWords[%d] '%s'.\n", i,  unsortedWords[i]);


			printf(RESET);

}


		else {


			printf(RED);


			printf("Failure! unsortedWords[%d] '%s'",i, unsortedWords[i]);


			printf("doesn't match");


			printf("alphabetizedWords[%d] '%s'.\n", i,  alphabetizedWords[i]);


			printf(RESET);


		}


	}


}


[/code]

Now when we compile and run this code we should see (with colors of course)


[code]


Failure! unsortedWords[0] 'Bryaxis'doesn't matchalphabetizedWords[0] 'Batman'.


Failure! unsortedWords[1] 'Batman'doesn't matchalphabetizedWords[1] 'Bryaxis'.


Failure! unsortedWords[2] 'Sadie'doesn't matchalphabetizedWords[2] 'Lou'.


Success! unsortedWords[3] 'Milo'matchesalphabetizedWords[3] 'Milo'.


Failure! unsortedWords[4] 'Lou'doesn't matchalphabetizedWords[4] 'Sadie'.


[/code]

In Part 2 we'll explore a number of possible sorting algorithms and start to implement our alphabetize algorithm, and finally get our test to pass.
