---
layout: post
status: publish
published: true
title: Implementing quicksort Part 1
author: Topher
date: '2013-11-24 15:23:10 -0800'
categories:
- Code
tags: []
---

# Implementing alphabetical sorting in C using Test Driven Development

## Introduction

Let's examine a classic computer science question - *how to alphabetically sort words.*

In the first part, we'll examine the problem and set up a test-driven-development template. 

In the second part we'll examine the Quick Sort algorithm, and implement it to get our test to pass. 

Heres our list of words (or 'strings' in C speak). They're the names of some of my friend's cats. 
We'll be using this list throughout the tutorial.

* Bryaxis
* Batman
* Sadie
* Milo
* Lou

# Part 1

In Ruby, my weapon of choice for dealing with strings, it goes like this.

Open irb in your terminal window and type
```
@names = ['Bryaxis', 'Batman', 'Sadie', 'Milo', 'Lou']
@names.sort
```

To skip the interpretor look for file

### part-1/01-alphabetical-sort-ruby.rb

```bash
ruby 01-alphabetical-sort-ruby.rb
```

Python is also good with strings 

Open the python interpreter and type 
```python
names = ['Bryaxis', 'Batman', 'Sadie', 'Milo', 'Lou']
sorted(names)
```
To skip the the interpretor 

### part-1/03-alphabetical-sort-python.py

```bash
python 03-alphabetical-sort-python.py
```
In these languages, string sorting has already be implemented,
but we want to examine *how* an algorithm like this is structured and implemented. 
So, let's get low-level and work it out in C.

If we're gonna reinvent the wheel, let's do it right and use [test driven development](http://en.wikipedia.org/wiki/Test-driven_development). 
A software development technique designed to reduce frustration and make software development FUN. 

The idea is simple, you write a *failing test* and then you write the code required to pass it. Its a built in reward system. Instead of wondering "did my program do what I wanted it to do?" you can have the software *tell you* it works. 


We'll start with a simple C file 

### part-1/05-simple-assert.c

```c++ 
#include <stdio
#include <assert.h>

int main() {
    assert(0);
    return 0;
}
```
To Compile & run
```bash
gcc 05-simple-assert.c && ./a.out
```

you should see:
```bash
Assertion failed: (0), function main, file main.c, line 5.
Abort trap
```

If you are unfamiliar with TDD, you might be wondering what assert() is all about. 

'assert()' is like a sanity test. It passes if true (the integer 1 in C) and fails if false (0). Our first bit of code here tests the test. 
We can make sure it passes on true by inserting a positive assert.
This way, our code compiles without errors, but stops on execution if our algorithm isn't doing what we want it to.

### part-1/06-simple-meta-assert.c
```c++
#include <stdio
#include <assert.h>

int main() {
    assert(1);
    assert(0);
    return 0;
}
```
To compile and run 

```bash
gcc 06-simple-meta-assert.c && ./a.out
```

you should see:
```bash
Assertion failed: (0), function main, file main.c, line 6.
Abort trap
```

Notice that it failed on line 6, but not on line 5. this should make you comfortable enough with the assert() function to continue on. 

Since we will be dealing with words, lets add the string.h header, and some string comparison assertions to our code.

### part-1/07-simple-assert-two-strings.c
```c++
#include <stdio
#include <assert.h>
#include <string.h>
int main() {
  char unsortedWords[] = "false";
  char alphabetizedWords[] = "true";
  assert(!strcmp(unsortedWords,unsortedWords));
  assert(!strcmp(unsortedWords,alphabetizedWords));
  return 0;
}
```
To compile and run
```bash
gcc 07-simple-assert-two-strings.c && ./a.out
```
you should see 
```bash
Assertion failed: (!strcmp(unsortedWords,sortedWords)), function main, file main.c, line 8.
Abort trap
```

We are using the strcmp() function to compare two strings, notice the ! before strcmp(), because strcmp() is weird and returns 0 if the strings don't match and 1 if they do. (welcome to C, where up is down and down is up, I miss ruby already)

This gets us closer to being able to test if we correctly implemented a way to alphabetize words. We're not all the way there yet, because we can only test if one word is the same as another, so lets modify our code further to make a robust failing test to see if two arrays of strings are the same.

We'll need a way to iterate through an array of strings and compare each individual string in the array.

### part-1/08-compare-first-element-of-string-array.c
```c++
#include <stdio
#include <assert.h>
#include <string.h>
int main() {
  char      *unsortedWords[5] = {"Bryaxis", "Batman" , "Sadie", "Milo", "Lou"  };
  char  *alphabetizedWords[5] = {"Batman" , "Bryaxis", "Lou"  , "Milo", "Sadie"};
  assert(!strcmp(unsortedWords[0],    unsortedWords[0]));
  assert(!strcmp(unsortedWords[0],alphabetizedWords[0]));
  return 0;
}
```

To compile and run
```bash
gcc 08-compare-first-element-of-string-array.c && ./a.out
```

If we compile and run this, then we should get this message
```bash
Assertion failed: (!strcmp(unsortedWords[0],alphabetizedWords[0])), 
function main, file main.c, line 8.
Abort trap
```

Which tells us that the first word (aka string) in the array is not the same. 

So lets modify our code furthur to check every single word in the array. 

We'll have to quit using assert() because a failed assert stops execution of the program.

### 09-compare-array-of-strings.c
```c++
#include <stdio
#include <assert.h>
#include <string.h>
int main() {
  char      *unsortedWords[5] = {"Bryaxis", "Batman" , "Sadie", "Milo", "Lou"  };
  char  *alphabetizedWords[5] = {"Batman" , "Bryaxis", "Lou"  , "Milo", "Sadie"};
  int  metaTest[5];
  int  realTest[5];
  int i;
  for (i=0; i < 5; i++){
    metaTest[i] = (!strcmp(unsortedWords[i], unsortedWords[i]));
    realTest[i] = (!strcmp(unsortedWords[i],alphabetizedWords[i]));
  }
  printf("MetaTest:\n");
  for (i=0; i < 5; i++){
    printf("Success! unsortedWords[%d] '%s' matches 
    unsortedWords[%d] '%s'.\n", 
      i, unsortedWords[i], i,  unsortedWords[i] );
  }
  printf("RealTest:\n");
  for (i=0; i < 5; i++){

    if (realTest[i]) {
      printf("Success! unsortedWords[%d] '%s' matches 
      unsortedWords[%d] '%s'.\n", 
        i, unsortedWords[i], i,  unsortedWords[i] );
    }
    else {
      printf("Failure! unsortedWords[%d] '%s' doesn't match 
      alphabetizedWords[%d] '%s'.\n", 
        i, unsortedWords[i],i,  alphabetizedWords[i] );
    }
  }
  return 0;
}
```

To compile and run

```bash
gcc 09-compare-array-of-strings.c && ./a.out
```

And you should see:

```bash
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
```
 
We have a automatic way to test if two arrays of words are the same. But its a little hard to infer that so, at the risk of going on a tangent here, I'm going to add some terminal colors to this output. 
Here I should mention I'm on OSX 10.6 so this color codes might not work for you. Along the way I'll enforce some better coding style-like not having lines longer than 79 columns.

### 10-compare-array-of-strings-colors.c

``` c++
#include <stdio
#include <assert.h>
#include <string.h>
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
  for (i=0; i < 5; i++){
    metaTest[i] = (!strcmp(unsortedWords[i], unsortedWords[i]));
    realTest[i] = (!strcmp(unsortedWords[i],alphabetizedWords[i]));
  }
  printf("MetaTest:\n");
  for (i=0; i < 5; i++){
    printf(GREEN);
    printf("Success! unsortedWords[%d] '%s'",i, unsortedWords[i]);
    printf("matches"); 
    printf("unsortedWords[%d] '%s'.\n", i,  unsortedWords[i]);
    printf(RESET);
  }
  printf("RealTest:\n");
  for (i=0; i < 5; i++){

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
```

Our code is getting a little crowded, so let's put our test into a function. And comment out our metatest

```c++
#include <stdio
#include <assert.h>
#include <string.h>
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
  for (i=0; i < howManyWords; i++){
    metaTest[i] = (!strcmp(unsortedWords[i], unsortedWords[i]));
    realTest[i] = (!strcmp(unsortedWords[i],alphabetizedWords[i]));
  }
//  printf("MetaTest:\n");
//  for (i=0; i < howManyWords; i++){
//    printf(GREEN);
//    printf("Success! unsortedWords[%d] '%s'",i, unsortedWords[i]);
//    printf("matches"); 
//    printf("unsortedWords[%d] '%s'.\n", i,  unsortedWords[i]);
//    printf(RESET);
//  }
//  printf("RealTest:\n");
  for (i=0; i < howManyWords; i++){

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
}
```

To compile and run

```bash
gcc 11-does-alphabetize-work-function.c && ./a.out
```

Now when we compile and run this code we should see (with colors of course)

```bash

Failure! unsortedWords[0] "Bryaxis'doesn't matchalphabetizedWords[0] 'Batman'".
Failure! unsortedWords[1] "Batman'doesn't matchalphabetizedWords[1] 'Bryaxis'".
Failure! unsortedWords[2] "Sadie'doesn't matchalphabetizedWords[2] 'Lou'".
Success! unsortedWords[3] "Milo'matchesalphabetizedWords[3] 'Milo'".
Failure! unsortedWords[4] "Lou'doesn't matchalphabetizedWords[4] 'Sadie'".
```