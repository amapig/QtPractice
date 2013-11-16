#include "TimeModule.h"

int TimeModel::hour() {
    return mHour;
}

int TimeModel::minute() {
    return mMinute;
}

void TimeModel::writeHour(int hour) {
    printf("Enter writeHour");
    mHour = hour;
    timeChanged();
    printf("Leave writeHour");
}
