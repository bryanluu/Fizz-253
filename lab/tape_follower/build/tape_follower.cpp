#include <phys253.h>        		//***** from 253 template file
#include <LiquidCrystal.h>  		//***** from 253 template file
#include <servo253.h>       		//***** from 253 template file 

#include "WProgram.h"
#include <HardwareSerial.h>
void setup();
void loop();
int rightPin = 0;
int leftPin = 1;
int thresh = 250;
int baseSpeed = 200;
int error,gain,left,right;
int lastError;
int lastErrorState;
int timeInLastState;
int timeInCurrentState;
int c,d,p;
int l2,l3;

void setup()
{
  portMode(0, INPUT) ;      	 	//***** from 253 template file
  portMode(1, INPUT) ;
  LCD.clear();
  LCD.home();             	   	//***** from 253 template file
  RCServo0.attach(RCServo0Output) ;	//***** from 253 template file
  RCServo1.attach(RCServo1Output) ;	//***** from 253 template file
  RCServo2.attach(RCServo2Output) ;	//***** from 253 template file
  lastError = 0;
  lastErrorState = 0;
  l2=0;
  l3=0;
  timeInLastState = 0;
  timeInCurrentState = 1;
}


void loop()
{

    
    right = analogRead(rightPin);
    left = analogRead(leftPin);
    
    int kp = knob(6);
    int kd = knob(7);
    
    // Error control
    // Straight
    if ((left > thresh) && (right > thresh+50)){
      error = 0;
    }
    // Slightly on the right
    else if ((left > thresh) && (right < thresh+50)){
      error = 1;
    }
    // Slightly on the left
    else if ((left < thresh) && (right > thresh+50)){
      error = -1;
    }
    //Both off the tape
    else if ((left<thresh) && (right<thresh+50)){
      // Even more on the right
      if(lastError>=0 && l2>=0 && l3>=0){
        error =2;
      }
      //Even more on the left
      else if (lastError<0 && l2<0 && l3<0){
        error = -2;
      } 
      
    }
      //Derivative approximation using the error of last state
      if (!(error==lastError)){
        lastErrorState=lastError;
        timeInLastState=timeInCurrentState;
        timeInCurrentState=1;
      }

     
     p = kp*error;
     d = (int)((double)kd*(double)(error-lastErrorState)/ (double)(timeInLastState+timeInCurrentState));
     
     gain = p+d;
     
     motor.speed(rightPin,abs(baseSpeed+100+gain));
     motor.speed(leftPin+2,abs(-baseSpeed+gain));
     
     if (c==30){
       LCD.clear();LCD.home();
       LCD.setCursor(0,0);LCD.print(gain);
       LCD.setCursor(9,0);LCD.print(error);
       LCD.setCursor(0,1);LCD.print("L: ");LCD.print(left);
       LCD.setCursor(8,1);LCD.print("R: ");LCD.print(right);
       c=0;
     }
     
     c = c+1;
     timeInCurrentState=timeInCurrentState+1;
     
     l3=l2;
     l2=lastError;
     lastError = error;
     
 }
 

