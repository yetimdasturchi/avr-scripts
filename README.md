# avr-scripts
Collection of bash scripts for avr-gcc

Example code for testing:

```
#define F_CPU 16000000UL
#include <avr/io.h>
#include <util/delay.h>

void flip_flop() {
    static uint8_t state = 0;

    state = ~state;

    PORTB = (state & 0x01) << PORTB0 | (!(state & 0x01)) << PORTB1;
}

int main(void) {
    DDRB |= (1 << DDB0) | (1 << DDB1);

    while (1) {
        flip_flop();
        _delay_ms(500);
    }

    return 0;
}
```

Compiling code:

```bash
avr-gcc -mmcu=atmega328p -Os -o firmware.elf main.c
```

Using scripts:

```
./flash.sh firmware.elf
./ram_usage.sh firmware.elf
```
