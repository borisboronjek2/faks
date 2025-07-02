#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"
#include "esp_log.h"
#include "sdkconfig.h"
#include "CLed.h"
#include "CButton.h"

static const char *TAG = "MAIN";

#define BUTTON_GPIO 2

void singlePressHandler() {
    ESP_LOGI(TAG, "Single press detected");
}

void doublePressHandler() {
    ESP_LOGI(TAG, "Double press detected");
}

void longPressHandler() {
    ESP_LOGI(TAG, "Long press detected");
}

void task_loop(void *parameters) {
    CButton *button = (CButton *)parameters;
    ESP_LOGI(TAG, "Start TASK Loop.");
    while (1) {
        button->tick();  
        vTaskDelay(10 / portTICK_PERIOD_MS);
    }
}

TaskHandle_t xHandle = NULL;

//ESP32 mian function
extern "C" void app_main(void) {
    ESP_LOGI(TAG, "Start MAIN.");
    
    CButton button(BUTTON_GPIO);
    button.attachSingleClick(singlePressHandler);
    button.attachDoubleClick(doublePressHandler);
    button.attachLongPress(longPressHandler);
    
    ESP_LOGI(TAG, "Start Task Create.");
    xTaskCreate(task_loop, "buttonLoop", 1024 * 2, (void *)&button, 1, &xHandle);
    ESP_LOGI(TAG, "Task Created.");

    while(1){

    }
}
