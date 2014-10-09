---
layout: post
status: publish
published: true
title: Implementing quicksort Part 2
author: Topher
date: '2013-11-24 15:24:00 -0800'
categories:
- Code
---

[Part 1](sort-strings-alphabetically-in-c-part-1)

[On GitHub](https://github.com/topher6345/sort-strings-alphabetically-in-c)

[Download example files](https://github.com/topher6345/sort-strings-alphabetically-in-c/archive/master.zip)

In the previous section, we established our goal of implementing a word sorting algorithm by writing a test.

This test fails, because we have not actually alphabetized our words.
But the red and green test output give us a reward mechanism that lets us measure our success.

A string in C is an array of characters. These characters have integer values which, fortunately for this task, can be sorted using number sorting algorithms.

My favorite is quicksort. You can watch a very clear explanation of this algorithm on one of my favorite Youtube channels - Computerphile.

[Quick Sort - Computerphile](http://www.youtube.com/watch?v=XE4VP_8Y0BU)

The C header *stdlib.h* includes the function qsort(), which we could apply to this situation, but all the implementation details of the function are hidden.
I'm gonna wait until the end to show you how to use qsort().

We will implement quick sort first, then apply it to our array of strings from Part 1.

### part-2/1-quicksort-ints.c

```c++
#include <stdio.h>
#define RESET   "\033[0m"
#define BLACK   "\033[30m"      /* Black */
#define RED     "\033[31m"      /* Red */
#define GREEN   "\033[32m"      /* Green */

void quickSort( int[], int, int);
int partition( int[], int, int);


int main()
{
	int unsorted[] = { 7, 12, 1, -2, 0, 15, 4, 11, 9};
  int sorted[] = {-2, 0, 1, 4, 7, 9, 11, 12, 15};

	int i;

	quickSort( unsorted, 0, 8);

  // TEST
  for(i = 0; i < 9; ++i){
    if (unsorted[i] != sorted[i]){
      printf(RED);
      printf("\nSort failed - unsorted[%d] %d", i, unsorted[i]);
      printf("is not equal to sorted[%d] %d",i, sorted[i]);
      printf(RESET);
      return 1;
    }
  }
  printf(GREEN);
  printf("\nTest Passed! Quicksort Works.\n\n");
  printf(RESET);
  return 0;
}



void quickSort( int unsorted[], int l, int r)
{
   int pivot;

   if( l < r )
   {
   	// divide and conquer
       pivot = partition( unsorted, l, r);
       quickSort( unsorted, l, pivot-1);
       quickSort( unsorted, pivot+1, r);
   }

}

int partition( int currentPartition[], int firstPosition, int lastPosition) {
   int pivot, i, j, tmp;

   //set pivot to be the first element in the partition
   pivot = currentPartition[firstPosition];

   i = firstPosition;

   // set j to be one beyond the last poisition
   j = lastPosition+1;

   while( 1)
   {
    // increment i as long as
    // 1. currentPartition[i] is less than or equal to the pivot
    // 2. i is at the last position
   	do ++i; while( currentPartition[i] <= pivot && i <= lastPosition );

    // decrement j as long as
    // currentPartition[j] is greater than the pivot
    do --j; while( currentPartition[j] > pivot );

   	if( i >= j ) break;

    // swap currentPartition[i] and currentPartition[j]
   	tmp = currentPartition[i];
    currentPartition[i] = currentPartition[j];
    currentPartition[j] = tmp;
   }

   // swap currentPartition[l] and currentPartition[j]
   tmp = currentPartition[firstPosition];
   currentPartition[firstPosition] = currentPartition[j];
   currentPartition[j] = tmp;

   // return new pivot
   return j;
}
```

To Compile and run
```
gcc 1-quicksort-ints.c && ./a.out
```

If you compile and run this code you should see

```
Test Passed! Quicksort Works.
```

Lets start to pick apart this code.

In our main() function we first declare two arrays of integers.

```
int unsorted[] = { 7, 12, 1, -2, 0, 15, 4, 11, 9};
int sorted[] = {-2, 0, 1, 4, 7, 9, 11, 12, 15};
```

Below it, we call our quickSort() function to sort the arrays. With 3 arguments -
1. the array of integers to be sorted
2. A lower bound for the array (0 in this case)
3. The number of elements in the array (8).

```
quickSort( unsorted, 0, 8);
```

Below this in main, I've written a test to see if my hand sorted array *sorted* matches the output of quicksort.

```
  // TEST
  for(i = 0; i < 9; ++i){
    if (unsorted[i] != sorted[i]){
      printf(RED);
      printf("\nSort failed - unsorted[%d] %d", i, unsorted[i]);
      printf("is not equal to sorted[%d] %d",i, sorted[i]);
      printf(RESET);
      return 1;
    }
  }
  printf(GREEN);
  printf("\nTest Passed! Quicksort Works.\n\n");
  printf(RESET);
  return 0;
```

Our second function in this example is quickSort()

```
void quickSort( int unsorted[], int l, int r)
{
   int pivot;

   if( l < r )
   {
   	// divide and conquer
       pivot = partition( unsorted, l, r);
       quickSort( unsorted, l, pivot-1);
       quickSort( unsorted, pivot+1, r);
   }

}
```

Once again, we see the three arguments declared.

We also declare an int, a variable we call pivot, this variable is an index that will split the list into two sub-lists, an upper list with indexes above the pivot and a lower list with indexes below the pivot.

Searching the list of elements and selecting a pivot is its own algorithm. We've abstracted it into a function called partition() that returns an index. I'll finish discussing the quickiSort() function and then move on to explaining the partition() function

Once the list is split, quickSort() is called on the upper list and the lower lists.

```
       quickSort( unsorted, l, pivot-1);
       quickSort( unsorted, pivot+1, r);
```

Since the algorithm is the same for the sublists as it is for the whole list, its a perfect opportunity to use recursion. The function calls itself.

Lets move on to the function partition();

```
int partition( int currentPartition[], int firstPosition, int lastPosition) {
   int pivot, i, j, tmp;

   // set pivot to be the first element in the partition
   pivot = currentPartition[firstPosition];

   i = firstPosition;

   // set j to be one beyond the last position
   j = lastPosition+1;

   while( 1)
   {
    // increment i as long as
    // 1. currentPartition[i] is less than or equal to the pivot
    // 2. i is at the last position
   	do ++i; while( currentPartition[i] <= pivot && i <= lastPosition );

    // decrement j as long as
    // currentPartition[j] is greater than the pivot
    do --j; while( currentPartition[j] > pivot );

   	if( i >= j ) break;

    // swap currentPartition[i] and currentPartition[j]
    tmp = currentPartition[i];
    currentPartition[i] = currentPartition[j];
    currentPartition[j] = tmp;
   }

   // swap currentPartition[l] and currentPartition[j]
   tmp = currentPartition[firstPosition];
   currentPartition[firstPosition] = currentPartition[j];
   currentPartition[j] = tmp;

   // return new pivot
   return j;
}
```

I've done my best to comment and self-document this as clearly as possible.

This function of course returns an index, but partition() also has the other job of swapping elements which ultimatley modifies the order of our unsorted[] array of ints. This swapping function is the key to this algorithm.

A number of other implementations of quick sort move the elements into another memory location, but for our purposes we will swap them in place. This has to do with being efficient with memory and not allocating more than you need.

```
    // swap currentPartition[i] and currentPartition[j]
    tmp = currentPartition[i];
    currentPartition[i] = currentPartition[j];
    currentPartition[j] = tmp;
   }

   // swap currentPartition[l] and currentPartition[j]
   tmp = currentPartition[firstPosition];
   currentPartition[firstPosition] = currentPartition[j];
   currentPartition[j] = tmp;
```

This is the clearest and most basic example of Quick Sort'ing integers I could muster. We'll modify this code to sort characters and finally strings in the next examples.

Our next example sorts characters in a similar way

### part-2/2-quicksort-chars.c

```
#include <stdio.h>
#define RESET   "\033[0m"
#define BLACK   "\033[30m"      /* Black */
#define RED     "\033[31m"      /* Red */
#define GREEN   "\033[32m"      /* Green */

void quickSort( char[], int, int);
int partition( char[], int, int);

int main()
{
	char unsorted[] = { 'g', 'l', 'b', 'c', 'a', 'm', 'e', 'k', 'i'};
  char sorted[] = { 'a', 'b','c', 'e', 'g', 'i', 'k', 'l', 'm'};

	int i;

	quickSort( unsorted, 0, 8);

  // TEST
  for(i = 0; i < 9; ++i){
    if (unsorted[i] != sorted[i]){
      printf(RED);
      printf("\nSort failed - unsorted[%d] %c ", i, unsorted[i]);
      printf("is not equal to sorted[%d] %c ",i, sorted[i]);
      printf(RESET);
      return 1;
    }
  }
  printf(GREEN);
  printf("\nTest Passed! Quicksort Works.\n\n");
  printf(RESET);
  return 0;
}

void quickSort( char unsorted[], int l, int r)
{
   int pivot;

   if( l < r )
   {
   	// divide and conquer
       pivot = partition( unsorted, l, r);
       quickSort( unsorted, l, pivot-1);
       quickSort( unsorted, pivot+1, r);
   }

}

int partition( char currentPartition[], int firstPosition, int lastPosition) {
   int  i, j;
   char pivotElement, tmp;

   //set pivot to be the first element in the partition
   pivotElement = currentPartition[firstPosition];

   i = firstPosition;

   // set j to be one beyond the last position
   j = lastPosition+1;

   while( 1)
   {
    // increment i as long as
    // 1. currentPartition[i] is less than or equal to the pivotElement
    // 2. i is at the last position
   	do ++i; while( currentPartition[i] <= pivotElement && i <= lastPosition );

    // decrement j as long as
    // currentPartition[j] is greater than the pivot
    do --j; while( currentPartition[j] > pivotElement );

   	if( i >= j ) break;

    // swap currentPartition[i] and currentPartition[j]
   	tmp = currentPartition[i];
    currentPartition[i] = currentPartition[j];
    currentPartition[j] = tmp;
   }

   // swap currentPartition[l] and currentPartition[j]
   tmp = currentPartition[firstPosition];
   currentPartition[firstPosition] = currentPartition[j];
   currentPartition[j] = tmp;

   // return new pivot
   return j;
}
```
```
gcc part-2/2-quicksort-chars.c && ./a.out

```

If you compile and run this code you should see the same output as before.

All I've really done here is rewritten the previous integer Quick Sort example.
I was able to do this with confidence that I didn't break functionality because of the test I wrote.
When I messed up the functionality the test failed, and when I safely refactored the test continued to pass.

Lets check out what is different about this example.

Our function declarations are different, now partition() and quickSort() take char arrays as the first argument
```
void quickSort( char[], int, int);
int partition( char[], int, int);
```

Also remembering to make this change in the function definitions.
```
void quickSort( char unsorted[], int l, int r)
{
   int pivot;

   if( l < r )
   {
   	// divide and conquer
       pivot = partition( unsorted, l, r);
       quickSort( unsorted, l, pivot-1);
       quickSort( unsorted, pivot+1, r);
   }

}
```

Because now we are reordering and swapping chars, the corresponding variables used to swap these elements of the list have to declared as chars.
```
int partition( char currentPartition[], int firstPosition, int lastPosition) {
   int  i, j;
   char pivotElement, tmp;

   //set pivot to be the first element in the partition
   pivotElement = currentPartition[firstPosition];

   i = firstPosition;

   // set j to be one beyond the last position
   j = lastPosition+1;

   while( 1)
   {
    // increment i as long as
    // 1. currentPartition[i] is less than or equal to the pivotElement
    // 2. i is at the last position
   	do ++i; while( currentPartition[i] <= pivotElement && i <= lastPosition );

    // decrement j as long as
    // currentPartition[j] is greater than the pivot
    do --j; while( currentPartition[j] > pivotElement );

   	if( i >= j ) break;

    // swap currentPartition[i] and currentPartition[j]
   	tmp = currentPartition[i];
    currentPartition[i] = currentPartition[j];
    currentPartition[j] = tmp;
   }

   // swap currentPartition[l] and currentPartition[j]
   tmp = currentPartition[firstPosition];
   currentPartition[firstPosition] = currentPartition[j];
   currentPartition[j] = tmp;

   // return new pivot
   return j;
}
```

And of course, now our arrays to be sorted are fully of chars not ints.
```
char unsorted[] = { 'g', 'l', 'b', 'c', 'a', 'm', 'e', 'k', 'i'};
char sorted[] = { 'a', 'b','c', 'e', 'g', 'i', 'k', 'l', 'm'};
```

Since we now have some working code that alphabetizes chars, we can apply that to our strings, which are arrays of chars, by sorting by the first element of the array.

(For brevities sake I've defined the test function in a different file called doesAlphabetizeWork.c and included it.


### 3-quicksort-strings-fails/main.c

```
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "doesAlphabetizeWork.c"

void quickSort( char**, int, int);
int partition( char**, int, int);
void doesAlphabetizeWork(char** unsortedWords,
                     char** alphabetizedWords,
                             int howManyWords);


int main()
{
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

	int i;

	quickSort( unsortedWords, 0, 5);


    doesAlphabetizeWork(unsortedWords,alphabetizedWords, 5);

}



void quickSort( char **unsorted, int l, int r)
{
   int pivot;

   if( l < r )
   {
   	// divide and conquer
       pivot = partition( unsorted, l, r);
       quickSort( unsorted, l, pivot-1);
       quickSort( unsorted, pivot+1, r);
   }

}



int partition( char** currentPartition, int firstPosition, int lastPosition) {
   int  i, j;
   char* pivotElement;
   char* tmp;

   //set pivot to be the first element in the partition
   pivotElement = currentPartition[firstPosition];

   i = firstPosition;

   // set j to be one beyond the last position
   j = lastPosition+1;

   while( 1)
   {
    // increment i as long as
    // 1. currentPartition[i] is less than or equal to the pivotElement
    // 2. i is at the last position
   	do ++i; while(currentPartition[i][0] <= pivotElement[0] && i <= lastPosition );

    // decrement j as long as
    // currentPartition[j] is greater than the pivot
    do --j; while( currentPartition[j][0] > pivotElement[0] );

   	if( i >= j ) break;

    // swap currentPartition[i] and currentPartition[j]
   	tmp = currentPartition[i];
    currentPartition[i] = currentPartition[j];
    currentPartition[j] = tmp;
   }

   // swap currentPartition[l] and currentPartition[j]
   tmp = currentPartition[firstPosition];
   currentPartition[firstPosition] = currentPartition[j];
   currentPartition[j] = tmp;

   // return new pivot
   return j;
}
```
### part-2/3-quicksort-strings-fails/doesAlphabetizeWork.c

```
#define RESET   "\033[0m"
#define BLACK   "\033[30m"      /* Black */
#define RED     "\033[31m"      /* Red */
#define GREEN   "\033[32m"      /* Green */

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
//      printf(GREEN);
//      printf("Success! unsortedWords[%d] '%s'",i, unsortedWords[i]);
//      printf("matches");
//      printf("unsortedWords[%d] '%s'.\n", i,  unsortedWords[i]);
//      printf(RESET);
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

```
gcc 3-quicksort-strings-fails/main.c && 3-quicksort-strings-fails/./a.out
```

If you compile and run this code you should see this
```
Failure! unsortedWords[0] '����'doesn't matchalphabetizedWords[0] 'Batman'.
Failure! unsortedWords[1] 'Batman'doesn't matchalphabetizedWords[1] 'Bryaxis'.
Failure! unsortedWords[2] 'Bryaxis'doesn't matchalphabetizedWords[2] 'Lou'.
Failure! unsortedWords[3] 'Lou'doesn't matchalphabetizedWords[3] 'Milo'.
Failure! unsortedWords[4] 'Milo'doesn't matchalphabetizedWords[4] 'Sadie'.
```

Don't worry, code that passes our test is given below!
Our code fails because there is some problems with the implementation of our algorithm. char and int types can be compared with the == operator, but we really should be using strcmp() when dealing with char arrays.

Also our swap function is attempting to assign a char array, and we should really be using strcpy() for that.

Finally our working code, that passes the test we wrote in Part 1


### part-2/4-quicksort-for-strings-pass/main.c
```
#include <stdio.h>
#include <string.h>
#include "doesAlphabetizeWork.c"
void quickSortMain(char unsortedWords[][10], int count);
void quickSort(char unsortedWords[][10], int left, int right);
void doesAlphabetizeWork(char unsortedWords[][10],
                     char alphabetizedWords[][10],
                             int howManyWords);
int main(void)
{
  int i;
  char unsortedWords[][10] = {"Bryaxis",
                               "Batman",
                                "Sadie",
                                 "Milo",
                                  "Lou"};
  char alphabetizedWords[][10] = {"Batman",
                                 "Bryaxis",
                                     "Lou",
                                    "Milo",
                                   "Sadie"};

  quickSortMain(unsortedWords, 5);

  doesAlphabetizeWork(unsortedWords,alphabetizedWords, 5);

  return 0;
}

void quickSortMain(char items[][10], int count)
{
  quickSort(items, 0, count-1);
}

void quickSort(char items[][10], int left, int right)
{
  int i, j;
  char *x;
  char temp[10];

  i = left;
  j = right;
  x = items[(left+right)/2];

  do {
    while((strcmp(items[i],x) < 0) && (i < right)) {
       i++;
    }
    while((strcmp(items[j],x) > 0) && (j > left)) {
        j--;
    }
    if(i <= j) {
      strcpy(temp, items[i]);
      strcpy(items[i], items[j]);
      strcpy(items[j], temp);
      i++;
      j--;
   }
  } while(i <= j);

  if(left < j) {
     quickSort(items, left, j);
  }
  if(i < right) {
     quickSort(items, i, right);
  }
}
```

We also had to modify our test function

### part-2/4-quicksort-for-strings-pass/doesAlphabetizeWork.c
```
#define RESET   "\033[0m"
#define BLACK   "\033[30m"      /* Black */
#define RED     "\033[31m"      /* Red */
#define GREEN   "\033[32m"      /* Green */

void doesAlphabetizeWork(char unsortedWords[][10],
                     char alphabetizedWords[][10],
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
//      printf(GREEN);
//      printf("Success! unsortedWords[%d] '%s'",i, unsortedWords[i]);
//      printf("matches");
//      printf("unsortedWords[%d] '%s'.\n", i,  unsortedWords[i]);
//      printf(RESET);
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
if you compile and run this code you should see

```
Success! unsortedWords[0] 'Batman'matchesalphabetizedWords[0] 'Batman'.
Success! unsortedWords[1] 'Bryaxis'matchesalphabetizedWords[1] 'Bryaxis'.
Success! unsortedWords[2] 'Lou'matchesalphabetizedWords[2] 'Lou'.
Success! unsortedWords[3] 'Milo'matchesalphabetizedWords[3] 'Milo'.
Success! unsortedWords[4] 'Sadie'matchesalphabetizedWords[4] 'Sadie'.
```

Like I mentioned earlier, c has its own implementation of the quicksort algorithm defined in stdlib.h.

Its called qsort(). And it defines a subroutine for the algorithms we just wrote out by hand.

### part-2/5-qsort-strings/main.c
```
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "doesAlphabetizeWork.c"

int cstring_cmp(const void *a, const void *b)
{
    const char **ia = (const char **)a;
    const char **ib = (const char **)b;
    return strcmp(*ia, *ib);

}

int main()
{
    char *unsortedWords[] = {"Bryaxis",
                              "Batman",
                               "Sadie",
                                "Milo",
                                "Lou"};
    char *alphabetizedWords[] = {"Batman",
                                "Bryaxis",
                                    "Lou",
                                   "Milo",
                                 "Sadie"};

    size_t strings_len = sizeof(unsortedWords) / sizeof(char *);

    qsort(unsortedWords,
            strings_len,
         sizeof(char *),
           cstring_cmp);

    doesAlphabetizeWork(unsortedWords,alphabetizedWords, strings_len);

}
```
Once again, we've defined our test function in a separate file.

### part-2/5-qsort-strings/doesAlphabetizeWork.c

```
#define RESET   "\033[0m"
#define BLACK   "\033[30m"      /* Black */
#define RED     "\033[31m"      /* Red */
#define GREEN   "\033[32m"      /* Green */

void doesAlphabetizeWork(char *unsortedWords[],
                     char *alphabetizedWords[],
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
//      printf(GREEN);
//      printf("Success! unsortedWords[%d] '%s'",i, unsortedWords[i]);
//      printf("matches");
//      printf("unsortedWords[%d] '%s'.\n", i,  unsortedWords[i]);
//      printf(RESET);
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


If you compile this code and run it you should see:

```
Success! unsortedWords[0] 'Batman'matchesalphabetizedWords[0] 'Batman'.
Success! unsortedWords[1] 'Bryaxis'matchesalphabetizedWords[1] 'Bryaxis'.
Success! unsortedWords[2] 'Lou'matchesalphabetizedWords[2] 'Lou'.
Success! unsortedWords[3] 'Milo'matchesalphabetizedWords[3] 'Milo'.
Success! unsortedWords[4] 'Sadie'matchesalphabetizedWords[4] 'Sadie'.
```

Lets discuss the qsort() function.

C library function definition:
```
void qsort(void *base, size_t nitems, size_t size, int (*compar)(const void *, const void*))
```

Our usage in main.c
```
qsort(unsortedWords,
        strings_len,
     sizeof(char *),
       cstring_cmp);
```

qsort() takes 4 arguments
1. an collection to be sorted in terms of a pointer to an array.
2. an integer of how many elements are in the collection
3. the size of the individual elements in the collection to be sorted.
4. a comparison function that returns an int.

Argument # 4 takes a pointer to a function, a callback routine. Typical in C, callback functions are executed by their parent functions. In other words, qsort() will decide when its necessary to utilize the callback function you give it.

Heres our callback function cstring_cmp():

```
int cstring_cmp(const void *a, const void *b)
{
    const char **ia = (const char **)a;
    const char **ib = (const char **)b;
    return strcmp(*ia, *ib);

}
```

The reason qsort() needs this callback function is pertinent to our usage of it. qsort() can sort integers, chars, strings, or any C data structure, this callback function specifies how elements are compared. Comparing ints in C is different from comparing strings, this callback function must implement a comparison that is useful to the collection you are trying to sort. In our case, this callback function compares strings, and returns an int back to qsort() to let qsort() know wether to swap the two elements.


Hopefully this tutorial will be a good reference on sorting algorithms and test-driven development.

In closing, I'd like to point out that TDD was essential to implementing this.
1. I google searched "sort c strings alphabetically", found some code.
2. wrote some test to prove that it worked (often it didn't)
3. Refactored and commented it until it was clear, readable and understandable.
