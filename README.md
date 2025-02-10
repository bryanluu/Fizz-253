Fizz-253
========

This is the repository for the ENPH 253 Project: with Kevin Multani, Conrad Ng, Ben Mattison, and Bryan Luu.

Check out the [website](https://indyontherocks.wixsite.com/enph253) for our robot, named **Indy on the Rocks** (*Indy* for short).

## Overview
The software running on Indy is based on a set of states, i.e. the entire challenge can be represented as a State Machine, as seen here:

![alt text](Overall%20Software%20State%20Diagram.png "Indy's State Diagram")

The stages of the competition, and thus the main states of Indy's logic, are:

1. **TAPE_FOLLOW**
2. **COLLECT_ITEM**
3. **CLIMB_HILL**
4. **ROCKPIT**
5. **ZIPLINE**

Each of these represents a major goal for Indy throughout the competition. First, Indy must navigate the Temple of the Zipline by following tape and collecting artifacts. This includes a strenous hill climb to reach the level of the Idol. Next, Indy must brave the rockpit by aiming towards the *Eye of the Idol*, a 10kHz IR Beacon. Once Indy crosses the rockpit, he must then carefully retrieve the final Idol. Finally, Indy will pull out his lasso to zipline down and escape out of the Temple, to eternal glory and the continuation of a life of adventure.

Indy is programmed with a [Wiring-based board, using a TINAH shield](http://projectlab.engphys.ubc.ca/enph253/tinah/#what-is-tinah). The programming is done in the [Wiring](http://wiring.org.co/) language.

To see the State Machine in action, watch the Software Overview below:

<a href="http://www.youtube.com/watch?feature=player_embedded&v=utKZy96eivk
" target="_blank"><img src="http://img.youtube.com/vi/utKZy96eivk/0.jpg"
alt="Indy on the Rocks - Software Overview" width="240" height="180" border="10" /></a>

### Folder Hierarchy
For a large project like Indy, there is a lot of code. This code is organized as shown below:
- `lab`
  * This folder holds all the code for experimenting and testing.
- `Indy`
  * This folder contains all the code that is linked to the code on Indy.
  * `Indy`
    * This contains the `.pde` files that are uploaded directly onto Indy. Separate files represent separate states.
  * `libraries`
    * This folder houses the external libraries used by Indy. See External Libraries for more info.
  * `Tester`
    *   This contains the Unit Tests for the external libraries. See the Tests section for more info.

### External Libraries
Although most of the code will be written with the Wiring IDE, in the `Indy.pde` sketch, we have created some external classes and code to handle complex calculations. These external libraries are included in `Indy/libraries/Bibliotheque`. These include:
- `IndyPID.cpp` - a PID controller implementation
- `TapeFollower.cpp` - a PID-like controller with discrete errors for following tape.
- `StandardCalc.cpp` - general calculations not included in the Wiring IDE.

- - -
## Running Indy
### Setup
To begin programming, follow these instructions:
 1. Ensure that the Wiring IDE, version 27, is installed. Links: [Windows](http://wiring.org.co/download/wiring-0027.zip), [Mac](http://wiring.org.co/download/wiring-0027.dmg), [Linux](http://wiring.org.co/download/wiring-0027.tgz).
 2. Clone this repository if you haven't already!
  * **PC:** Use the [GitHub Application](https://windows.github.com/) to clone the repository.
  * **Mac/Linux:** In Terminal, navigate to desired folder, then run `git clone https://github.com/bryanluu/Fizz-253.git`.
 3. Open Wiring, and change the sketchbook folder location to *Fizz-253/Indy/*.
 4. You can now open `Indy.pde` in *Fizz-253/Indy* to start programming!

### Uploading
To upload the code onto Indy, follow these instructions:
 1. Power the TINAH board with the 16 V LiPo battery
 2. Open `Indy.pde` in *Fizz-253/Indy/* with the Wiring IDE.
 3. Change *target microcontroller* to *atmega128*.
 4. Plug in the USB Serial from your computer to TINAH.
 5. Select the appropriate Serial port.
 6. Press *Upload to Wiring hardware*
 7. Press the *RESET* button on TINAH.
 8. Once upload is finished, press *RESET* again.

### Starting Indy
Finally, Indy can now be run. To run Indy, simply power on the TINAH board. It will wait for you to press start. Pressing the *START* button will make it go to the first state: `FOLLOW_TAPE`.

#### Switching States
To switch states manually, simply press the *STOP* button to activate the menu. Use *knob 6* to scroll between the states. Press *START* to select the state.

### Debugging
Indy displays information through *TINAH* via and LCD screen. A `SETTINGS` state allows the user to adjust various parameters on-the-go. Finally, a `TEST` state helps pinpoint certain problems with the motors or servos.

#### LCD Monitor
The LCD Monitor displays live data from Indy at a frequency controlled by the macro `LCD_FREQ`. It flashes the current state for a short duration `LCD_STATE_DUR` after a certain time `LCD_STATE_FREQ`. Otherwise, it will display the appropriate debug info for the current state.

#### Adjusting Settings
1. To adjust settings, simply press *STOP* to activate the menu.
2. Use *knob 6* to scroll to `SETTINGS`. Press *START* to select the `SETTINGS` state.
3. Once in this state, navigate through different adjustable settings with *knob 6*. Press *START* to select the current setting.
4. Use *knob 6* to adjust the value of the selected setting.
5. Press *START* to save the setting at the selected value. It will return to the top of the `SETTINGS` state.

- - -
## Running Tests (optional)
In order to verify the quality of Indy's code, Unit Testing was implemented on the external classes, `IndyPID.cpp` and `TapeFollower.cpp`. Unit Testing used CPPUNIT to run modularized tests, ensuring code correctness after every modification. NOTE: they are optional to the functioning of the robot, but it ensures there are no bugs in the external libraries. Below are the setup instructions to get the Tests running. It only needs to be done once.

### Getting Started (from Scratch)
1. The unit-testing framework was written in C++ with Visual Studio 2012. Ensure that Visual Studio 2012 (or later) is installed.
2. Check that the [cppunit library](http://sourceforge.net/projects/cppunit/files/cppunit/1.12.1/) is installed on your computer. We are using version *1.12.1*. If not, install and extract using [*7-Zip*]().
3. Navigate into the cppunit folder, to `cppunit-1.12.1\examples`, and open the `examples.sln` file with Visual Studio. Allow Visual Studio to convert files if necessary.
4. Right click the `cppunit` and `cppunit_dll` projects, select *Properties->Configuration Properties->Librarian->Output*, then remove the extra *d* from `cppunitd.lib` and `cppunitd_dll.lib` to `cppunit.lib` and `cppunit_dll.lib`.
5. Select *Build->Batch Build*, then select all, then unselect all the Template configurations. Build and ignore the errors.
6. Next, go into project properties:
  1. *C/C++; General*: modify the ‘Additional Include Directories’ field by adding the path to the folder `cppunit-1.12.1\include`
  2. *Linker; General*: modify the ‘Additional Library Directories’ field by adding the path to the folder `cppunit-1.12.1\lib`
  3. *Linker; Input* and modify the ‘Additional Dependencies’ field by adding the name cppunitd.lib for your debug configuration, and cppunit.lib for the release configuration.
7. Open the `Tester.sln` found in the `Indy\Tester`.
8. Right click the `Tester` project, and *Set As Startup Project*.
9. Build, and run the Tests!

### Shorter Method (with Dropbox Access)
1. The unit-testing framework was written in C++ with Visual Studio 2012. Ensure that Visual Studio 2012 (or later) is installed.
2. [Download the cppunit library folder from Dropbox](https://www.dropbox.com/sh/sh66g9szxt1dg9a/AAB4zyQSjM2bCYX7pi2xoBpYa) (must have team permissions). This folder already has the compiled binaries required.
3. Complete steps 6-end from the above section.
