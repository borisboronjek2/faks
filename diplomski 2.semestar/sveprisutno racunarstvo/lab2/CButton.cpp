#include <stdio.h>
#include "CButton.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"
#include "esp_timer.h"
#include "esp_log.h"

#define DOUBLE_CLICK_TIME 200
#define LONG_PRESS_TIME 1000

CButton::CButton(int port){
    m_pinNumber = (gpio_num_t)port;
    gpio_reset_pin(m_pinNumber);
    gpio_set_direction(m_pinNumber, GPIO_MODE_INPUT);
    gpio_set_pull_mode(m_pinNumber, GPIO_PULLUP_ONLY);
}

void CButton::tick() {
    int currentState = gpio_get_level(m_pinNumber);
    
    if (currentState == 0 && isSingleClickPending) {
        if (singleClick) singleClick();
        isSingleClickPending = false;
    }

    if(currentState == 1){
        isSingleClickPending = true;
    }
}
