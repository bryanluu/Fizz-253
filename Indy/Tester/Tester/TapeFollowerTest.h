#pragma once

#include <cppunit/extensions/HelperMacros.h>

class TapeFollowerTest : public CppUnit::TestFixture
{
	
	CPPUNIT_TEST_SUITE(TapeFollowerTest);

	//Add your test methods here
	CPPUNIT_TEST(testConstructor);
	CPPUNIT_TEST(testGoingStraight);
	CPPUNIT_TEST(testOnLeft);
	CPPUNIT_TEST(testOnRight);
	CPPUNIT_TEST(testMoreLeft);
	CPPUNIT_TEST(testMoreRight);
	CPPUNIT_TEST(testOffTape);
	CPPUNIT_TEST(testTooLeft);
	CPPUNIT_TEST(testTooRight);
	CPPUNIT_TEST(testTuning);
	CPPUNIT_TEST(testOutput);

	CPPUNIT_TEST_SUITE_END();


public:
	void setUp();
	void tearDown();
	void testConstructor();

	//Testing error calcs
	void testGoingStraight();
	void testOnLeft();
	void testOnRight();
	void testMoreLeft();
	void testMoreRight();
	void testOffTape();
	void testTooLeft();
	void testTooRight();


	void testTuning();
	void testOutput();
};

