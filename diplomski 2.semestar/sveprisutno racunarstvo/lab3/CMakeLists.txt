idf_component_register(SRCS "DS1307.cpp" "app_main.cpp"
                    PRIV_REQUIRES spi_flash
                    REQUIRES driver esp_timer
                    INCLUDE_DIRS "")
