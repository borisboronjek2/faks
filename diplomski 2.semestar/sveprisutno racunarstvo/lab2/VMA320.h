#ifndef _VMA320_h
#define _VMA320_h

class VMA320 {
    public:
        VMA320(adc1_channel_t channel);
        double temperature();
    
    private:
        adc1_channel_t channel;
};

#endif