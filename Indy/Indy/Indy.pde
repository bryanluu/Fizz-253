//253 Libraries
#include <motor.h>
#include <phys253.h>
#include <Servo253.h>
#include <LiquidCrystal.h>

//Indy's Libraries
#include <StandardCalc.h>
#include <TapeFollower.h>
#include <IndyPID.h>

enum RobotState {
  INITIALIZING, FOLLOW_TAPE, COLLECT_ITEM, CLIMB_HILL, ROCKPIT, ZIPLINE, FINISHED, TEST, MENU
};

RobotState currentState = INITIALIZING;
RobotState lastState = INITIALIZING;  


// ==================PIN SETTINGS====================
//Analog
#define LEFT_QRD_PIN 0
#define MID_QRD_PIN 1
#define RIGHT_QRD_PIN 2
#define LEFT_IR 3
#define RIGHT_IR 4

//Motors
#define RIGHT_MOTOR 0
#define LEFT_MOTOR 1

//Servos
#define MAGNET_SERVO 0
#define COLLECTOR_SERVO 1
#define ZIPLINE_ARM 2

//Digital
#define COLLECTOR_PIN 0
#define ZIPLINE_MISS 1
#define ZIPLINE_HIT 2
#define ECHO 7
#define TRIGGER 8

//====================SETTINGS========================
#define FLAT_SPEED (280)
#define HILL_SPEED (720)
#define ROCK_SPEED (300)

//level sensor
#define DANGER_HEIGHT (35) // max distance in centimeters
#define ON_HILL  (0.5) // on hill threshold
#define OFF_HILL (6.5) // off hill threshold
#define DURATION (300) //ms

//collector arm
#define RETRIEVER_WITHDRAWN (10)
#define RETRIEVER_EXTEND (145)
#define COLLECTOR_DOWN (115)
#define COLLECTOR_DROP (123)
#define COLLECTOR_TOP (10)

//zipline arm
#define ZIPLINE_DOWN_DELAY (5)

//LCD
long LCD_FREQ=(1000);
#define LCD_STATE_FREQ (LCD_FREQ*100)
#define LCD_STATE_DUR (LCD_FREQ*10)
#define LCD_FREQ_DEFAULT (1000);

//====================VARIABLES=======================

int baseSpeed = FLAT_SPEED;

//DRIVING

double leftSpeed = 0;
double rightSpeed = 0;
double steerOutput = 0;

//TAPEFOLLOWING

int leftQRD = 0;
int midQRD = 0;
int rightQRD = 0;


TapeFollower controller(&leftQRD, &midQRD, &rightQRD, &steerOutput);

double kP = 0;
double kD = 0;


// HEIGHT SENSOR

double duration, distance; // can be found in HILL.pde

//This is a one-shot variable -> it only happens once in the runtime.
boolean passedHill = true;

//ROCKPIT BEACON SENSING
double leftIR = 0;
double rightIR = 0;
PID beaconAim(&leftIR, &rightIR, &steerOutput);
double beacon_kP = 0;
double beacon_kD = 0;

// LCD
long LCDcounter = 0;


//============================================================
//===========================SETUP============================
//============================================================
void setup() 
{
  // intialize ports
  portMode(0, INPUT) ;      	 	
  portMode(1, OUTPUT) ;

  // initialize pins
  pinMode(TRIGGER, OUTPUT);
  pinMode(ECHO, INPUT);

  // initialize LCD screen on TINAH
  LCD.clear();
  LCD.home();
  // attach the servo motors	   	
  RCServo0.attach(RCServo0Output) ;	
  RCServo1.attach(RCServo1Output) ;	
  RCServo2.attach(RCServo2Output) ;	

  // initialize servo positions
  setRetrieverTo(RETRIEVER_WITHDRAWN);
  setCollectorTo(COLLECTOR_DOWN);

  // something that bryan's libraries need
  controller.attach_Kp_To(&kP);
  controller.attach_Kd_To(&kD);
  controller.SetThreshold(70);
  controller.SetOffsets(0, 0, 0);

  beaconAim.attach_Kp_To(&beacon_kP);
  beaconAim.attach_Kd_To(&beacon_kD);

  // initialize the serial port
  //  Serial.begin(9600);

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
      motor.stop_all();
      if(startbutton())
      {
        ChangeToState(FOLLOW_TAPE);
      }
      break;
      //======================
    case FOLLOW_TAPE:
      baseSpeed = FLAT_SPEED;
      readTape();
      followTape();
      checkCollectorArm();
//      if(!passedHill)
//      {
//        checkOnHill();
//      }
      break;
      //======================
    case COLLECT_ITEM:
      collect();
      ChangeToState(lastState);
      break;
      //======================
    case CLIMB_HILL:
//      readTape();
//      followTape();
//      checkOffHill();
      calibrateHeight();
      break;
      //======================
    case ROCKPIT:
      lookForBeacon();
      break;
      //======================
    case ZIPLINE:
      //      swingZiplineArm();
      testZipArm();
      break;
      //======================
    case FINISHED:
      break;
      //======================
    case TEST:
      updateTest();
      break;
      //======================
    case MENU:
      updateMenu();
      break;
    default:
      break;
  }

  //Check for Stopbutton to trigger the MENU
  if(stopbutton())
  {
    if(currentState != MENU)
    {
      ChangeToState(MENU);
    }
  }

  printLCD();
//  printDebug();
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
    case ZIPLINE:
      return "ZIP";
    case FINISHED:
      return "FIN";
    case TEST:
      return "TEST";
    case MENU:
      return "MENU";
    default:
      return "INVALID";
  }
  return name;
}


/* Changes the current State to the specified state (as one of the enums), updating the last state.
 However, state will remain the same if newState = currentState. Also, lastState does not update if
 currentState == MENU (to prevent history errors). 
 
 Also, as it changes states, it runs any necessary setup and exit functions.*/
void ChangeToState(int newStateAsInt)
{
  RobotState newState = (RobotState)newStateAsInt;
  if(newState != currentState)
  {
    if(currentState != MENU)
    {
      lastState = currentState;
    }
    
    SetupState(newState);
    ExitState(currentState);
    
    currentState = newState;
    LCDcounter = LCD_STATE_FREQ; //so that it displays the new state first
  }
}


void SetupState(int stateAsInt)
{
  RobotState state = (RobotState)stateAsInt;
  switch (state)
  {
    case FOLLOW_TAPE:
      FT_setup();
      break;
    case CLIMB_HILL:
      CH_setup();
      break;
    case MENU:
      MENU_setup();
      break;
    case ROCKPIT:
      RP_setup();
      break;
    case TEST:
      TEST_setup();
      break;
  }
}

void ExitState(int stateAsInt)
{
  RobotState state = (RobotState)stateAsInt;
  switch (state)
  {
    case FOLLOW_TAPE:
      FT_exit();
      break;
    case CLIMB_HILL:
      CH_exit();
      break;
    case MENU:
      MENU_exit();
      break;
    case ROCKPIT:
      RP_exit();
      break;
    case TEST:
      TEST_exit();
      break;
  }
}
