idf_component_register(SRCS "app_main.c"
                    PRIV_REQUIRES spi_flash bt
                    REQUIRES driver esp_timer esp_event nvs_flash bt
                    INCLUDE_DIRS "")
