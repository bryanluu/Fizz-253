 //253 Libraries
#include <motor.h>
#include <phys253.h>
#include <Servo253.h>
#include <LiquidCrystal.h>

int count;

void setup() 
{
    portMode(0, INPUT) ;      	 	//***** from 253 template file
    portMode(1, INPUT) ;
    LCD.clear();
    LCD.home();             	   	//***** from 253 template file
    RCServo0.attach(RCServo0Output) ;	//***** from 253 template file
    RCServo1.attach(RCServo1Output) ;	//***** from 253 template file
    RCServo2.attach(RCServo2Output) ;	//***** from 253 template file
    count = 0;
}

void loop() 
{
  int leftSpeed = 2*(knob(6)-512);
  int rightSpeed = 2*(knob(7)-512);
  
  
  motor.speed(0,leftSpeed);
  motor.speed(1,rightSpeed);
  
   count = 0;
   LCD.clear();
   LCD.home();
   LCD.print(leftSpeed);
   LCD.setCursor(6,0);
   LCD.print(rightSpeed);
   
   delay(50);
}

