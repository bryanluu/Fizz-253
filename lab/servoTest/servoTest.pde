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
  RCServo0.write(45);
  RCServo1.write(180);
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
  
  LCD.clear();
  LCD.print("YEEEE");
  
   pickUp();
   
}

void pickUp(){

   int i; 
   
   for(i=45;i<180;i++){
      RCServo0.write(i);
       delay(10);
    }

    RCServo1.write(180);
    delay(2000);
    RCServo1.write(70);
    delay(2000);   
  
  for(i=180;i>=45;i--){
    RCServo0.write(i);
  }
  
  delay(1000);
  
  shakeOff();

  delay(1000);
  
  RCServo1.write(180);
  
}

void shakeOff(){
  int i;
  
  for(i=0;i<4;i++){
  RCServo0.write(45);
  delay(100);
  RCServo0.write(110); 
  delay(100);
  RCServo1.write(80);
  delay(100);
  RCServo1.write(55);
}
  
  while(digitalRead(pin) == LOW){
  
  for(i=0;i<4;i++){
  RCServo0.write(45);
  delay(100);
  RCServo0.write(110); 
  delay(100);
  RCServo1.write(80);
  delay(100);
  RCServo1.write(55);
  }
}
  
  RCServo0.write(45);
  RCServo1.write(180);
}
