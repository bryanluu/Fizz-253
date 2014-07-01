#include <phys253.h>       //   ***** from 253 template file
#include <LiquidCrystal.h> //   ***** from 253 template file
#include <Servo253.h>      //   ***** from 253 template file 


int pin = 0;    // variable to store the servo position
boolean flag = true;

void setup()
{
  pinMode(pin,INPUT);
  LCD.home();
  RCServo0.attach(RCServo0Output);  
  RCServo1.attach(RCServo1Output);
  RCServo0.write(0);
  RCServo1.write(90);
}


void loop()
  { 
    LCD.clear();
    if(digitalRead(pin) == HIGH){ LCD.print("HIGH"); flag = true;}
    else if(digitalRead(pin) == LOW && flag){
    delay(200);
    IseeYou();
    flag = false;
  }
    delay(50);
  }

void IseeYou(){
  int i; 
  
  LCD.clear();
  LCD.print("YEEEE");
  
  for(i=0;i<105;i++){
    RCServo0.write(i);
    delay(10);
  }
  RCServo1.write(100);
   delay(2000);
  RCServo1.write( 0);
    delay(2000);   
  
  for(i=115;i>=0;i--){
    RCServo0.write(i);
  }
  
  delay(1000);
  RCServo1.write(90);

}
