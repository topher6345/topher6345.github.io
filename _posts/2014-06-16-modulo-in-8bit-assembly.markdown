---
layout: post
status: publish
published: true
title: Adventures in 8-bit Assembly Part 2 - Modulo Subroutine
author: Topher
date: '2014-06-16 13:29:54 -0700'
categories:
- Code
tags:
- ASM
---

**Disclaimer:** I am not a professional assembler programmer so your mileage may vary with this code.

As I was playing with Marco Schweighauser's 8-bit assembler simulator, I wanted to write FizzBuzz in Assembler.

<a href="http://schweigi.github.io/assembler-simulator/index.html" target="_blank">8-bit assembler simulator</a>

A key part of FizzBuzz algorithm I was taking for granted was the modulo operator. I searched the docs of Marco's assembler and found that I'd need to implement modulo myself.

copy/paste the code below in the simulator to run and step through the code.

Find an error? Feel free to leave a comment or fork my gist here:

<a href="https://gist.github.com/topher6345/0c3dac619e575bf46935" target="_blank">modulo.asm</a>


```nasm

; int mod(int a,int b)
; by Topher6345
; Implements a integer modulo function

; for Simple 8-bit Assembler Simulator
; http://schweigi.github.io/assembler-simulator/index.html

JMP start

   ARG1: DB 13 ; Variable
   ARG2: DB 3  ; Variable

start:
   MOV A, [ARG1]  ; A = ARG1;
   MOV B, [ARG2]  ; B = ARG2;
   CALL modulo    ; MOD(A, B);
   MOV D, 232     ; Point to output;
   ADD C, 48      ; C = (char)C;
   MOV [D], C     ; print(C);
   DB 0           ; exit();

modulo:
   JE was_zero    ; if(B == 0) { return 0 };
   JC mod_return  ; if(B < 0) { return C };
   MOV C, A       ; C = A;
   SUB A, B       ; A = A - B;
   JAE modulo     ; MOD(A, B);

mod_return:
   RET            ; return C;

was_zero:
   MOV C, 0       ; C = 0;
   RET            ; return C;
```