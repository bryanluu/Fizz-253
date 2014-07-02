#include <phys253.h>       //   ***** from 253 template file
#include <LiquidCrystal.h> //   ***** from 253 template file
#include <Servo253.h>      //   ***** from 253 template file 

int pos;
void setup() 
{
  LCD.home();
  RCServo0.attach(RCServo0Output);  
  RCServo0.write(0);
}

void loop() 
{
  LCD.clear();
  pos = int(knob(6)*180.0/1024);
  LCD.print(pos);
  RCServo0.write(pos);
}

