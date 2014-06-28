#include "stdafx.h"
#include "StandardCalcTest.h"
#include "StandardCalc.h"

// Registers the fixture into the 'registry'
CPPUNIT_TEST_SUITE_REGISTRATION(StandardCalcTest);

void StandardCalcTest::setUp()
{

}

void StandardCalcTest::tearDown()
{

}

void StandardCalcTest::testBoundValueMiddle()
{
	//Positive Test

	double lower = 0.0;
	double higher = 1.0;
	double value = 0.5;
	StandardCalc::boundValueBetween(&value, lower, higher);

	CPPUNIT_ASSERT(value >= lower);
	CPPUNIT_ASSERT(value <= higher);

	//Negative Test
	lower = -5.0;
	higher = 0.0;
	value = -0.5;

	StandardCalc::boundValueBetween(&value, lower, higher);

	CPPUNIT_ASSERT(value >= lower);
	CPPUNIT_ASSERT(value <= higher);
}

void StandardCalcTest::testBoundValueLower()
{
	//Positive Test

	double lower = 0.0;
	double higher = 1.0;
	double value = -0.5;
	StandardCalc::boundValueBetween(&value, lower, higher);

	CPPUNIT_ASSERT(value >= lower);
	CPPUNIT_ASSERT(value <= higher);

	//Negative Test
	lower = -5.0;
	higher = 0.0;
	value = -5.5;

	StandardCalc::boundValueBetween(&value, lower, higher);

	CPPUNIT_ASSERT(value >= lower);
	CPPUNIT_ASSERT(value <= higher);
}

void StandardCalcTest::testBoundValueHigher()
{
	//Positive Test

	double lower = 0.0;
	double higher = 1.0;
	double value = 1.5;
	StandardCalc::boundValueBetween(&value, lower, higher);

	CPPUNIT_ASSERT(value >= lower);
	CPPUNIT_ASSERT(value <= higher);

	//Negative Test
	lower = -5.0;
	higher = 0.0;
	value = 1.5;

	StandardCalc::boundValueBetween(&value, lower, higher);

	CPPUNIT_ASSERT(value >= lower);
	CPPUNIT_ASSERT(value <= higher);
}