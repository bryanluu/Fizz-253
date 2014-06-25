#include "WProgram.h"
#include "TapeFollower.h"
#include "StandardCalc.h"

TapeFollower::TapeFollower(int* leftInputVar, int* rightInputVar, double* output)
{
	leftInput = leftInputVar;
	rightInput = rightInputVar;

	fixedSampleRate = false;

	lastTime = millis() - SampleTime;
	lastError = 0.0;
}

double TapeFollower::Compute()
{
	timeChange = millis() - lastTime;

	if (fixedSampleRate == true && timeChange < SampleTime)
	{
		// Don't update the PID loop
		return *Output;
	} //Else, uses the time since last update to calculate PID

	// Error control
	double left = *leftInput;
	double right = *rightInput;

	error = calculateError();

	PTerm = *kp*(error);
	DTerm = *kd*(error - lastError) / timeChange;
	ITerm += *ki*(error)*timeChange;

	boundValueBetween(&ITerm, outMin, outMax);

	*Output = PTerm + DTerm + ITerm;



	// Output is useful for testing
	return *Output;
}

void TapeFollower::updateOldData()
{
	lastError3 = lastError2;
	lastError2 = lastError;
	lastError = error;
	lastTime = millis();
}

double TapeFollower::calculateError()
{
	double error;
	if (goingStraight())
	{
		error = 0.0;
	}
	else if (slightlyRight())
	{
		error = 1.0;
	}
	else if (slightlyLeft())
	{
		error = -1.0;
	}
	else if (tooMuchOnLeft())
	{
		error = -2.0;
	}
	else if (tooMuchOnRight())
	{
		error = 2.0;
	}
	return error;
}


inline bool TapeFollower::goingStraight()
{
	return (*leftInput >= THRESHOLD) && (*rightInput >= THRESHOLD + 50);
}

inline bool TapeFollower::slightlyLeft()
{
	return ((*leftInput < THRESHOLD) && (*rightInput > THRESHOLD + 50));
}

inline bool TapeFollower::slightlyRight()
{
	return ((*leftInput > THRESHOLD) && (*rightInput < THRESHOLD + 50));
}

inline bool TapeFollower::offTape()
{
	return ((*leftInput < THRESHOLD) && (*rightInput < THRESHOLD + 50));
}

inline bool TapeFollower::tooMuchOnLeft()
{
	return offTape() && (lastError >= 0 && lastError2 >= 0 && lastError3 >= 0);
}

inline bool TapeFollower::tooMuchOnRight()
{
	return offTape() && (lastError < 0 && lastError2 < 0 && lastError3 < 0);
}

void TapeFollower::attach_Kd_To(double* newKd)
{
	kd = newKd;
}

void TapeFollower::attach_Kp_To(double* newKp)
{
	kp = newKp;
}

void TapeFollower::attach_Ki_To(double* newKi)
{
	ki = newKi;
}

void TapeFollower::setKd(double newKd)
{
	*kd = newKd;
}

void TapeFollower::setKi(double newKi)
{
	*ki = newKi;
}

void TapeFollower::setKp(double newKp)
{
	*kp = newKp;
}

void TapeFollower::tune(double newKp, double newKi, double newKd)
{
	*kp = newKp;
	*ki = newKi;
	*kd = newKd;
}

void TapeFollower::SetSampleTime(int sampleTimeInMilliseconds)
{
	SampleTime = sampleTimeInMilliseconds;
	fixedSampleRate = true;
}

inline void TapeFollower::AutoSample() { fixedSampleRate = false; }

