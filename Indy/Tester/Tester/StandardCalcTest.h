#pragma once
#include <cppunit/extensions/HelperMacros.h>

class StandardCalcTest : public CppUnit::TestFixture
{
	CPPUNIT_TEST_SUITE(StandardCalcTest);
	//Insert new test methods here:
	CPPUNIT_TEST(testBoundValueMiddle);
	CPPUNIT_TEST(testBoundValueLower);
	CPPUNIT_TEST(testBoundValueHigher);

	CPPUNIT_TEST_SUITE_END();

public:
	void setUp();
	void tearDown();
	
	//Provide definitions for your test methods. Must be: void testName()
	void testBoundValueMiddle();
	void testBoundValueLower();
	void testBoundValueHigher();
};