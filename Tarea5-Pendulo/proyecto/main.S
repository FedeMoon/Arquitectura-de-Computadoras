#
#include <avr/io.h>

.equ LED1, 0        ; PB0
.equ LED2, 1        ; PB1
.equ LED3, 2        ; PB2

.section .text
.global main

main:
    ; CONFIGURAR PB0, PB1 Y PB2 COMO SALIDAS
    sbi _SFR_IO_ADDR(DDRB), LED1
    sbi _SFR_IO_ADDR(DDRB), LED2
    sbi _SFR_IO_ADDR(DDRB), LED3

MAIN_LOOP:

    ; LED 1 -> PB0
    cbi _SFR_IO_ADDR(PORTB), LED2
    cbi _SFR_IO_ADDR(PORTB), LED3
    sbi _SFR_IO_ADDR(PORTB), LED1

    rcall DELAY

    ; LED 2 -> PB1
    cbi _SFR_IO_ADDR(PORTB), LED1
    cbi _SFR_IO_ADDR(PORTB), LED3
    sbi _SFR_IO_ADDR(PORTB), LED2

    rcall DELAY

    ; LED 3 -> PB2
    cbi _SFR_IO_ADDR(PORTB), LED1
    cbi _SFR_IO_ADDR(PORTB), LED2
    sbi _SFR_IO_ADDR(PORTB), LED3

    rcall DELAY

    ; LED 2 -> PB1
    cbi _SFR_IO_ADDR(PORTB), LED1
    cbi _SFR_IO_ADDR(PORTB), LED3
    sbi _SFR_IO_ADDR(PORTB), LED2

    rcall DELAY

    rjmp MAIN_LOOP


; RUTINA DE RETARDO RECONSTRUIDA
DELAY:
    ldi r20, 10

DELAY_OUTER:
    ldi r19, 255

DELAY_MIDDLE:
    ldi r18, 255

DELAY_INNER:
    dec r18
    brne DELAY_INNER

    dec r19
    brne DELAY_MIDDLE

    dec r20
    brne DELAY_OUTER

    ret
