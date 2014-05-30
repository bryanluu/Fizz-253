#include <phys253.h>       //   ***** from 253 template file
#include <LiquidCrystal.h> //   ***** from 253 template file
#include <Servo253.h>      //   ***** from 253 template file 

#include "WProgram.h"
#include <HardwareSerial.h>
void setup();
void loop();
int speedFrom(int knobValue);
int angleFrom(int knobValue);
int bound(int value, int lower, int higher);
void setup()
{
  portMode(0, INPUT) ;      //   ***** from 253 template file
  portMode(1, INPUT) ;      //   ***** from 253 template file
  RCServo0.attach(RCServo0Output) ;
  RCServo1.attach(RCServo1Output) ;
  RCServo2.attach(RCServo2Output) ;
   Serial.begin(9600);
 //can insert any other desired commands for the setup loop here.
 LCD.home();
 LCD.clear();
}

void loop()
{
  int knobValue = knob(6);
  int value = speedFrom(knobValue);
  Serial.println(value);
  LCD.clear();
  LCD.print(value);
  motor.speed(0, value);
//  RCServo0.write(value);
  delay(500);
}

int speedFrom(int knobValue)
{
  return ((knobValue)*2-1023);
}

int angleFrom(int knobValue)
{
  return (int)((180/1023.0)*knobValue);
}

int bound(int value, int lower, int higher)
{
  if (value > higher)
  {
    return higher;
  }
  else if (value < lower)
  {
    return lower;
  }
  else
  {
    return value;
  }
}


