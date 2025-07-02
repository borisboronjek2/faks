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
    lastPressTime = 0;
    lastState = gpio_get_level(m_pinNumber);
}

void CButton::tick() {
    int currentState = gpio_get_level(m_pinNumber);
    int64_t currentTime = esp_timer_get_time() / 1000;

    if (currentState != lastState) {    
        if (currentState == 0) {
            if (currentTime - lastPressTime < DOUBLE_CLICK_TIME) {  
                if (doubleClick) doubleClick();
                isSingleClickPending = false;
            } else {
                isSingleClickPending = true;  
                singleClickStartTime = currentTime;
            }
            lastPressTime = currentTime;  
        }
    } 
    
    if (currentState == 0 && isLongClickPending && (currentTime - lastPressTime) >= LONG_PRESS_TIME) {  
        if (longPress) longPress();
        isLongClickPending = false;
        isSingleClickPending = false;
    } 
    
    if (currentState == 1 && isSingleClickPending && (currentTime - singleClickStartTime) >= DOUBLE_CLICK_TIME) {
        if (singleClick) singleClick();
        isSingleClickPending = false;
    }

    if (currentState == 0 && (currentTime - lastPressTime) < LONG_PRESS_TIME && !isLongClickPending) {
        isLongClickPending = true;
    }

    lastState = currentState;
}
