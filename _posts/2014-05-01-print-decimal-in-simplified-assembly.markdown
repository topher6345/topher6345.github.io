---
layout: post
status: publish
published: true
title: Adventures in 8-bit Assembly Part 1 - Print a decimal
author: Topher
date: '2014-05-01 13:29:54 -0700'
categories:
- Code
tags:
- ASM
---

**Disclaimer:** I am not a professional assembler programmer so your mileage may vary with this code.

Although I work professionally with high level web languages like Ruby and Javascript, it is nice sometimes to get down to the metal and explore simple things.

I found a great project by Swiss developer Marco Schweighauser - an 8-bit assembler simulator written in AngularJS!

<a href="http://schweigi.github.io/assembler-simulator/index.html" target="_blank">Check it out here</a>

After playing with this for a while, I decided to challenge myself and figure out a way to print a decimal number to the console of the simulator.

Simply copy/paste the code below in Marco's simulator to step through it and see it in action!

```nasm

; printf(int)
; by Topher6345
; Prints a decimal-formatted, positive 8-bit integer to stdout.

; for Simple 8-bit Assembler Simulator
; http://schweigi.github.io/assembler-simulator/index.html

  JMP start

hello: DB 78            ; int *hello; The number we wish to print;
                        ; *hello = [val];

start:
  MOV A, [hello]  ; A = *hello; printf() takes register A as input
  CALL printf     ; printf(A);
  DB 0            ; return 0;

printf:
  MOV D, 232        ; D = 232        ; Point to stdout
  CALL printfThree  ; printfThree(A) ; Print N__
  CALL printfTwo    ; printfTwo(A)   ; Print _N_
  CALL printfOne    ; printfOne(A)   ; Print __N
  RET               ; return 0;

printfThree:
  DIV 100         ; A/100     ; Divide by 100, store result in register A.
  CALL printfA    ; print(A)  ; Print value in register A to stdout.
  RET             ; return 0;

printfTwo:
  MOV A, [hello]  ; A = *hello
  MOV B, [hello]  ; B = *hello
  DIV 100         ; A / 100   ; Divide by 100 and store result in register A.
  MUL 100         ; A * 100   ; Multiply by 100 and store result in register A.
  SUB B,A         ; B = B - A ; Subtract value in register A from original value.
  MOV A, B        ; A = B     ; Assign value in register B to register A.
  DIV 10          ; A/10      ; Divide by 10 and store result in register A.
  CALL printfA    ; print(A)  ; Print value in register A to stdout.
  RET             ; return 0;

printfOne:
  MOV A, [hello]  ; A = *hello
  MOV B, [hello]  ; B = *hello
  DIV 10          ; A / 10     ; Divide by 10 and store result in register A.
  MUL 10          ; A * 10     ; Multiply by 10 and store result in register A.
  SUB B,A         ; B = B - A  ; Subtract A from original value.
  MOV A, B        ; A = B      ; Assign value in register B to registerA.
  CALL printfA    ; print(A)   ; Print value in register A to stdout.
  RET             ; return 0;

printfA:
  ADD A, 48       ; A + ASCII Offset ; Apply offset to value in register A.
  MOV [D], A      ; D* = A           ; Put value in register A in memory location.
  INC D           ; D++              ; Increment memory location.
  RET

```