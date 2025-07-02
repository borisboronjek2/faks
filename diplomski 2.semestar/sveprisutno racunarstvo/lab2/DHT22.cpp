#include <stdio.h>

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"
#include "esp_log.h"

#include "DHT22.h"

DHT22::DHT22(int port) {
    pin = (gpio_num_t)port;
    gpio_reset_pin(pin);
}

#define DHT_INTERVAL 2

int DHT22::wait_for_state(int timeout, int state, int* duration) {
    for (int i = 0; i < timeout; i += DHT_INTERVAL) {
        esp_rom_delay_us(DHT_INTERVAL);

        if (gpio_get_level(pin) == state) {
            if (duration)
                *duration = i;

            return 1;
        }
    }

    return 0;
}

int DHT22::wait_for_state(int timeout, int state) {
    return wait_for_state(timeout, state, NULL);
}

portMUX_TYPE mux = portMUX_INITIALIZER_UNLOCKED;
#define ENTER_CRITICAL() portENTER_CRITICAL(&mux)
#define EXIT_CRITICAL() portEXIT_CRITICAL(&mux)

double DHT22::temperature() {
    gpio_set_direction(pin, GPIO_MODE_OUTPUT_OD);
    gpio_set_level(pin, 1);

    ENTER_CRITICAL();

        // Phase A
        gpio_set_level(pin, 0);
        esp_rom_delay_us(20000);
        gpio_set_level(pin, 1);

        // Phase B
        gpio_set_direction(pin, GPIO_MODE_INPUT);
        wait_for_state(40, 0);

        // Phase C
        wait_for_state(88, 1);

        // Phase D
        wait_for_state(88, 0);

        // Read data
        uint8_t data[5];

        for (int i = 0; i < 40; i++) {
            int lo, hi;
            wait_for_state(65, 1, &lo);
            wait_for_state(75, 0, &hi);

            uint8_t b = i / 8;
            uint8_t m = i % 8;

            if (m == 0)
                data[b] = 0;
                
            data[b] |= (hi > lo) << (7 - m);
        }

    EXIT_CRITICAL();

    gpio_set_direction(pin, GPIO_MODE_OUTPUT_OD);
    gpio_set_level(pin, 1);

    int16_t temp = (data[2] & 0x7F) << 8 | data[3];
    if (data[2] & 0x80)
        temp = -temp;

    return temp / 10.0;
}