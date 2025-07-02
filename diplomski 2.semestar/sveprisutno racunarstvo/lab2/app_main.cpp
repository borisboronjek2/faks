#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"
#include "esp_log.h"
#include "sdkconfig.h"
#include "driver/adc.h"
#include "CButton.h"
#include "DHT22.h"
#include "VMA320.h"

static const char *TAG = "MAIN";

#define BUTTON_GPIO 2
#define DHT_GPIO 4
#define ADC_PIN ADC1_CHANNEL_6

DHT22 dht22(DHT_GPIO);
VMA320 vma320(ADC_PIN);

void singlePressHandler() {
    ESP_LOGI(TAG, "DHT temperature: %5.1lf°C ", (dht22).temperature());
    ESP_LOGI(TAG, "VMA320 temperature: %5.1lf°C ", (vma320).temperature());
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
    
    ESP_LOGI(TAG, "Start Task Create.");
    xTaskCreate(task_loop, "buttonLoop", 1024 * 2, (void *)&button, 1, &xHandle);
    ESP_LOGI(TAG, "Task Created.");

    while(1){
        vTaskDelay(1000 / portTICK_PERIOD_MS);
    }
}
