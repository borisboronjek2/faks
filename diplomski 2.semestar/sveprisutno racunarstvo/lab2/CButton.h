// CButton.h

#ifndef _CButton_h
#define _CButton_h

#include "driver/gpio.h"

 
// Pointer to event handling methods
extern "C" {
    typedef void (*ButtonEventHandler)(void);
}

class CButton{
    public:
        CButton(int port);
        void attachSingleClick(ButtonEventHandler method){singleClick = method;};
        void tick();

    private:
        ButtonEventHandler singleClick = NULL;
        gpio_num_t m_pinNumber;
        bool isSingleClickPending = false;
};


#endif