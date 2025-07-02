#ifndef _DHT22_h
#define _DHT22_h

class DHT22 {
    public:
        DHT22(int p);
        double temperature();

    private:
        gpio_num_t pin;
        int wait_for_state(int timeout, int state, int* duration);
        int wait_for_state(int timeout, int state);
};

#endif