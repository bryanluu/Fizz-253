#include <phys253.h>       
#include <LiquidCrystal.h> 
#include <Servo253.h>      

int dummyState = HIGH;
int pin = 0;

void setup() 
{
  pinMode(pin,INPUT);
  LCD.clear();
  LCD.home();
  RCServo0.attach(RCServo0Output);  
  RCServo1.attach(RCServo1Output);
  RCServo0.write(45);
  RCServo1.write(160);
  attachInterrupt(0,collectorArmPickup,FALLING);
  Serial.begin(9600);
}

void loop() 
{
    LCD.clear();LCD.home();
       LCD.setCursor(0,0);LCD.print("dS: ");LCD.print(dummyState);
       LCD.setCursor(0,1);LCD.print("I'm driving!");
       delay(50);
}

void collectorArmPickup(){
 int i;
 delay(50);
 Serial.print("dummy state before: ");Serial.println(dummyState);
 dummyState = !dummyState;
 Serial.print("dummy state after: ");Serial.println(dummyState);
  LCD.clear();LCD.home();
  LCD.setCursor(0,0);LCD.print("Picking stuff up!");

   for(i=45;i<180;i++){
      RCServo0.write(i);
       delay(10);
    }

    RCServo1.write(175);
    delay(2000);
    RCServo1.write(45);
    delay(2000);   
  
  for(i=180;i>=45;i--){
    RCServo0.write(i);
  }
  
  delay(1000);

  RCServo1.write(160);
   
}
