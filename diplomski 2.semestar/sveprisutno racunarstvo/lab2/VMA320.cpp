#include <stdio.h>
#include <math.h>

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"
#include "esp_log.h"
#include "driver/adc.h"

#include "VMA320.h"

VMA320::VMA320(adc1_channel_t c) {
    channel = c;
    adc1_config_width(ADC_WIDTH_BIT_12);
    adc1_config_channel_atten(channel, ADC_ATTEN_DB_0);
}

double VMA320::temperature() {
    int adc_raw = adc1_get_raw(channel);
    float Vout = ((float)adc_raw / 4095.0) * 3.3;
    float R_ntc = 10000 * Vout / (3.3 - Vout);
    float tempK = 1.0 / ((1.0 / 298.15) + (1.0 / 3950.0) * log(R_ntc / 10000.0));

    return (double)tempK - 273.15;
}