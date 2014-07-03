#include "stdafx.h"
#include "IndyPIDTest.h"

//Register as test class
CPPUNIT_TEST_SUITE_REGISTRATION(IndyPIDTest);

void IndyPIDTest::setUp()
{
	WProgram::sampleTime = 10;
	WProgram::time = 0;
}

void IndyPIDTest::tearDown()
{

}

void IndyPIDTest::testConstructor()
{
	double Input = 0;
	double Setpoint = 0;
	double Output = 0;
	PID controller(&Input, &Setpoint, &Output);

	CPPUNIT_ASSERT(controller.fixedSampleRate == false);
	CPPUNIT_ASSERT(controller.Input == &Input);
	CPPUNIT_ASSERT(controller.Setpoint == &Setpoint);
	CPPUNIT_ASSERT(controller.Output == &Output);
}

void IndyPIDTest::testTuning()
{
	double Input = 400;
	double Setpoint = 400;
	double Output = 0;
	PID controller(&Input, &Setpoint, &Output);


	controller.tune(0.5, 0, 0);
	CPPUNIT_ASSERT(controller.GetKp() == 0.5);
	CPPUNIT_ASSERT(controller.GetKi() == 0);
	CPPUNIT_ASSERT(controller.GetKd() == 0);


	double Kp = 1, Ki = -2, Kd = -3;

	controller.attach_Kp_To(&Kp);
	controller.attach_Ki_To(&Ki);
	controller.attach_Kd_To(&Kd);

	CPPUNIT_ASSERT(controller.GetKp() == 1);
	CPPUNIT_ASSERT(controller.GetKi() == -2);
	CPPUNIT_ASSERT(controller.GetKd() == -3);

	Ki = 2;
	Kd = 3;

	CPPUNIT_ASSERT(controller.GetKi() == 2);
	CPPUNIT_ASSERT(controller.GetKd() == 3);
}

void IndyPIDTest::testCalcError()
{
	double Input = 400;
	double Setpoint = 200;
	double Output = 0;
	PID controller(&Input, &Setpoint, &Output);

	// Overshoot = Negative Error
	CPPUNIT_ASSERT(controller.calculateError() == -200);

	Input = 100;

	// Undershoot = Positive Error
	CPPUNIT_ASSERT(controller.calculateError() == 100);

	Input = 200;

	// No error
	CPPUNIT_ASSERT(controller.calculateError() == 0);
}

void IndyPIDTest::testOutput()
{
	double Input = 200;
	double Setpoint = 200;
	double Output = 0;
	PID controller(&Input, &Setpoint, &Output);

	double Kp = 0.5, Ki = 0.2, Kd = 0.3;

	controller.attach_Kp_To(&Kp);
	controller.attach_Ki_To(&Ki);
	controller.attach_Kd_To(&Kd);

	controller.setBounds(-300, 300);

	WProgram::update();

	// Zero error

	controller.Compute();

	CPPUNIT_ASSERT(controller.GetError() == 0);
	CPPUNIT_ASSERT(controller.ITerm == 0);
	CPPUNIT_ASSERT(controller.timeChange == 10);

	// Test overshoot

	WProgram::update();

	CPPUNIT_ASSERT(millis() == 20);

	Input = 300;

	controller.Compute();

	CPPUNIT_ASSERT(controller.timeChange == 10);
	CPPUNIT_ASSERT(controller.error == -100);
	CPPUNIT_ASSERT(controller.lastError == 0);

	// PTerm = kp*(error), DTerm = kd*(error-lastError)/dt, ITerm = ITerm + ki*(error)*dt
	double expectedP = Kp * -100;
	double expectedI = 0 + Ki * -100 * 10;
	double expectedD = Kd * (-100 - 0) / 10.0;
	CPPUNIT_ASSERT(controller.PTerm == expectedP);
	CPPUNIT_ASSERT(controller.ITerm == expectedI);
	CPPUNIT_ASSERT(controller.DTerm == expectedD);

	double expected = expectedP + expectedI + expectedD;
	CPPUNIT_ASSERT(Output == expected);
	CPPUNIT_ASSERT(Output < 0);

	//////Compute again, with undershoot error

	Input = 100;

	WProgram::update();
	WProgram::update();

	controller.Compute();

	CPPUNIT_ASSERT(controller.timeChange == 20);
	CPPUNIT_ASSERT(controller.error == 100);
	CPPUNIT_ASSERT(controller.lastError == -100);

	// PTerm = kp*(error), DTerm = kd*(error-lastError)/dt, ITerm = ITerm + ki*(error)*dt
	expectedP = Kp * 100;
	expectedI = expectedI + Ki * 100 * 20;
	expectedD = Kd * (100 - -100) / 20.0;
	CPPUNIT_ASSERT(controller.PTerm == expectedP);
	CPPUNIT_ASSERT(controller.ITerm == expectedI);
	CPPUNIT_ASSERT(controller.DTerm == expectedD);

	expected = expectedP + expectedI + expectedD;
	CPPUNIT_ASSERT(Output == expected);
	CPPUNIT_ASSERT(Output > 0);
	
}

void IndyPIDTest::testOvershoot()
{
	double Input = 300;
	double Setpoint = 200;
	double Output = 0;
	PID controller(&Input, &Setpoint, &Output);

	double Kp = 0.5, Ki = 0.2, Kd = 0.3;

	controller.attach_Kp_To(&Kp);
	controller.attach_Ki_To(&Ki);
	controller.attach_Kd_To(&Kd);

	controller.setBounds(-50, 50);

	simulatePIDRunning(&controller, 300, 200, 10, 20);

	CPPUNIT_ASSERT(abs(Input - Setpoint) < 5);
}

void IndyPIDTest::testUndershoot()
{
	double Input = 100;
	double Setpoint = 200;
	double Output = 0;
	PID controller(&Input, &Setpoint, &Output);

	double Kp = 0.5, Ki = 0.2, Kd = 0.3;

	controller.attach_Kp_To(&Kp);
	controller.attach_Ki_To(&Ki);
	controller.attach_Kd_To(&Kd);

	controller.setBounds(-50, 50);

	simulatePIDRunning(&controller, 100, 200, 10, 20);

	CPPUNIT_ASSERT(abs(Input - Setpoint) < 5);
}

void IndyPIDTest::testJustRight()
{
	double Input = 100;
	double Setpoint = 200;
	double Output = 0;
	PID controller(&Input, &Setpoint, &Output);

	double Kp = 0.5, Ki = 0.2, Kd = 0.3;

	controller.attach_Kp_To(&Kp);
	controller.attach_Ki_To(&Ki);
	controller.attach_Kd_To(&Kd);

	controller.setBounds(-50, 50);

	simulatePIDRunning(&controller, 200, 200, 10, 20);

	CPPUNIT_ASSERT(abs(Input - Setpoint) < 5);
}

// This practically runs the PID loop. Beware of them pointers
void IndyPIDTest::mapOutputToInput(double* input, double* output)
{
	if (*output >= 0)
		*input += (*output*0.1)*(*output*0.01);
	else
		*input -= (*output*0.1)*(*output*0.01);
}

void IndyPIDTest::simulatePIDRunning(PID* controller, double input, double setpoint, int sampleTime, int loops)
{
	WProgram::time = sampleTime;
	WProgram::sampleTime = sampleTime;

	controller->lastError = 0;
	*controller->Input = input;
	*controller->Setpoint = setpoint;

	for (int i = 0; i < loops; i++)
	{
		controller->Compute();
		mapOutputToInput(controller->Input, controller->Output);
		//std::cout << "OUTPUT:" << *controller->Output << "\n";
		//std::cout << "INPUT:" << *controller->Input << "\n";
		WProgram::update();
	}
}