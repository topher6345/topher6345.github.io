---
layout: post
status: publish
published: true
title: Eight Queens Puzzle
author: Topher
date: '2014-11-22 13:29:54 -0700'
categories:
- Code
tags:
- Ruby
---
# Eight queens puzzle
From Wikipedia, the free encyclopedia

> The eight queens puzzle is the problem of placing eight chess queens on an 8x8 chessboard so that no two queens threaten each other. Thus, a solution requires that no two queens share the same row, column, or diagonal. 

I came across this problem in Lynda.com's Code Clinic. and I wanted to give it a try.

## Result

I ended up with a result that satisfies the following requirements

* Correctness
* Simple, Semantic Interface
* Efficiency (No needless copying)
* Limited Cyclomatic complexity for each method
* Under 7 lines of code for each method (excluding class constructor)
* Favoring Object Composition

and as a bonus, it will calculate queen placement for chessboards larger than 8x8

### Code

```ruby
class Chessboard
  attr_accessor :queens
  attr_accessor :board

  def initialize(size)
    @size = size
    @queens, @board = [], []
    @size.times do |i|
      @size.times do |j|
        board << [i, j]
      end
    end
  end

  def calculate
    @size.times { add_queen }
    @queens
    rescue NoMethodError
      initialize @size
      calculate
  end

  def add_queen
    queen = @board.sample
    @board.delete_if { |a| a[0] == queen[0] } # [+, y]
    @board.delete_if { |a| a[1] == queen[1] } # [x, +]
    strip_diagonals queen
    @queens << queen
    self
  end

  def strip_diagonals(queen)
    rm_bottom_right_from queen # [+, +]
    rm_bottom_left_from queen  # [-, -]
    rm_top_left_from queen     # [+, -]
    rm_bottom_left_from queen  # [-, +]
  end

  def rm_bottom_right_from(queen)
    i, j = queen
    while i < @size || j < @size
      @board.delete_if { |a| a == [i, j] }
      i += 1; j += 1
    end
  end

  def rm_bottom_left_from(queen)
    i, j = queen
    while i < @size || j > -1
      @board.delete_if { |a| a == [i, j] }
      i += 1; j -= 1
    end
  end

  def rm_top_left_from(queen)
    i, j = queen
    while i > -1 || j > -1
      @board.delete_if { |a| a == [i, j] }
      i -= 1; j -= 1
    end
  end

  def rm_bottom_left_from(queen)
    i, j = queen
    while i > -1 || j < @size
      @board.delete_if { |a| a == [i, j] }
      i -= 1; j += 1
    end
  end
end

Chessboard.new(8).calculate
```

## Data Structures

My first step was to determine what data structure I will use. 

At first, I thought an 8-element array of 8-element arrays would work. 

I settled on a 64 element array of `x` and `y` coordinates. 

## Analysis

At very beginning I could see that removing diagonal elements would be the hardest part of the solution.

## Algorithm

* Fill an N^2 size array with x,y coordinates ranging 0..N for x and 0..N for y
* Choose an element from the board using Ruby's `Array#sample` method.
* Remove every horizontal threats
* Remove every vertical threat
* Remove every diagonal threat
* Choose another element until N elements have been chosen
* If for any reason no new element can be placed, recursively call the algorithm with a newly initialized state

## First Steps

* Plan out the problem space 
* Calculate the size of the data set
* Isolate hot-spots
* Implement low hanging fruit
* Design interfaces for more complicated problems

## VS Lynda.com Solution

The Lynda.com solution used a technique called backtracking, to go back one step if an invalid queen was placed. 
Since my program only chooses from available places, this is not needed, but often results in a board where no moves are valid. In my case, the program calls itself with a fresh board, which may be ineffecient with large boards.

