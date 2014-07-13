Fizz-253
========

This is the repository for the ENPH 253 Project: with Kevin Multani, Conrad Ng, Ben Mattison, and Bryan Luu.

Review the [Formal Design Proposal](https://docs.google.com/document/d/1q06k26zPwGevnf89LMePSkt6SWfdHpj5Fj2V4FfkRks/edit?usp=sharing) for extensive information about the design of our robot, nicknamed, **Indy**.

##Code Layout
The software running on Indy is based on a set of states, i.e. the entire challenge can be represented as a State Machine, as seen [here](https://docs.google.com/drawings/d/1rsqjhkMKMphdVeLp2xqcCqEwv0UXkT4nKh5W3wi09UA/edit). The stages of the competition, and thus the main states of Indy's logic, are:

1. **TAPE_FOLLOW**
2. **COLLECT_ITEM**
3. **CLIMB_HILL**
4. **ROCKPIT**
5. **ESCAPE**

Each of these represents a major goal for Indy throughout the competition. First, Indy must navigate the Temple of the Zipline by following tape and collecting artifacts. This includes a strenous hill climb to reach the level of the Idol. Next, Indy must brave the rockpit by aiming towards the *Eye of the Idol*, a 10kHz IR Beacon. Once Indy crosses the rockpit, he must then carefully retrieve the final Idol. Finally, Indy will pull out his lasso to zipline down and escape out of the Temple, to eternal glory and the continuation of a life of adventure.

###FOLLOW_TAPE

###TRAVERSE_ROCKPIT

###ESCAPE

##Running Tests
In order to verify the quality of Indy's code, Unit Testing was implemented on the external classes, `IndyPID.cpp` and `TapeFollower.cpp`. Unit Testing used CPPUNIT to run modularized tests, ensuring code correctness after every modification.

####Getting Started
1. The unit-testing framework was written in C++ with Visual Studio 2012. Ensure that Visual Studio 2012 is installed.
2. Check that the [cppunit library](http://sourceforge.net/projects/cppunit/files/cppunit/1.12.1/) is installed on your computer.
