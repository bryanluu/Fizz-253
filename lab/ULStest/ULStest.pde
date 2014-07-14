#include <phys253.h>        		//***** from 253 template file
#include <LiquidCrystal.h>  		//***** from 253 template file
#include <servo253.h>       		//***** from 253 template file 

#define TRIGGER_PIN 3
#define ECHO_PIN 8

void setup()
{
  portMode(0, OUTPUT) ;      	 	//***** from 253 template file
  portMode(1, INPUT);      	   	//***** from 253 template file
  RCServo0.attach(RCServo0Output) ;	//***** from 253 template file
  RCServo1.attach(RCServo1Output) ;	//***** from 253 template file
  RCServo2.attach(RCServo2Output) ;	//***** from 253 template file

  pinMode(TRIGGER_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);

  Serial.begin(9600);
  
  LCD.home();
}

int count = 0;

void loop()
{
    digitalWrite(TRIGGER_PIN, HIGH);
    delayMicroseconds(10);
    digitalWrite(TRIGGER_PIN, LOW);
    
    int duration = pulseIn(ECHO_PIN, HIGH);
    
    if (count > 3)
    {
      LCD.clear();
      LCD.print("Distance (cm)");
      LCD.setCursor(0, 1);
      LCD.print(distanceInCM(duration), 6);
      count = 0;
    }
    
    delay(60);
    count++;
}


double distanceInCM(int duration)
{
  return duration/58.0;
}

  

