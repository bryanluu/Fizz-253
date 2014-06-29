#include "WProgram.h"

// Serves to simulate a Wiring Program
long millis()
{
	return WProgram::time;
}

long WProgram::time = 0;