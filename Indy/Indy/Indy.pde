 //253 Libraries
#include <motor.h>
#include <phys253.h>
#include <Servo253.h>
#include <LiquidCrystal.h>

//Indy's Libraries
#include <StandardCalc.h>
#include <TapeFollower.h>

enum RobotState {INITIALIZING, FOLLOW_TAPE, COLLECT_ITEM, CLIMB_HILL, ROCKPIT, ESCAPING, FINISHED};

RobotState currentState = FOLLOW_TAPE;
RobotState lastState = INITIALIZING;

// ==================PIN SETTINGS====================
#define LEFT_QRD_PIN 1
#define RIGHT_QRD_PIN 0
#define LEFT_MOTOR 0
#define RIGHT_MOTOR 1
#define MAGNET_SERVO 0
#define COLLECTOR_SERVO 1
#define COLLECTOR_PIN 0
#define EXTERNAL_INTERRUPT0 0

//====================SETTINGS========================
#define FLAT_SPEED (280)
#define HILL_SPEED (700)
#define ROCK_SPEED (500)

//LCD
#define LCD_FREQ (1)
#define LCD_STATE_FREQ (100)
#define LCD_STATE_DUR (5)

int baseSpeed = FLAT_SPEED;

//TAPEFOLLOWING

int leftQRD = 0;
int rightQRD = 0;

double steerOutput = 0;
TapeFollower controller(&leftQRD, &rightQRD, &steerOutput);

double kP = 0;
double kD = 0;

double leftSpeed = 0;
double rightSpeed = 0;

// LCD
int LCDcounter = 0;

//============================================================
//===========================SETUP============================
//============================================================
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
  RCServo1.write(115);

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

//============================================================
//==========================MAIN LOOP=========================
//============================================================

void loop() 
{
  switch (currentState)
  {
      //======================
    case INITIALIZING:
      if(startbutton())
      {
        ChangeToState(FOLLOW_TAPE);
      }
      break;
      //======================
    case FOLLOW_TAPE:
      readTape();
      followTape();
      checkCollectorArm();
      break;
      //======================
    case COLLECT_ITEM:
      collect();
      ChangeToState(lastState);
      break;
      //======================
    case CLIMB_HILL:
      baseSpeed = HILL_SPEED;
      readTape();
      followTape();
      break;
      //======================
    case FINISHED:
      break;
    default:
      break;
  }

  printLCD();
  printDebug();
  delay(1);
}

/* Changes the current State to the specified state (as one of the enums), updating the last state.
However, state will remain the same if newState = currentState.*/
void ChangeToState(int newStateAsInt)
{
  RobotState newState = (RobotState)newStateAsInt;
  if(newState != currentState)
  {
    lastState = currentState;
    currentState = newState;
    LCDcounter = LCD_STATE_FREQ; //so that it displays the new state first
  }
}

/* Returns a string representation of the state. Input must be the a valid RobotState*/
String GetStateName(int stateAsInt)
{
  RobotState state = (RobotState)stateAsInt;
  String name;
  switch (state)
  {
    case INITIALIZING:
      return "INIT";
    case FOLLOW_TAPE:
      return "FT";
    case COLLECT_ITEM:
      return "CI";
    case CLIMB_HILL:
      return "CH";
    case ROCKPIT:
      return "RP";
    case ESCAPING:
      return "ESC";
    case FINISHED:
      return "FIN";
    default:
      return "INVALID";
  }
  return name;
}
