#pragma once

#include <cppunit/extensions/HelperMacros.h>
#include "IndyPID.h"

class IndyPIDTest : public CppUnit::TestFixture
{

	CPPUNIT_TEST_SUITE(IndyPIDTest);

	//Add your test methods here
	CPPUNIT_TEST(testConstructor);
	CPPUNIT_TEST(testTuning);
	CPPUNIT_TEST(testCalcError);
	CPPUNIT_TEST(testOutput);
	CPPUNIT_TEST(testOvershoot);
	CPPUNIT_TEST(testUndershoot);
	CPPUNIT_TEST(testJustRight);

	CPPUNIT_TEST_SUITE_END();


public:
	void setUp();
	void tearDown();
	void testConstructor();

	void testTuning();
	void testCalcError();
	void testOutput();

	// Testing the PID running
	void testOvershoot();
	void testUndershoot();
	void testJustRight();

	//Makes a closed loop by modifying the input based on the output from a PID. This is just a model for testing. Can be any function
	void mapOutputToInput(double* input, double* output);

	void simulatePIDRunning(PID* controller, double input, double setpoint, int sampleTime, int loops);
};
