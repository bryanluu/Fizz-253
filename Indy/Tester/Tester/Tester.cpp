// Tester.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <cppunit/CompilerOutputter.h>
#include <cppunit/extensions/TestFactoryRegistry.h>
#include <cppunit/ui/text/TestRunner.h>

//#ifdef _WIN32
//#include <Windows.h>
//#endif

using namespace std;

int main()
{
	// Get the top level suite from the registry
	CppUnit::Test *suite = CppUnit::TestFactoryRegistry::getRegistry().makeTest();

	// Adds the test to the list of test to run
	CppUnit::TextUi::TestRunner runner;
	runner.addTest(suite);

	// Change the default outputter to a compiler error format outputter
	runner.setOutputter(new CppUnit::CompilerOutputter(&runner.result(),
		std::cerr));

	cout << endl << "========== RUNNING TESTS ==========" << endl;

	// Run the tests.
	bool wasSucessful = runner.run();


	if (wasSucessful)
	{
		
		cout << "TESTS PASSED! FUCK YEAH" << endl;

//#ifdef _WIN32
//		cout << "Cue Indiana Jones Theme Song..." << endl;
//		PlaySound(TEXT("indi.wav"), NULL, SND_FILENAME);
//#endif
		cout << endl << "(Press Enter to Stop)" << endl;
	}
	else
	{
		cout << "TESTS FAILED..." << endl;
	}

	cin.get();

	return 0;
}

