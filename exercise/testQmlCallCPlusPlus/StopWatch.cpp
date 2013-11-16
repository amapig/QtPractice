#include "StopWatch.h"

Stopwatch::Stopwatch() {
}

bool Stopwatch::isRunning() {
    return m_running;
}

void Stopwatch::start() {
    m_running = true;
}

void Stopwatch::stop() {
    m_running = false;
}
