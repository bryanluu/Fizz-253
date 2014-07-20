#include <phys253.h>       //   ***** from 253 template file
#include <LiquidCrystal.h> //   ***** from 253 template file
#include <Servo253.h>      //   ***** from 253 template file 

int motorSpeed = -950;
int winchSpeed = 0;
int count = 0;

void setup() 
{
  RCServo2.attach(RCServo2Output);
  portMode(0,INPUT);
  portMode(1,OUTPUT);
  LCD.clear();
  LCD.home();
  RCServo2.write(180);
  
  LCD.print("Press start...");
  while(!startbutton())
  {delay(50);}
}

void loop() 
{
    motor.speed(2,motorSpeed);
    RCServo2.write(180);
    
    // WINCH MOTOR SPEED
    winchSpeed = 2*(knob(6)-512);
    motor.speed(3,winchSpeed);  
    
    // printing
    if (count == 100)
    {
      count = 0;
      LCD.clear();
    LCD.home();
    LCD.print("HIGH");
    LCD.setCursor(0,1); LCD.print(winchSpeed);
    }
    count++;

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
     delay(500);
     
     // INSERT WINCH MOTOR CODE HERE
     winchSpeed = 700;
     motor.speed(3,winchSpeed);
     while(digitalRead(3) == HIGH)
     {delay(15);}
     motor.speed(3,0);
     
     
     delay(500);
     // retract deployment arm
     motor.speed(2,300);
     while(digitalRead(4) == HIGH)
     {delay(15);}
     
     // chill at the bottom
     motor.speed(2,0);
     
     LCD.home();
     LCD.print("Start to reset..");
     RCServo2.detach();
     while(!startbutton())
     {delay(20);}
     RCServo2.attach(RCServo2Output);
     RCServo2.write(180);
     
     delay(1000);
     
     LCD.home();
     LCD.print("Press start...  ");
     while(!startbutton())
     {delay(20);}

     
    }
   
  
}

