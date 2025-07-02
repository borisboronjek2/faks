#ifndef DS1307_H
#define DS1307_H

#include <driver/i2c.h>
#include <esp_log.h>
#include <freertos/FreeRTOS.h>
#include <freertos/task.h>
#include <lwip/sockets.h>
#include <time.h>

#define SDA_PIN 18
#define SCL_PIN 19
#define DS1307_ADDRESS 0x68
#define I2C_FREQ_HZ 400000

class DS1307 {
public:
static void initI2C();
static time_t readValue();
static void writeValue(time_t newTime);
static void readSpecificRegister(uint8_t reg);
static void writeSpecificRegister(uint8_t reg, uint8_t value);
};

#endif