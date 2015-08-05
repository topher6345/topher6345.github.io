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

# Caesar Cipher

> In cryptography, a Caesar cipher, also known as Caesar's cipher, the shift cipher, Caesar's code or Caesar shift, is one of the simplest and most widely known encryption techniques. It is a type of substitution cipher in which each letter in the plaintext is replaced by a letter some fixed number of positions down the alphabet.

Below is a interactive endcoder/decoder for the Caesar Cipher I wrote in HTML/CSS/Javascript.

Grab the slider to shift letters of the alphabet by a certain shift value. 

In the center of the wheel, you can find the key that will decode the encoded message.

<p data-height="623" data-theme-id="0" data-slug-hash="KpQBxZ" data-default-tab="result" data-user="topher6345" class='codepen'>See the Pen <a href='http://codepen.io/topher6345/pen/KpQBxZ/'>Super Secret Decoder Ring</a> by Christopher Saunders (<a href='http://codepen.io/topher6345'>@topher6345</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

# Implementation in Ruby


```ruby
# A library for encoding/cracking the Ceasar Cipher
module CaesarCipher
  ALPHABET = ('a'..'z').to_a
  ALPHABET_UPCASE = ('A'..'Z').to_a
  # Responsible for encrypting a string
  # using the Caesar Cipher
  class Encoder
    attr_reader :encoded_message
    def initialize(plaintext:, shift:)
      @words = plaintext.split(' ')
      @cipher = Hash[*ALPHABET.zip(ALPHABET.rotate(shift)).flatten(1)].merge!(
        Hash[*ALPHABET_UPCASE.zip(ALPHABET_UPCASE.rotate(shift)).flatten(1)])
      apply_cipher
    end

    def apply_cipher
      @encoded_message = @words.map do |word|
        shift_letters_in_word(word)
      end.join(' ')
    end

    def shift_letters_in_word(word)
      word.split('').map do |letter|
        cipher_letter(letter)
      end.join('')
    end

    def cipher_letter(letter)
      return @cipher[letter] if letter[/[a-zA-Z]/]
      letter
    end
  end

  # Responsible for cracking text
  # encoded in a Cesar Cipher
  class Cracker
    attr_reader :cracked
    def initialize(secret)
      @secret = secret
      @cracked = crack
    end

    def crack
      CaesarCipher::Encoder.new(
        plaintext: @secret, shift: calculate_offset
      ).encoded_message
    end

    def calculate_offset
      ALPHABET.index('e') - ALPHABET.index(most_frequent_letter)
    end

    def most_frequent_letter
      analyze_frequency.first[1]
    end

    def analyze_frequency
      letters_by_count.map do |item|
        ["#{(item[0].to_f / total_count * 100.0).round(2)}%", item[1]]
      end
    end

    def letters_by_count
      count_letters.to_a.map(&:reverse).sort.reverse
    end

    def count_letters
      @secret.split('').each_with_object(Hash.new(0)) do |letter, hsh|
        hsh[letter.downcase] += 1 if letter[/[a-zA-Z]/]
      end
    end

    def total_count
      letters_by_count.inject(0) { |a, e| a + e[0] }
    end
  end
end
```


```ruby

plaintext = []
plaintext << <<TEXT
  An online listing for a job at area marketing firm BizKo Solutions has left local man Ryan Urlich unsure whether he is truly dynamic enough to qualify for the position, sources confirmed Wednesday. “I’m willing to work in a fast-paced, deadline-oriented environment, sure, but am I really a dynamic self-starter?” said the 29-year-old college graduate, adding that this is the first time he’s ever considered whether he’s “a results-driven, high-energy ‘A’ player capable of providing cutting-edge insights.” “I suppose I can reimagine a brand, but can I go into a job interview, look someone in the eye, and tell them I’m a strong strategic thinker with the creative vision to drive brand awareness in an increasingly global marketplace? I don’t know if I can.” According to reports, Urlich ultimately decided not to apply for the job, saying he needed to take a few days to “really stop and think” about how dynamic he truly is so that he doesn’t waste anyone at BizKo’s time.
TEXT

secret = CaesarCipher::Encoder.new(plaintext: plaintext.sample, shift: rand(3..25)).encoded_message
p secret
p CaesarCipher::Cracker.new(secret).cracked
```
