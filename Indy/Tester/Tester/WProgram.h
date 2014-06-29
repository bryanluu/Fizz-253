// Allows compile without error. It simulates the Wiring IDE environment.
#ifndef WProgram_h
#define WProgram_h
#define TESTING 1

long millis();

class WProgram
{
public:
	// Represents the elapsed time in millis.
	static long time;
	friend long millis();
	static long sampleTime;
	static void update();
};

#endif
