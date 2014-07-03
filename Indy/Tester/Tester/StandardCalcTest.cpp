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
	double valueFixed = 0.5;

	StandardCalc::boundValueBetween(&value, lower, higher);

	CPPUNIT_ASSERT(value >= lower);
	CPPUNIT_ASSERT(value <= higher);

	double answer = StandardCalc::boundValueBetween(valueFixed, lower, higher);
	CPPUNIT_ASSERT(answer >= lower);
	CPPUNIT_ASSERT(answer <= higher);
	CPPUNIT_ASSERT(valueFixed == 0.5); // Test that valueFixed unchanged

	//Negative Test
	lower = -5.0;
	higher = 0.0;
	value = -0.5;
	valueFixed = -0.5;

	StandardCalc::boundValueBetween(&value, lower, higher);

	CPPUNIT_ASSERT(value >= lower);
	CPPUNIT_ASSERT(value <= higher);

	answer = StandardCalc::boundValueBetween(valueFixed, lower, higher);
	CPPUNIT_ASSERT(answer >= lower);
	CPPUNIT_ASSERT(answer <= higher);
	CPPUNIT_ASSERT(valueFixed == -0.5); // Test that valueFixed unchanged
}

void StandardCalcTest::testBoundValueLower()
{
	//Positive Test

	double lower = 0.0;
	double higher = 1.0;
	double value = -0.5;
	double valueFixed = -0.5;
	StandardCalc::boundValueBetween(&value, lower, higher);

	CPPUNIT_ASSERT(value == lower);

	double answer = StandardCalc::boundValueBetween(valueFixed, lower, higher);
	CPPUNIT_ASSERT(answer == lower);
	CPPUNIT_ASSERT(valueFixed == -0.5); // Test that valueFixed unchanged

	//Negative Test
	lower = -5.0;
	higher = 0.0;
	value = -5.5;
	valueFixed = -5.5;

	StandardCalc::boundValueBetween(&value, lower, higher);

	CPPUNIT_ASSERT(value == lower);

	answer = StandardCalc::boundValueBetween(valueFixed, lower, higher);
	CPPUNIT_ASSERT(answer == lower);
	CPPUNIT_ASSERT(valueFixed == -5.5); // Test that valueFixed unchanged
}

void StandardCalcTest::testBoundValueHigher()
{
	//Positive Test

	double lower = 0.0;
	double higher = 1.0;
	double value = 1.5;
	double valueFixed = 1.5;

	StandardCalc::boundValueBetween(&value, lower, higher);

	CPPUNIT_ASSERT(value == higher);

	double answer = StandardCalc::boundValueBetween(valueFixed, lower, higher);
	CPPUNIT_ASSERT(answer == higher);
	CPPUNIT_ASSERT(valueFixed == 1.5); // Test that valueFixed unchanged

	//Negative Test
	lower = -5.0;
	higher = 0.0;
	value = 1.5;
	valueFixed = 1.5;

	StandardCalc::boundValueBetween(&value, lower, higher);

	CPPUNIT_ASSERT(value == higher);

	answer = StandardCalc::boundValueBetween(valueFixed, lower, higher);
	CPPUNIT_ASSERT(answer == higher);
	CPPUNIT_ASSERT(valueFixed == 1.5); // Test that valueFixed unchanged
}