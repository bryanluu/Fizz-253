#include "WProgram.h"

// Serves to simulate a Wiring Program
long millis()
{
	return WProgram::time;
}

long WProgram::time = 0;
long WProgram::sampleTime = 0;

void WProgram::update()
{
	time += sampleTime;
}