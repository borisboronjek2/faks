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
        void attachDoubleClick(ButtonEventHandler method){doubleClick = method;};
        void attachLongPress(ButtonEventHandler method){longPress = method;};

        void tick();

    private:
        ButtonEventHandler singleClick = NULL;
        ButtonEventHandler doubleClick = NULL;
        ButtonEventHandler longPress = NULL;
        gpio_num_t m_pinNumber;
        int64_t lastPressTime = 0;
        int lastState = 1;
        bool isLongClickPending = true;
        bool isSingleClickPending = false;
        int64_t singleClickStartTime = 0;
};


#endif