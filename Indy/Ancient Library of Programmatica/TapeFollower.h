#ifndef tapefollower_h
#define tapefollower_h

/*
	PID-like implementation of a tape follower, based on the PID_v1 library on the Arduino site. 
*/
class TapeFollower
{
	public:
	#define THRESHOLD 250
	#define BASE_SPEED 200 

		//commonly used functions **************************************************************************
		// Takes a pointer to the two sensor values, adjusts the output pointer
		TapeFollower(int*, int*, double*);

		double Compute();                       // * performs the PID calculation.  it should be
		//   called every time loop() cycles. ON/OFF and
		//   calculation frequency can be set using SetMode
		//   SetSampleTime respectively

		void setKp(double);
		void setKd(double);
		void setKi(double);

		void tune(double, double, double);


		/* Attachs a value to the Kp term*/
		void attach_Kp_To(double*);

		/* Attachs a value to the Kd term*/
		void attach_Kd_To(double*);

		/* Attachs a value to the Kd term*/
		void attach_Ki_To(double*);

		void SetSampleTime(int);              // * sets the frequency, in Milliseconds, with which 
		//   the PID calculation is performed.  default is 100

		void AutoSample();

		//Display functions ****************************************************************
		double GetKp();
		double GetKi();	
		double GetKd();



private:

	double* kp;                  // * (P)roportional Tuning Parameter
	double* ki;                  // * (I)ntegral Tuning Parameter
	double* kd;                  // * (D)erivative Tuning Parameter

	unsigned long lastTime;
	double ITerm, PTerm, DTerm, lastInput;

	int* leftInput;
	int* rightInput;
	double* Output;

	double error, lastError, lastError2, lastError3;

	int timeChange;

	int SampleTime;
	bool fixedSampleRate;
	double outMin, outMax;

	inline bool goingStraight();
	inline bool slightlyLeft();
	inline bool slightlyRight();
	inline bool tooMuchOnLeft();
	inline bool tooMuchOnRight();
	inline bool offTape();

	double calculateError();
};

#endif