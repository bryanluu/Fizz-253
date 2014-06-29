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
	CPPUNIT_TEST(testTooLeft);
	CPPUNIT_TEST(testTooRight);

	CPPUNIT_TEST_SUITE_END();


public:
	void setUp();
	void tearDown();
	void testConstructor();
	void testGoingStraight();
	void testOnLeft();
	void testOnRight();
	void testTooLeft();
	void testTooRight();
};

