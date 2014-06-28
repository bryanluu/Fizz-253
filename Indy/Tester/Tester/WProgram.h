// Allows compile without error. It simulates the Wiring IDE environment.
#ifndef WProgram_h
#define WProgram_h

long millis();

class WProgram
{
public:
	// Represents the elapsed time in millis.
	static long time;
	friend long millis();
};

#endif