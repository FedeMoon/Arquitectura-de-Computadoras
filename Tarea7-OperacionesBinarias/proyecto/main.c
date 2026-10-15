#include <avr/io.h>
#include <util/delay.h>
#include <stdint.h>
void mostrar_resultado(uint8_t valor) {
// Apagar los 4 LEDs antes de colocar el nuevo resultado
PORTB &= ~((1 << PORTB0) | (1 << PORTB1) | (1 <<
PORTB2));
PORTC &= ~(1 << PORTC1);
// bit 3 -> LED 1 -> PB2 -> valor 8
if (valor & (1 << 3)) {
PORTB |= (1 << PORTB2);
}
// bit 2 -> LED 2 -> PB1 -> valor 4
if (valor & (1 << 2)) {
PORTB |= (1 << PORTB1);
}
// bit 1 -> LED 3 -> PC1 -> valor 2
if (valor & (1 << 1)) {
PORTC |= (1 << PORTC1);
}
// bit 0 -> LED 4 -> PB0 -> valor 1
if (valor & (1 << 0)) {
PORTB |= (1 << PORTB0);
}
}
int main(void) {
uint8_t lectura;
uint8_t nibble1;
uint8_t nibble2;
uint8_t resultado;
// Configuracion de entradas
// PD0 - PD7 como entradas
DDRD &= ~((1 << DDD0) | (1 << DDD1) | (1 << DDD2)
| (1 << DDD3) | (1 << DDD4) | (1 << DDD5) | (1 << DDD6)
| (1 << DDD7));
// Pull-up internos para los DIP switches
PORTD |= ((1 << PORTD0) | (1 << PORTD1) | (1 <<
PORTD2) | (1 << PORTD3) | (1 << PORTD4) | (1 <<
PORTD5) | (1 << PORTD6) | (1 << PORTD7));
// Configuracion de salidas
DDRB |= ((1 << DDB0) | (1 << DDB1) | (1 << DDB2));
DDRC |= (1 << DDC1);
// Apagar los LEDs inicialmente
PORTB &= ~((1 << PORTB0) | (1 << PORTB1) | (1 <<
PORTB2));
PORTC &= ~(1 << PORTC1);
while (1) {
// LEER LOS 8 DIP SWITCHES
// Se invierten porque estamos usando pull-up
// DIP ON -> 1
// DIP OFF -> 0
lectura = (uint8_t)(~PIND);
//
====================================
=================
// FORMAR NIBBLE 1
//
// DIP 1 -> PD7 -> bit 3 -> 8
// DIP 2 -> PD6 -> bit 2 -> 4
// DIP 3 -> PD5 -> bit 1 -> 2
// DIP 4 -> PD4 -> bit 0 -> 1
//
====================================
=================
nibble1 = (lectura >> 4) & 0x0F;
//
====================================
=================
// FORMAR NIBBLE 2
//
// DIP 5 -> PD3 -> bit 3 -> 8
// DIP 6 -> PD2 -> bit 2 -> 4
// DIP 7 -> PD1 -> bit 1 -> 2
// DIP 8 -> PD0 -> bit 0 -> 1
//
====================================
=================
nibble2 = lectura & 0x0F;
// AND
resultado = nibble1 & nibble2;
mostrar_resultado(resultado);
_delay_ms(500);
// OR
resultado = nibble1 | nibble2;
mostrar_resultado(resultado);
_delay_ms(500);
// XOR
resultado = nibble1 ^ nibble2;
mostrar_resultado(resultado);
_delay_ms(500);
}
return 0;
}