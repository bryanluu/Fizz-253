#include "WProgram.h"

long millis()
{
	return WProgram::time;
}

long WProgram::time = 0;