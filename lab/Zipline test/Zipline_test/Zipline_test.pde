#include <phys253.h>       //   ***** from 253 template file
#include <LiquidCrystal.h> //   ***** from 253 template file
#include <Servo253.h>      //   ***** from 253 template file 

int motorSpeed = -950;

void setup() 
{
  RCServo2.attach(RCServo2Output);
  portMode(0,INPUT);
  portMode(1,OUTPUT);
  LCD.clear();
  LCD.home();
  RCServo2.write(180);
}

void loop() 
{
    motor.speed(2,motorSpeed);
    
    // WINCH MOTOR SPEED
    //motor.speed(3,knob(6));  
    LCD.home();
    LCD.print("HIGH");
    
    //TODO: implement "miss" algorithm
    if (digitalRead(1) == LOW)
    {

//      motor.speed(2,0);
//      motor.speed(2,400);
//      delay(500);
//      motor.speed(2,motorSpeed);
    }
    
    // "hit"
    if (digitalRead(2) == LOW)
    {
     LCD.clear();
     LCD.home();
     LCD.print("YEEE");
     
     // stop arm
     motor.speed(2,0);
     
     // retract servo, carabiner drops onto zipline
     RCServo2.write(90);
     delay(10000);
     
     // INSERT WINCH MOTOR CODE HERE
     
     // retract deployment arm
     motor.speed(2,300);
     delay(750);
     
     // chill at the bottom
     motor.speed(2,0);
     RCServo2.write(180);
     delay(10000);
    }
   
  
}

