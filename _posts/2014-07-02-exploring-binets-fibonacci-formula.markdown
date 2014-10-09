---
layout: post
status: publish
published: true
title: Exploring Binet's Fibbonacci formula with Ruby
author: Topher
date: '2014-07-02 15:24:00 -0800'
categories:
- Code
---


# Exploring Binet's Fibbonacci formula

Fibonacci algorithms come up frequently in coding interviews and programming excercises.

I'll compare two techniques for generating fibonacci numbers in ruby

* Dynamic programming
* Binet's formula


## Algorithms

Find the **N** th Fibonacci number

### Dynamic Programming

```ruby
n = 300
state = [1,1]; n.times  {  state.push(state[-1] + state[-2]) } puts state.last.to_i
```
Result:

`222232244629420445529739893461909967206666939096499764990979600`


#### Pros

* The result is correct.

#### Cons

* This algorithm runs in O(n) linear time.

* Requires 2 integers worth of sp

  My naive implementation above fills a 300-element array with integers.





### Binet's Formula

```ruby
n= 300
sqrt5 = Math.sqrt(5); ( ((1 + sqrt5)** n) - ((1  - sqrt5)** n) ) / ((2 ** n) * sqrt5)
```

result:

`222232244629422676106398124069050176556246085874450435841982464`

#### Pros

* Runs in O(k) constant time

* Runs almost no space complexity


#### Cons

* Inaccurate due to rounding errors with floating point approximations of the irrational number square-root-of-5


## Comparison

How accurate is Binet's formula? The following code displays the difference and percent difference between the two methods

```ruby
state = [1,1]; 298.times  {  state << ( state[-1] + state[-2] ) }

sqrt5 = Math.sqrt(5)
def fib(n, sqrt5)
  return ( ( ((1 + sqrt5)** n) - ((1 - sqrt5)** n) ) / ((2 ** n) * sqrt5) ).to_i
end

results = []
state.each_with_index do |n, index|
  difference = (n - fib(index + 1, sqrt5))
  puts "N:#{index+ 1} " +
     "⬤: #{n} " +
     "θ:#{ (difference/n) unless difference.zero?}% " +
     "Δ:#{difference}"
end

```

**N** is the index of the fibonacci number

⬤ (giant dot) is value the fibonacci number

Δ (delta) is the difference in the results produced by Binet's formula and dynamic programming

θ (theta) is the percent difference between the results produced by both algorithms



### Results

Δ is 0 up until **N** = 72


```

N:71 ⬤: 308061521170129 θ:0%  Δ:0
N:72 ⬤: 498454011879264 θ:-1%  Δ:-1
```

Any problem requiring less than 72 elements of the fibonacci sequence will be accurate to a whole number integer with Binet's formula


At **N** = 300

```
N:300
⬤:222232244629420445529739893461909967206666939096499764990979600
θ:-1%
Δ:-2230576658230607140209349579146777950670851002864
```

our result is off by quite a lot, but the percent of deviation is constant.


## Bonus

### in Haskell

```haskell
let fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
let fib n = fibs ! (n-1)
fib 300
```

Result

`222232244629420445529739893461909967206666939096499764990979600`