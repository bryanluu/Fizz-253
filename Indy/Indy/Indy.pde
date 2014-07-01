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
#define LEFT_MOTOR 3
#define RIGHT_MOTOR 0

const int baseSpeed = 200;

int leftQRD = 0;
int rightQRD = 0;

double steerOutput = 0;
TapeFollower controller(&leftQRD, &rightQRD, &steerOutput);

double kP = 0;
double kD = 0;

double leftSpeed = 0;
double rightSpeed = 0;

int LCDcounter = 0;

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

//Serial.print(leftQRD);
//Serial.print(",");
//Serial.print(rightQRD);
//Serial.print(",");
//Serial.print(kP);
//Serial.print(",");
//Serial.print(kD);
//Serial.print(",");
//Serial.print(controller.GetError());
//Serial.print(",");
//Serial.print(steerOutput);
//Serial.print(",");
//Serial.print(leftSpeed);
//Serial.print(",");
//Serial.print(rightSpeed);
//Serial.print(",");
//Serial.print('\n');


rightSpeed = baseSpeed+100+steerOutput;
leftSpeed = -baseSpeed+steerOutput;

StandardCalc::boundValueBetween(&leftSpeed, -1023, 0);
StandardCalc::boundValueBetween(&rightSpeed, 0, 1023);

leftSpeed = abs(leftSpeed);
rightSpeed = abs(rightSpeed);

motor.speed(LEFT_MOTOR, leftSpeed);
motor.speed(RIGHT_MOTOR, rightSpeed);

if (LCDcounter > 10)
{
  LCDcounter = 0;
  
  LCD.clear();LCD.home();
       LCD.setCursor(0,0);LCD.print("Error: ");LCD.print(controller.GetError());
       LCD.setCursor(0,1);LCD.print("kP: ");LCD.print(kP);
       LCD.setCursor(8,1);LCD.print("kD: ");LCD.print(kD);
}

LCDcounter++;

delay(10);

}

