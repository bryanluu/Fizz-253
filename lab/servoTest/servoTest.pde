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
  delay(4000);
  
  for(i=115;i>=0;i--){
    RCServo0.write(i);
  }

}
