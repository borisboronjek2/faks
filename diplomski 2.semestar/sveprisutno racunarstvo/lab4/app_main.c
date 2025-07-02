#include <stdio.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/timers.h"

#include "esp_log.h"
#include "nvs_flash.h"
#include "esp_nimble_hci.h"
#include "nimble/nimble_port.h"
#include "nimble/nimble_port_freertos.h"
#include "host/ble_hs.h"
#include "services/gap/ble_svc_gap.h"
#include "services/gatt/ble_svc_gatt.h"

static const char *TAG = "BLE_Server";

uint16_t counterBLE = 0;
static const char* readBLE = "0036531473";
uint8_t writeBLE = 1;

uint16_t notify_conn_handle = 0;
uint16_t notify_attr_handle = 0;
bool notifications_enabled = false;

// Callback za notifikacije
static int ble_notify_callback(uint16_t conn_handle, uint16_t attr_handle,
                             struct ble_gatt_access_ctxt *ctxt, void *arg) {
    return 0;
}

// Callback za citanje
static int ble_read_callback(uint16_t conn_handle, uint16_t attr_handle,
                             struct ble_gatt_access_ctxt *ctxt, void *arg) {
    os_mbuf_append(ctxt->om, readBLE, strlen(readBLE));
    return 0;
}

// Callback za pisanje
static int ble_write_callback(uint16_t conn_handle, uint16_t attr_handle,
                              struct ble_gatt_access_ctxt *ctxt, void *arg) {
    if (ctxt->om->om_len == 1) {
        uint8_t val = ctxt->om->om_data[0];
        if (val >= 1 && val <= 10) {
            writeBLE = val;
            ESP_LOGI(TAG, "writeBLE set to %d", writeBLE);
        } else {
            ESP_LOGW(TAG, "Invalid writeBLE value: %d", val);
        }
    }
    return 0;
}

// GATT servis i karakteristike
static const struct ble_gatt_svc_def gatt_svcs[] = {{
    .type = BLE_GATT_SVC_TYPE_PRIMARY,
    .uuid = BLE_UUID16_DECLARE(0x1473),
    .characteristics = (struct ble_gatt_chr_def[]) {{
        .uuid = BLE_UUID16_DECLARE(0x1474),
        .flags = BLE_GATT_CHR_F_NOTIFY,
        .access_cb = ble_notify_callback,
        .val_handle = &notify_attr_handle,
    }, {
        .uuid = BLE_UUID16_DECLARE(0x1475),
        .flags = BLE_GATT_CHR_F_READ,
        .access_cb = ble_read_callback,
    }, {
        .uuid = BLE_UUID16_DECLARE(0x1476),
        .flags = BLE_GATT_CHR_F_WRITE,
        .access_cb = ble_write_callback,
    }, {0}}
}, {0}};

uint8_t ble_addr_type;
void ble_app_advertise(void);

// GAP događaji
static int ble_gap_event(struct ble_gap_event *event, void *arg) {
    switch (event->type) {
        case BLE_GAP_EVENT_CONNECT:
            ESP_LOGI(TAG, "BLE_GAP_EVENT_CONNECT status=%d", event->connect.status);
            if (event->connect.status == 0) {
                notify_conn_handle = event->connect.conn_handle;
            } else {
                ble_app_advertise();
            }
            break;
        case BLE_GAP_EVENT_DISCONNECT:
            ESP_LOGI(TAG, "Disconnected; restarting advertising");
            notify_conn_handle = 0;
            ble_app_advertise();
            break;
        case BLE_GAP_EVENT_ADV_COMPLETE:
            ble_app_advertise();
            break;
        case BLE_GAP_EVENT_SUBSCRIBE:
            ESP_LOGI(TAG, "Subscribe event: conn_handle=%d, attr_handle=%d, cur_notify=%d",
                    event->subscribe.conn_handle,
                    event->subscribe.attr_handle,
                    event->subscribe.cur_notify);

            if (event->subscribe.attr_handle == notify_attr_handle) {
                notifications_enabled = event->subscribe.cur_notify;
                ESP_LOGI(TAG, "Notifications %s", notifications_enabled ? "ENABLED" : "DISABLED");
            }
            break;
        default:
            break;
    }
    return 0;
}

// Pokretanje oglašavanja
void ble_app_advertise(void) {
    struct ble_hs_adv_fields fields;
    memset(&fields, 0, sizeof(fields));

    const char *device_name = ble_svc_gap_device_name();
    fields.name = (uint8_t *)device_name;
    fields.name_len = strlen(device_name);
    fields.name_is_complete = 1;

    ble_gap_adv_set_fields(&fields);

    struct ble_gap_adv_params adv_params = {
        .conn_mode = BLE_GAP_CONN_MODE_UND,
        .disc_mode = BLE_GAP_DISC_MODE_GEN,
    };

    ble_gap_adv_start(ble_addr_type, NULL, BLE_HS_FOREVER, &adv_params, ble_gap_event, NULL);
}

// Callback nakon sinkronizacije
void ble_app_on_sync(void) {
    ble_hs_id_infer_auto(0, &ble_addr_type);
    ble_app_advertise();
}

// BLE host task
void host_task(void *param) {
    nimble_port_run();
    nimble_port_freertos_deinit();
}

void app_main(void) {
    nvs_flash_init();
    esp_nimble_hci_init();
    nimble_port_init();

    ble_svc_gap_device_name_set("BorisBoronjek");
    ble_svc_gap_init();
    ble_svc_gatt_init();

    ble_gatts_count_cfg(gatt_svcs);
    ble_gatts_add_svcs(gatt_svcs);

    ble_hs_cfg.sync_cb = ble_app_on_sync;

    nimble_port_freertos_init(host_task);

    while (1) {
        ESP_LOGI(TAG, "Counter: %d", (int)counterBLE);
        if (notifications_enabled) {
            struct os_mbuf *om = ble_hs_mbuf_from_flat(&counterBLE, sizeof(counterBLE));
            ble_gattc_notify_custom(notify_conn_handle, notify_attr_handle, om);
            ESP_LOGI(TAG, "Sent notify: counterBLE = %d", counterBLE);
        }

        vTaskDelay(1000 / portTICK_PERIOD_MS);
        counterBLE += writeBLE;
    }
}
