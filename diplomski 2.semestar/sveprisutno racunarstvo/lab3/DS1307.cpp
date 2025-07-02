#include <stdio.h>
#include <driver/i2c.h>
#include <esp_log.h>
#include <freertos/FreeRTOS.h>
#include <freertos/task.h>
#include <lwip/sockets.h>
#include <time.h>

#include "DS1307.h"

#include "sdkconfig.h"

#define SDA_PIN 18
#define SCL_PIN 19
#define DS1307_ADDRESS 0x68
#define I2C_FREQ_HZ 400000

uint8_t intToDs1307Form(uint8_t num) {
	return ((num / 10) << 4) | (num % 10);
}

uint8_t ds1307FormToInt(uint8_t bcd) {
	return ((bcd >> 4) * 10) + (bcd & 0x0f);
}

void DS1307::initI2C() {
	i2c_config_t conf;
	conf.clk_flags = 0;
	conf.mode = I2C_MODE_MASTER;
	conf.sda_io_num = SDA_PIN;
	conf.scl_io_num = SCL_PIN;
	conf.sda_pullup_en = GPIO_PULLUP_ENABLE;
	conf.scl_pullup_en = GPIO_PULLUP_ENABLE;
	conf.master.clk_speed = I2C_FREQ_HZ;
	i2c_param_config(I2C_NUM_0, &conf);
	i2c_driver_install(I2C_NUM_0, I2C_MODE_MASTER, 0, 0, 0);
}

time_t DS1307::readValue() {
	i2c_cmd_handle_t cmd = i2c_cmd_link_create();
	i2c_master_start(cmd);
	i2c_master_write_byte(cmd, (DS1307_ADDRESS << 1) | I2C_MASTER_WRITE, 1);
	i2c_master_write_byte(cmd, 0x0, 1);
	i2c_master_start(cmd);
	i2c_master_write_byte(cmd, (DS1307_ADDRESS << 1) | I2C_MASTER_READ, 1);
	uint8_t data[7];
	i2c_master_read(cmd, data, 7, I2C_MASTER_LAST_NACK);
	i2c_master_stop(cmd);
	i2c_master_cmd_begin(I2C_NUM_0, cmd, 1000/portTICK_PERIOD_MS);
	i2c_cmd_link_delete(cmd);

	struct tm tm;
	tm.tm_sec  = ds1307FormToInt(data[0]);
	tm.tm_min  = ds1307FormToInt(data[1]);
	tm.tm_hour = ds1307FormToInt(data[2]);
	tm.tm_mday = ds1307FormToInt(data[4]);
	tm.tm_mon  = ds1307FormToInt(data[5]) - 1;
	tm.tm_year = ds1307FormToInt(data[6]) + 100;
	time_t readTime = mktime(&tm);

	return readTime;
}

void DS1307::writeValue(time_t newTime) {
	struct tm tm;
	gmtime_r(&newTime, &tm);

	i2c_cmd_handle_t cmd = i2c_cmd_link_create();
	i2c_master_start(cmd);
	i2c_master_write_byte(cmd, (DS1307_ADDRESS << 1) | I2C_MASTER_WRITE, 1);
	i2c_master_write_byte(cmd, 0x0, 1);
	i2c_master_write_byte(cmd, intToDs1307Form(tm.tm_sec), 1);
	i2c_master_write_byte(cmd, intToDs1307Form(tm.tm_min), 1);
	i2c_master_write_byte(cmd, intToDs1307Form(tm.tm_hour), 1);
	i2c_master_write_byte(cmd, intToDs1307Form(tm.tm_wday+1), 1);
	i2c_master_write_byte(cmd, intToDs1307Form(tm.tm_mday), 1);
	i2c_master_write_byte(cmd, intToDs1307Form(tm.tm_mon+1), 1);
	i2c_master_write_byte(cmd, intToDs1307Form(tm.tm_year-100), 1);
	i2c_master_stop(cmd);
	i2c_master_cmd_begin(I2C_NUM_0, cmd, 1000/portTICK_PERIOD_MS);
	i2c_cmd_link_delete(cmd);
}

void DS1307::readSpecificRegister(uint8_t reg){
	if(reg > 0x06){
		printf("Vrijednost registra nije podržana\n");
		return;
	}

	i2c_cmd_handle_t cmd = i2c_cmd_link_create();
	i2c_master_start(cmd);
	i2c_master_write_byte(cmd, (DS1307_ADDRESS << 1) | I2C_MASTER_WRITE, 1);
	i2c_master_write_byte(cmd, reg, 1);
	i2c_master_start(cmd);
	i2c_master_write_byte(cmd, (DS1307_ADDRESS << 1) | I2C_MASTER_READ, 1);
	uint8_t data;
	i2c_master_read_byte(cmd, &data, I2C_MASTER_LAST_NACK);
	i2c_master_stop(cmd);
	i2c_master_cmd_begin(I2C_NUM_0, cmd, 1000/portTICK_PERIOD_MS);
	i2c_cmd_link_delete(cmd);

	int time_value = ds1307FormToInt(data);

	switch (reg) {
		case 0x00:
			printf("Vrijednost registra sekundi: %d\n", time_value);
			return;
		case 0x01:
			printf("Vrijednost registra minuta: %d\n", time_value);
			return;
		case 0x02:
			printf("Vrijednost registra sata: %d\n", time_value);
			return;
		case 0x04:
			printf("Vrijednost registra dana u mjesecu: %d\n", time_value);
			return;
		case 0x05:
			printf("Vrijednost registra mjeseca: %d\n", time_value);
			return;
		case 0x06:
			printf("Vrijednost registra godine: %d\n", (2000 + time_value));
			return;
		default:
			printf("Nije moguće pristupiti registru: %x\n", reg);
	}
}

void DS1307::writeSpecificRegister(uint8_t reg, uint8_t value){
	switch (reg) {
		case 0x00:
			if(value > 59){
				printf("Vrijednost registra sekundi mora biti između 0 i 59\n");
				return;
			}
			break;
		case 0x01:
			if(value > 59){
				printf("Vrijednost registra minuta mora biti između 0 i 59\n");
				return;
			}
			break;
		case 0x02:
			if(value > 23){
				printf("Vrijednost registra sati mora biti između 0 i 23\n");
				return;
			}
			break;
		case 0x04:
			if(value > 31){
				printf("Vrijednost registra dana u mjesecu mora biti između 1 i 31\n");
				return;
			}
			break;
		case 0x05:
			if(value > 12){
				printf("Vrijednost registra mjeseca mora biti između 1 i 12\n");
				return;
			}
			break;
		case 0x06:
			if(value > 99){
				printf("Vrijednost registra godine mora biti između 0 i 99\n");
				return;
			}
			break;
		default:
			printf("Nije moguće postaviti vrijednost u registar: %x\n", reg);
			return;
	}

	int new_value = intToDs1307Form(value);

	i2c_cmd_handle_t cmd = i2c_cmd_link_create();
	i2c_master_start(cmd);
	i2c_master_write_byte(cmd, (DS1307_ADDRESS << 1) | I2C_MASTER_WRITE, 1);
	i2c_master_write_byte(cmd, reg, 1);
	i2c_master_write_byte(cmd, new_value, 1);
	i2c_master_stop(cmd);
	i2c_master_cmd_begin(I2C_NUM_0, cmd, 1000/portTICK_PERIOD_MS);
	i2c_cmd_link_delete(cmd);
}