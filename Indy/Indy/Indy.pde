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
#define LEFT_MOTOR 0
#define RIGHT_MOTOR 1
#define MAGNET_SERVO 0
#define COLLECTOR_SERVO 1
#define COLLECTOR_PIN 0
#define EXTERNAL_INTERRUPT0 0

int baseSpeed = 500;

int leftQRD = 0;
int rightQRD = 0;

double steerOutput = 0;
TapeFollower controller(&leftQRD, &rightQRD, &steerOutput);

double kP = 0;
double kD = 0;

double leftSpeed = 0;
double rightSpeed = 0;

boolean collect_flag = true;

int LCDcounter = 0;

void setup() 
{
// intialize ports
  portMode(0, INPUT) ;      	 	
  portMode(1, INPUT) ;
// initialize LCD screen on TINAH
  LCD.clear();
  LCD.home();
// attach the servo motors	   	
  RCServo0.attach(RCServo0Output) ;	
  RCServo1.attach(RCServo1Output) ;	
  RCServo2.attach(RCServo2Output) ;	

// initialize servo positions
  RCServo0.write(45);
  RCServo1.write(175);

// something that bryan's libraries need
  controller.attach_Kp_To(&kP);
  controller.attach_Kd_To(&kD);
  controller.SetThreshold(75);
  controller.SetOffsets(0, 0);

// initialize the serial port
  Serial.begin(9600);

// attach the interrupts
  //attachInterrupt(EXTERNAL_INTERRUPT0, collectArtifact, FALLING);
}

void loop() 
{
  readTape();
  printLCD();
  collectArtifact();
  //printDebug();
  delay(1);
}


