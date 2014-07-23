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
  RCServo2.attach(RCServo2Output);
  RCServo0.write(0);
  RCServo2.write(115);
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
   
   for(i=0;i<145;i++){
      RCServo0.write(i);
       delay(10);
    }

    RCServo2.write(123);
    delay(2000);
    RCServo2.write(18);
    delay(2000);   
  
  for(i=145;i>=0;i--){
    RCServo0.write(i);
  }
  
  delay(1000);

  RCServo2.write(115);
  
}




//ignore this shit
void shakeOff(){
  int i;
  
  for(i=0;i<4;i++){
  RCServo0.write(45);
  delay(100);
  RCServo0.write(110); 
  delay(100);
  RCServo2.write(80);
  delay(100);
  RCServo2.write(55);
}
  
  while(digitalRead(pin) == LOW){
  
  for(i=0;i<4;i++){
  RCServo0.write(45);
  delay(100);
  RCServo0.write(110); 
  delay(100);
  RCServo2.write(80);
  delay(100);
  RCServo2.write(55);
  }
}
  
  RCServo0.write(45);
  RCServo2.write(160);
}
