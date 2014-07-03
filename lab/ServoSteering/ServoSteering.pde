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

const int centerAngle = 90;
const int angleOffset = 10;


///==============VARIABLES

int leftQRD = 0;
int rightQRD = 0;

double steerOutput = 0;
TapeFollower controller(&leftQRD, &rightQRD, &steerOutput);

double kP = 0;
double kD = 0;

int servoAngle = 0;


int LCDcounter = 0;

/////===========SETUP

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

////==================LOOP

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
Serial.print(controller.GetError());
Serial.print(",");
Serial.print(steerOutput);
Serial.print(",");
Serial.print(servoAngle);
Serial.print(",");
Serial.print('\n');

servoAngle = map(steerOutput, -2046, 2046, centerAngle - angleOffset, centerAngle + angleOffset);
RCServo0.write(servoAngle);

if (LCDcounter > 10)
{
  LCDcounter = 0;
  
  LCD.clear();LCD.home();
       LCD.setCursor(0,0);LCD.print("E: ");LCD.print(controller.GetError());
       LCD.setCursor(8,0);LCD.print("A: ");LCD.print(servoAngle);
       LCD.setCursor(0,1);LCD.print("kP: ");LCD.print(kP);
       LCD.setCursor(8,1);LCD.print("kD: ");LCD.print(kD);
}

LCDcounter++;

delay(10);

}

