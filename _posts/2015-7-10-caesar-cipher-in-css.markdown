---
layout: post
status: publish
published: true
title: Caesar Cipher in CSS and Ruby
author: Topher
date: '2015-7-10 22:47:11 -0700'
categories:
- Code
- Graphics
tags:
- Css
- - Ruby
---

> In cryptography, a Caesar cipher, also known as Caesar's cipher, the shift cipher, Caesar's code or Caesar shift, is one of the simplest and most widely known encryption techniques. It is a type of substitution cipher in which each letter in the plaintext is replaced by a letter some fixed number of positions down the alphabet.

Below is a interactive endcoder/decoder for the Caesar Cipher I wrote in HTML/CSS/Javascript.

Grab the slider to shift letters of the alphabet by a certain shift value. 

In the center of the wheel, you can find the key that will decode the encoded message.

<p data-height="623" data-theme-id="0" data-slug-hash="KpQBxZ" data-default-tab="result" data-user="topher6345" class='codepen'>See the Pen <a href='http://codepen.io/topher6345/pen/KpQBxZ/'>Super Secret Decoder Ring</a> by Christopher Saunders (<a href='http://codepen.io/topher6345'>@topher6345</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

## Implementation in Ruby

The Caesar Cipher is a a pretty naive cryptographic cipher. I thought it would be fun to demonstrate just how weak the cipher is by writing 

1. A Ruby class to encipher a string `CaesarCipher::Encode`
2. A Ruby class to crack an enciphered message `CaesarCipher::Cracker`

We can crack an enciphered message by

* Analyzing the letter frequencies of the ciphertext 
* Assuming that the most frequent letter in the cipher text is 'e' in plaintext
* Calculating the distance between 'e' and the most frequent letter in the ciphertext
* Appling a shift to the ciphertext to decipher the message into plaintext


## Enciphering plaintext

Given a shift value, we can create a table(or dictionary or map) that maps plaintext letters to shifted ciphertext letters. In Ruby the `Hash` class will work great for this. We can use a plaintext letter as a key and the shifted ciphertext letter as the value.

```ruby
cipher = { 'a' => 'c'}
cipher['a']
=> 'c'
```

To build such a table based on a shift value we first start with a set of all the letters in the English alphabet. We can do this in Ruby by using a `Range` and converting it into an array of characters.

```ruby
  ALPHABET = ('a'..'z').to_a
=> ['a', 'b', 'c', ..]
```

Because we want to preserve capitalization, we'll create another range that builds a sequence of all capital letters.

```ruby
ALPHABET_UPCASE = ('A'..'Z').to_a
=> ['A', 'B', 'C', ..]
```

We can assign these to constants because these sequences will not change or be mutated or reassigned during the process.

### Building the dictionary

We can rotate an array using the `Array#rotate` method

[http://ruby-doc.org/core-2.2.0/Array.html#method-i-rotate](Array#rotate)

```ruby
shift = 3
ALPHABET.rotate(shift)
=> ['c', 'd', 'e', ..]
```

This will return a **copy** of the alphabet array that has been rotated and provide the value set of our `Hash` map.

We can then take the original alphabet array and `zip` the shifted array to get an array of pairs

[http://ruby-doc.org/core-2.2.0/Array.html#method-i-zip](Array#zip)

```ruby
shift = 3
ALPHABET.zip(ALPHABET.rotate(shift))
=> [['a', 'c'], ['b', 'd'] ...]
```
We now have key/value pairs, but this isn't the `Hash` that we want.

Luckily the `Hash#[]` method can construct a new `Hash` from an array.

[http://ruby-doc.org/core-2.2.0/Hash.html#method-c-5B-5D](Hash#[])

first we have to transform the two dimensional array into a one dimensional array, we can use `Array#flatten` to do this

[http://ruby-doc.org/core-2.2.0/Array.html#method-i-flatten](Array#flatten)

```ruby
shift = 3
ALPHABET.rotate(shift)).flatten(1)
=> ['a', 'c', 'b', 'd', ...]
```

We can then use the splat operator `*` to transform an array into a list of arguments

[http://ruby-doc.org/core-2.2.0/doc/syntax/calling_methods_rdoc.html#label-Array+to+Arguments+Conversion](Array to Arguments Conversion)

```ruby
Hash[*ALPHABET.zip(ALPHABET.rotate(shift)).flatten(1)]
=> {'a' => 'c', 'b' => 'd', ...}
```

Now we have a hash that maps lowercase plaintext letters to ciphertext letters. We can use the `Hash#merge!` method to merge a similar table with uppercase letters

[http://ruby-doc.org/core-2.2.0/Hash.html#method-i-merge-21](Hash#merge)

```ruby
@cipher = Hash[*ALPHABET.zip(ALPHABET.rotate(shift)).flatten(1)].merge!(
Hash[*ALPHABET_UPCASE.zip(ALPHABET_UPCASE.rotate(shift)).flatten(1)])
```

## Usage

Let's encipher a funny satirical article. 

> An online listing for a job at area marketing firm BizKo Solutions has left local man Ryan Urlich unsure whether he is truly dynamic enough to qualify for the position, sources confirmed Wednesday. “I’m willing to work in a fast-paced, deadline-oriented environment, sure, but am I really a dynamic self-starter?” said the 29-year-old college graduate, adding that this is the first time he’s ever considered whether he’s “a results-driven, high-energy ‘A’ player capable of providing cutting-edge insights.” “I suppose I can reimagine a brand, but can I go into a job interview, look someone in the eye, and tell them I’m a strong strategic thinker with the creative vision to drive brand awareness in an increasingly global marketplace? I don’t know if I can.” According to reports, Urlich ultimately decided not to apply for the job, saying he needed to take a few days to “really stop and think” about how dynamic he truly is so that he doesn’t waste anyone at BizKo’s time.

http://www.theonion.com/video/man-not-sure-hes-dynamic-enough-to-work-at-local-m-31546

Because we rely on a statistical analysis of the frequency of letters in our plaintext message, it is important that this message be of substantial length, 

We'll assign the above article to `plaintext`, and use a random shift amount, not even we will know what the key is.

```
secret = CaesarCipher::Encoder.new(plaintext: plaintext.sample, shift: rand(3..25)).encoded_message
p secret
```

> "Zm nmkhmd khrshmf enq z ina zs zqdz lzqjdshmf ehql AhyJn Rnktshnmr gzr kdes knbzk lzm Qxzm Tqkhbg tmrtqd vgdsgdq gd hr sqtkx cxmzlhb dmntfg sn ptzkhex enq sgd onrhshnm, rntqbdr bnmehqldc Vdcmdrczx. “H’l vhkkhmf sn vnqj hm z ezrs-ozbdc, cdzckhmd-nqhdmsdc dmuhqnmldms, rtqd, ats zl H qdzkkx z cxmzlhb rdke-rszqsdq?” rzhc sgd 29-xdzq-nkc bnkkdfd fqzctzsd, zcchmf sgzs sghr hr sgd ehqrs shld gd’r dudq bnmrhcdqdc vgdsgdq gd’r “z qdrtksr-cqhudm, ghfg-dmdqfx ‘Z’ okzxdq bzozakd ne oqnuhchmf btsshmf-dcfd hmrhfgsr.” “H rtoonrd H bzm qdhlzfhmd z aqzmc, ats bzm H fn hmsn z ina hmsdquhdv, knnj rnldnmd hm sgd dxd, zmc sdkk sgdl H’l z rsqnmf rsqzsdfhb sghmjdq vhsg sgd bqdzshud uhrhnm sn cqhud aqzmc zvzqdmdrr hm zm hmbqdzrhmfkx fknazk lzqjdsokzbd? H cnm’s jmnv he H bzm.” Zbbnqchmf sn qdonqsr, Tqkhbg tkshlzsdkx cdbhcdc mns sn zookx enq sgd ina, rzxhmf gd mddcdc sn szjd z edv czxr sn “qdzkkx rsno zmc sghmj” zants gnv cxmzlhb gd sqtkx hr rn sgzs gd cndrm’s vzrsd zmxnmd zs AhyJn’r shld."


We can use the `Cracker` class to crack this message.

```ruby
CaesarCipher::Cracker.new(secret).cracked
```

## Full source with examples:

<script src="https://gist.github.com/topher6345/63db89e576d9d4f199e7.js"></script>
