//253 Libraries
#include <motor.h>
#include <phys253.h>
#include <Servo253.h>
#include <LiquidCrystal.h>

//Indy's Libraries
#include <StandardCalc.h>
#include <TapeFollower.h>

#define LEFT_QRD_PIN 1
#define RIGHT_QRD_PIN 0

const int baseSpeed = 200;

int leftQRD = 0;
int rightQRD = 0;

double steerOutput = 0;
TapeFollower controller(&leftQRD, &rightQRD, &steerOutput);

double kP = 0;
double kD = 0;

int LCDcounter = 0;

double* test = &steerOutput;

void setup() 
{


portMode(0, INPUT) ;      	 	//***** from 253 template file
portMode(1, INPUT) ;
LCD.clear();
LCD.home();             	   	//***** from 253 template file
RCServo0.attach(RCServo0Output) ;	//***** from 253 template file
RCServo1.attach(RCServo1Output) ;	//***** from 253 template file
RCServo2.attach(RCServo2Output) ;	//***** from 253 template file

controller.attach_Kp_To(&kP);
controller.attach_Kd_To(&kD);

Serial.begin(9600);


}

void loop() 
{
leftQRD = analogRead(LEFT_QRD_PIN);
rightQRD = analogRead(RIGHT_QRD_PIN);

kP = knob(6);
kD = knob(7);

controller.Compute();

Serial.print(leftQRD);
Serial.print(",");
Serial.print(rightQRD);
Serial.print(",");
Serial.print(kP);
Serial.print(",");
Serial.print(kD);
Serial.print(",");
Serial.print(steerOutput);
Serial.print('\n');



if (LCDcounter > 10)
{
  *test++;
  LCDcounter = 0;
}

LCDcounter++;

delay(100);

}

