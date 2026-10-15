#include <avr/io.h>

.section .text
.global main

main:
    ldi r16, 0x10 ; Carga 0x10 (16 en decimal) a r16
    ldi r17, 0x20 ; Carga 0x20 (32 en decimal) a r17

    add r16, r17 ; Sumamos los registros anteriores 

MAIN_LOOP:

    rjmp MAIN_LOOP