// Allows compile without error. Not useful for anything
#ifndef WProgram_h
#define WProgram_h

long time = 0;
long millis();
//Useful for testing
void setTime(long);

long millis() { return time; }

void setTime(long newTime) { time = newTime; }

#endif
