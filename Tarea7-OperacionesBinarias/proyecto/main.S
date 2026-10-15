#include <avr/io.h>
.equ LED1,0
.equ LED2,1
.equ LED3,2
.equ SW1,2
.equ SW2,3

.section .text
.global main

main:
    sbi _SFR_IO_ADDR(DDRB), LED1
    sbi _SFR_IO_ADDR(DDRB), LED2
    sbi _SFR_IO_ADDR(DDRB), LED3
    cbi _SFR_IO_ADDR(DDRD), SW1
    cbi _SFR_IO_ADDR(DDRD), SW2
    sbi _SFR_IO_ADDR(PORTD), SW1
    sbi _SFR_IO_ADDR(PORTD), SW2

MAIN_LOOP:
    cbi _SFR_IO_ADDR(PORTB), LED2
    cbi _SFR_IO_ADDR(PORTB), LED3
    sbi _SFR_IO_ADDR(PORTB), LED1
    rcall DELAY
    cbi _SFR_IO_ADDR(PORTB), LED1
    cbi _SFR_IO_ADDR(PORTB), LED3
    sbi _SFR_IO_ADDR(PORTB), LED2
    rcall DELAY
    cbi _SFR_IO_ADDR(PORTB), LED1
    cbi _SFR_IO_ADDR(PORTB), LED2
    sbi _SFR_IO_ADDR(PORTB), LED3
    rcall DELAY
    cbi _SFR_IO_ADDR(PORTB), LED1
    cbi _SFR_IO_ADDR(PORTB), LED3
    sbi _SFR_IO_ADDR(PORTB), LED2
    rcall DELAY
    rjmp MAIN_LOOP

DELAY:
    in R21, _SFR_IO_ADDR(PIND)
    sbrs R21, SW1
    rjmp SW1_P
    sbrs R21, SW2
    rjmp SW2_P
    rjmp NORMAL

SW1_P:
    sbrs R21, SW2
    rjmp BOTH
    rjmp FAST

SW2_P:
    rjmp SLOW

BOTH:
    ldi R18, 0x20
    rjmp MEDIUM

FAST:
    ldi R18, 0x08
    rjmp FAST_LOOP

NORMAL:
    ldi R18, 0x10
    rjmp NORMAL_LOOP

SLOW:
    ldi R18, 0x30
    rjmp SLOW_LOOP

FAST_LOOP:
    in R21, _SFR_IO_ADDR(PIND)
    sbrc R21, SW1
    rjmp DELAY
    sbrc R21, SW2
    rjmp FAST_CONT
    rjmp DELAY
FAST_CONT:
    rcall D
    dec R18
    brne FAST_LOOP
    ret

NORMAL_LOOP:
    in R21, _SFR_IO_ADDR(PIND)
    sbrc R21, SW1
    rjmp NORMAL_SW2
    rjmp DELAY
NORMAL_SW2:
    sbrc R21, SW2
    rjmp NORMAL_CONT
    rjmp DELAY
NORMAL_CONT:
    rcall D
    dec R18
    brne NORMAL_LOOP
    ret

SLOW_LOOP:
    in R21, _SFR_IO_ADDR(PIND)
    sbrc R21, SW1
    rjmp SLOW_SW2
    rjmp DELAY
SLOW_SW2:
    sbrs R21, SW2
    rjmp SLOW_CONT
    rjmp DELAY
SLOW_CONT:
    rcall D
    dec R18
    brne SLOW_LOOP
    ret

D:
    ldi R19, 0xFF
D2:
    ldi R20, 0xFF
D3:
    dec R20
    brne D3
    dec R19
    brne D2
    ret