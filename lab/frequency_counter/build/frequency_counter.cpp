#include <phys253.h>       //   ***** from 253 template file
#include <LiquidCrystal.h> //   ***** from 253 template file
#include <Servo253.h>      //   ***** from 253 template file 

#include "WProgram.h"
#include <HardwareSerial.h>
void setup();
void loop();
double lastPulse = 0.0;
int count = 0;
double lastPrint = 0.0;

void setup()
{
  portMode(0, INPUT) ;      //   ***** from 253 template file
  portMode(1, INPUT) ;      //   ***** from 253 template file
  RCServo0.attach(RCServo0Output) ;
  RCServo1.attach(RCServo1Output) ;
  RCServo2.attach(RCServo2Output) ;
   
   LCD.clear();
   LCD.home();
 //can insert any other desired commands for the setup loop here.
 
 //attachInterrupt(0, pulsed, RISING);

}

void loop()
{
   while(digitalRead(0) == HIGH);
   double now = micros();
     double elapsed = now - lastPulse;
     lastPulse = now;
     double frequency = 1.0/(elapsed/1000000.0);
     
     if(now-lastPrint > 1000000.0)
     {
      lastPrint = now;
      LCD.clear();
       LCD.print(frequency);
     } 
   while(digitalRead(0) == LOW);
   
//   bool state = digitalRead(0);
//   
//   if (state != lastState)
//   {
//     if (state == HIGH)
//     {
//       pulsed();
//     }
//   }
//   
//   lastState = state;
//   
}
//
//void pulsed()
//{
//  LCD.clear();
//  LCD.home();
//  
//  
//  long now = micros();
//  long elapsedTime = now-lastPulseTime;
//  lastPulseTime = now;
//  
//  frequency = 1.0/(elapsedTime/1000000.0);
//  
//  LCD.print(frequency);
//  LCD.print(" Hz");
//  
//  Serial.print("Frequency (Hz): ");
//  Serial.println(frequency);
//  
//
//}


