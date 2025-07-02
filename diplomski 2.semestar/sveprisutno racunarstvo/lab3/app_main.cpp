#include <freertos/FreeRTOS.h>
#include <freertos/task.h>
#include <esp_log.h>
#include "DS1307.h"

static const char *TAG = "main";

extern "C" void app_main(void);

void rtc_task(void *pvParameter) {
    DS1307::initI2C();

    time_t now;
    struct tm t;
    t.tm_year = 2025 - 1900;
    t.tm_mon  = 0;
    t.tm_mday = 1;
    t.tm_hour = 0;
    t.tm_min  = 0;
    t.tm_sec  = 0;

    now = mktime(&t);
    DS1307::writeValue(now);

    time_t current1 = DS1307::readValue();
    struct tm timeinfo1;
    localtime_r(&current1, &timeinfo1);
    char buffer1[64];
    strftime(buffer1, sizeof(buffer1), "%c", &timeinfo1);
    ESP_LOGI(TAG, "Trenutno postavljeno vrijeme: %s\n", buffer1);
    
    vTaskDelay(pdMS_TO_TICKS(1000));
    
    // Demonstracija rada s registrima
    DS1307::writeSpecificRegister(0x00, 50);
    DS1307::writeSpecificRegister(0x01, 16);
    DS1307::writeSpecificRegister(0x02, 3);
    DS1307::writeSpecificRegister(0x04, 8);
    DS1307::writeSpecificRegister(0x05, 1);
    DS1307::writeSpecificRegister(0x06, 24);
    DS1307::writeSpecificRegister(0x10, 16);

    while (true) {
        time_t current = DS1307::readValue();
        struct tm timeinfo;
        localtime_r(&current, &timeinfo);
        char buffer[64];
        strftime(buffer, sizeof(buffer), "%c", &timeinfo);
        ESP_LOGI(TAG, "Trenutno vrijeme: %s", buffer);

        // Demonstracija rada s registrima
        DS1307::readSpecificRegister(0x00);
        DS1307::readSpecificRegister(0x01);
        DS1307::readSpecificRegister(0x02);
        DS1307::readSpecificRegister(0x04);
        DS1307::readSpecificRegister(0x05);
        DS1307::readSpecificRegister(0x06);

        vTaskDelay(pdMS_TO_TICKS(1000));
    }
}

extern "C" void app_main(void) {
    xTaskCreate(&rtc_task, "rtc_task", 4096, NULL, 5, NULL);
}
