#include <phys253.h>       //   ***** from 253 template file
#include <LiquidCrystal.h> //   ***** from 253 template file
#include <Servo253.h>      //   ***** from 253 template file 

void setup()
{
  portMode(0, INPUT) ;      //   ***** from 253 template file
  portMode(1, INPUT) ;      //   ***** from 253 template file
  RCServo0.attach(RCServo0Output) ;
  RCServo1.attach(RCServo1Output) ;
  RCServo2.attach(RCServo2Output) ;
   
   LCD.clear();
   LCD.home();
   Serial.begin(9600);
 //can insert any other desired commands for the setup loop here.
}

void loop()
{
   LCD.clear();
   LCD.home();
   
   if(digitalRead(0))
   {
     LCD.print("White detected.");
     Serial.println("White detected.");
   }
   else
   {
     LCD.print("Black detected.");
     Serial.println("Black detected.");
   }
   
   delay(50);
  
  

}
