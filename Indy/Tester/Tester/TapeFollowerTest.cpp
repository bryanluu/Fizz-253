#include "stdafx.h"
#include "TapeFollowerTest.h"
#include "TapeFollower.h"

//Register as test class
CPPUNIT_TEST_SUITE_REGISTRATION(TapeFollowerTest);

void TapeFollowerTest::setUp()
{
}

void TapeFollowerTest::tearDown()
{

}

void TapeFollowerTest::testConstructor()
{
	int Left = 0;
	int Right = 0;
	double Output = 0;
	TapeFollower controller(&Left, &Right, &Output);

	CPPUNIT_ASSERT(controller.fixedSampleRate == false);
	CPPUNIT_ASSERT(controller.leftInput == &Left);
	CPPUNIT_ASSERT(controller.rightInput == &Right);
	CPPUNIT_ASSERT(controller.Output == &Output);
}

void TapeFollowerTest::testGoingStraight()
{
	int Left = 300;
	int Right = 300;
	double Output = 0;
	TapeFollower controller(&Left, &Right, &Output);

	CPPUNIT_ASSERT(controller.goingStraight());

	controller.Compute();

	CPPUNIT_ASSERT(controller.error == 0);
}


void TapeFollowerTest::testOnLeft()
{
	int Left = 200;
	int Right = 300;
	double Output = 0;
	TapeFollower controller(&Left, &Right, &Output);

	CPPUNIT_FAIL("Not implemented yet!");
}


void TapeFollowerTest::testOnRight()
{
	int Left = 300;
	int Right = 300;
	double Output = 0;
	TapeFollower controller(&Left, &Right, &Output);


	CPPUNIT_FAIL("Not implemented yet!");
}


void TapeFollowerTest::testTooLeft()
{
	int Left = 300;
	int Right = 300;
	double Output = 0;
	TapeFollower controller(&Left, &Right, &Output);

	CPPUNIT_FAIL("Not implemented yet!");
}

void TapeFollowerTest::testTooRight()
{
	int Left = 300;
	int Right = 300;
	double Output = 0;
	TapeFollower controller(&Left, &Right, &Output);

	CPPUNIT_FAIL("Not implemented yet!");
}

