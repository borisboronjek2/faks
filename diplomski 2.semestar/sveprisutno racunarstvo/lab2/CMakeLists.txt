idf_component_register(SRCS "VMA320.cpp" "CButton.cpp" "app_main.cpp" "DHT22.cpp" "VMA320.cpp"
                    PRIV_REQUIRES spi_flash
                    REQUIRES driver esp_timer
                    INCLUDE_DIRS "")
