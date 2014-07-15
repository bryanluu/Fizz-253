#include "stdafx.h"
#include "TapeFollowerTest.h"
#include "TapeFollower.h"

//Register as test class
CPPUNIT_TEST_SUITE_REGISTRATION(TapeFollowerTest);

void TapeFollowerTest::setUp()
{
	WProgram::sampleTime = 10;
	WProgram::time = 0;
}

void TapeFollowerTest::tearDown()
{

}

void TapeFollowerTest::testConstructor()
{
	int Left = 0;
	int Mid = 0;
	int Right = 0;
	double Output = 0;
	TapeFollower controller(&Left, &Mid, &Right, &Output);

	CPPUNIT_ASSERT(controller.fixedSampleRate == false);
	CPPUNIT_ASSERT(controller.leftInput == &Left);
	CPPUNIT_ASSERT(controller.rightInput == &Right);
	CPPUNIT_ASSERT(controller.Output == &Output);
}

void TapeFollowerTest::testGoingStraight()
{
	int Left = 200;
	int Mid = 300;
	int Right = 200;
	double Output = 0;
	TapeFollower controller(&Left, &Mid, &Right, &Output);

	CPPUNIT_ASSERT(controller.goingStraight());

	controller.Compute();

	CPPUNIT_ASSERT(controller.error == 0);
}


void TapeFollowerTest::testOnLeft()
{
	int Left = 200;
	int Mid = 300;
	int Right = 300;
	double Output = 0;
	TapeFollower controller(&Left, &Mid, &Right, &Output);

	CPPUNIT_ASSERT(controller.slightlyLeft());

	controller.Compute();

	CPPUNIT_ASSERT(controller.error == -1);
}

void TapeFollowerTest::testMoreLeft()
{
	int Left = 200;
	int Mid = 200;
	int Right = 300;
	double Output = 0;
	TapeFollower controller(&Left, &Mid, &Right, &Output);

	CPPUNIT_ASSERT(controller.moreLeft());

	controller.Compute();

	CPPUNIT_ASSERT(controller.error == -2);
}

void TapeFollowerTest::testOnRight()
{
	int Left = 300;
	int Mid = 300;
	int Right = 200;
	double Output = 0;
	TapeFollower controller(&Left, &Mid, &Right, &Output);

	CPPUNIT_ASSERT(controller.slightlyRight());

	controller.Compute();

	CPPUNIT_ASSERT(controller.error == 1);
}

void TapeFollowerTest::testMoreRight()
{
	int Left = 300;
	int Mid = 200;
	int Right = 200;
	double Output = 0;
	TapeFollower controller(&Left, &Mid, &Right, &Output);

	CPPUNIT_ASSERT(controller.moreRight());

	controller.Compute();

	CPPUNIT_ASSERT(controller.error == 2);
}

void TapeFollowerTest::testOffTape()
{
	int Left = 200;
	int Mid = 200;
	int Right = 200;
	double Output = 0;
	TapeFollower controller(&Left, &Mid, &Right, &Output);

	CPPUNIT_ASSERT(controller.offTape());

	controller.Compute();

	CPPUNIT_ASSERT(controller.error == controller.lastError);
	CPPUNIT_ASSERT(controller.error == 0);
}


void TapeFollowerTest::testTooLeft()
{
	int Left = 200;
	int Mid = 300;
	int Right = 300;
	double Output = 0;
	TapeFollower controller(&Left, &Mid, &Right, &Output);


	CPPUNIT_ASSERT(controller.slightlyLeft());

	controller.Compute();

	CPPUNIT_ASSERT(controller.error == -1);

	Left = 100;
	Mid = 100;
	Right = 300;

	controller.Compute();

	CPPUNIT_ASSERT(controller.error == -2);

	Right = 100;

	controller.Compute();

	CPPUNIT_ASSERT(controller.lastError < 0);
	CPPUNIT_ASSERT(controller.error == -3);

}

void TapeFollowerTest::testTooRight()
{
	int Left = 300;
	int Mid = 300;
	int Right = 200;
	double Output = 0;
	TapeFollower controller(&Left, &Mid, &Right, &Output);


	CPPUNIT_ASSERT(controller.slightlyRight());

	controller.Compute();

	CPPUNIT_ASSERT(controller.error == 1);

	Left = 300;
	Mid = 100;
	Right = 100;

	controller.Compute();

	CPPUNIT_ASSERT(controller.error == 2);

	Left = 100;

	controller.Compute();

	CPPUNIT_ASSERT(controller.lastError > 0);
	CPPUNIT_ASSERT(controller.error == 3);

}

void TapeFollowerTest::testTuning()
{
	int Left = 400;
	int Mid = 400;
	int Right = 400;
	double Output = 0;
	TapeFollower controller(&Left, &Mid, &Right, &Output);


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

void TapeFollowerTest::testOutput()
{
	// Setup
	int Left = 100;
	int Mid = 400;
	int Right = 100;
	double Output = 0;
	TapeFollower controller(&Left, &Mid, &Right, &Output);

	double Kp = 1, Ki = 2, Kd = 3;

	controller.attach_Kp_To(&Kp);
	controller.attach_Ki_To(&Ki);
	controller.attach_Kd_To(&Kd);


	WProgram::update();

	CPPUNIT_ASSERT(millis() == 10);
	CPPUNIT_ASSERT(controller.goingStraight());
	
	//Error is 0 so Output shouldn't change
	controller.Compute();
	CPPUNIT_ASSERT(Output == 0);

	CPPUNIT_ASSERT(controller.timeChange == 10);
	CPPUNIT_ASSERT(controller.error == 0);
	CPPUNIT_ASSERT(controller.lastError == 0);
	CPPUNIT_ASSERT(controller.ITerm == 0);

	/////Correcting from left

	WProgram::update(); //Add 100 ms onto the 'clock'

	CPPUNIT_ASSERT(millis() == 20);

	Left = 100;
	Mid = 400;
	Right = 400;

	CPPUNIT_ASSERT(controller.slightlyLeft());

	controller.Compute();

	CPPUNIT_ASSERT(controller.timeChange == 10);
	CPPUNIT_ASSERT(controller.error == -1);
	CPPUNIT_ASSERT(controller.lastError == 0);

	// PTerm = kp*(error), DTerm = kd*(error-lastError)/dt, ITerm = ITerm + ki*(error)*dt
	double expectedP = Kp * -1;
	double expectedI = 0 + Ki * -1 * 10;
	double expectedD = Kd * (-1 - 0) / 10.0;
	CPPUNIT_ASSERT(controller.PTerm == expectedP);
	CPPUNIT_ASSERT(controller.ITerm == expectedI);
	CPPUNIT_ASSERT(controller.DTerm == expectedD);

	double expected = expectedP + expectedI + expectedD;
	CPPUNIT_ASSERT(Output == expected);

	//////Compute again, with right side error

	Left = 300;
	Mid = 400;
	Right = 100;

	WProgram::update();
	WProgram::update();

	CPPUNIT_ASSERT(controller.slightlyRight());

	controller.Compute();

	CPPUNIT_ASSERT(controller.timeChange == 20);
	CPPUNIT_ASSERT(controller.error == 1);
	CPPUNIT_ASSERT(controller.lastError == -1);

	// PTerm = kp*(error), DTerm = kd*(error-lastError)/dt, ITerm = ITerm + ki*(error)*dt
	expectedP = Kp * 1;
	expectedI = expectedI + Ki * 1 * 20;
	expectedD = Kd * (1 - -1) / 20.0;
	CPPUNIT_ASSERT(controller.PTerm == expectedP);
	CPPUNIT_ASSERT(controller.ITerm == expectedI);
	CPPUNIT_ASSERT(controller.DTerm == expectedD);

	expected = expectedP + expectedI + expectedD;
	CPPUNIT_ASSERT(Output == expected);
	

}

