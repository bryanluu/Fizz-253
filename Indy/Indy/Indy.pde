//253 Libraries
#include <motor.h>
#include <phys253.h>
#include <Servo253.h>
#include <LiquidCrystal.h>

//Indy's Libraries
#include <StandardCalc.h>
#include <TapeFollower.h>
#include <IndyPID.h>

//Other Libraries
#include <EEPROM.h>

enum RobotState {
  INITIALIZING, FOLLOW_TAPE, COLLECT_ITEM, CLIMB_HILL, ROCKPIT, DANGER, ZIPLINE, FINISHED, TEST, SETTINGS, MENU
};

RobotState currentState = INITIALIZING;
RobotState lastState = INITIALIZING;  

enum Strategy { FullCourse, OnePoint, TwoPoints, ThreePoints, OnlyIdolGround, OnlyIdolZip };
Strategy currentStrat = FullCourse;



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
int FLAT_SPEED=(300);
int HILL_SPEED=(800);
int ROCK_SPEED=(300);
int SPIN_SPEED=(1023);

int SWEEP_DURATION=(1000);
int SWEEP_OFFSET=(100);

//level sensor
double DANGER_HEIGHT=(35); // max distance in centimeters
double ON_HILL=(3.03); // on hill threshold
double OFF_HILL=(5.0); // off hill threshold
double DURATION=(1000); //ms

//collector arm
int RETRIEVER_WITHDRAWN=(0);
int RETRIEVER_EXTEND=(117);
int COLLECTOR_START=(110);
int COLLECTOR_DOWN=(120);
int COLLECTOR_DROP=(130);
int COLLECTOR_TOP=(17);

//IR detection
int IR_THRESHOLD=(10);

//zipline arm
#define ZIPLINE_DOWN_DELAY (5)

//LCD
#define LCD_FREQ_DEFAULT (500);
unsigned long LCD_FREQ=LCD_FREQ_DEFAULT;
#define LCD_STATE_FREQ (LCD_FREQ*200)
#define LCD_STATE_DUR (LCD_FREQ*10)

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
double kP = 300;
double kD = 0;


// HEIGHT SENSOR

double duration, distance; // can be found in HILL.pde
int hillCount = 0;
double minDist = -1;
double maxDist = -1;

//This is a one-shot variable -> it only happens once in the runtime.
boolean passedHill = false;

//ROCKPIT BEACON SENSING
double leftIR = 0;
double rightIR = 0;
PID beaconAim(&leftIR, &rightIR, &steerOutput);
double beacon_kP = 400;
double beacon_kI = 0;
double beacon_kD = 0;

// LCD
unsigned long LCDcounter = 0;

// Challenge Related
int itemCount = 0;
boolean goingHome = false;


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
  beaconAim.attach_Ki_To(&beacon_kI);
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
      INIT_update();
      break;
      //======================
    case FOLLOW_TAPE:
      readTape();
      followTape();
      if(!goingHome)
      {
        checkCollectorArm();
      }
      if(!passedHill)
      {
        checkOnHill();
      }
      watchForEdge();
      
      if(currentStrat == FullCourse || currentStrat == OnlyIdolGround || currentStrat == OnlyIdolZip)
      {
        if(passedHill)
        {
          lookForBeacon();
          if(beaconDetected())
          {
            ChangeToState(ROCKPIT);
          }
        }
        
      }
      break;
      //======================
    case COLLECT_ITEM:
      collect();
      
      if(currentStrat != FullCourse && currentStrat <= ThreePoints && itemCount == currentStrat)
      {
        LCD.clear(); LCD.home();
        LCD.print("GOING HOME!");
        
        goingHome = true;
        
        turnAround();
        delay(200);
        do
        {
          readTape();
        }while(controller.offTape());
        
      }
      
      ChangeToState(lastState);
      
      if(lastState == ROCKPIT)
      {
        if(currentStrat == OnlyIdolGround) //turn around on the rocks
        {
          LCD.clear(); LCD.home();
          LCD.print("GOING HOME!");
          
          goingHome = true;
          
          turnAround();
          delay(200);
          do
          {
            lookForBeacon();
          }while(!beaconDetected());
          
          do
          {
            lookForBeacon();
            driveTowardsBeacon();
          }while(leftIR < 1000 && rightIR < 1000);
          
          do
          {
            readTape();
            sweep(FLAT_SPEED);
          }while(controller.offTape());
          
          ChangeToState(FOLLOW_TAPE);
        }
        else
        {
          ChangeToState(ZIPLINE);
        }
      }
      
      break;
      //======================
    case CLIMB_HILL:
      readTape();
      followTape();
      checkOffHill();
//      calibrateHeight();
      watchForEdge();
      break;
      //======================
    case ROCKPIT:
      lookForBeacon();
      if(beaconDetected())
      {
        driveTowardsBeacon();
      }
      else
      {
        sweep(ROCK_SPEED);
      }
      watchForEdge();
      break;
      //======================
    case DANGER:
      if(lastState == FOLLOW_TAPE)
      {
        readTape(); 
        //swivels the bot back and forth backwards until it sees tape
        if(controller.offTape())
        {
          sweep(-FLAT_SPEED);
        }
        else
        {
          ChangeToState(FOLLOW_TAPE);
        }
      }
      break;
      //======================
    case ZIPLINE:
      swingZiplineArm();
      break;
      //======================
    case FINISHED:
      break;
      //======================
    case TEST:
      updateTest();
      break;
      //======================
    case SETTINGS:
      updateSettings();
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
    case DANGER:
      return "DANGER";
    case ZIPLINE:
      return "ZIP";
    case FINISHED:
      return "FIN";
    case TEST:
      return "TEST";
    case SETTINGS:
      return "SETTINGS";
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
    
    
    ExitState(currentState);
    SetupState(newState);
    
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
    case DANGER:
      DANGER_setup();
      break;
    case TEST:
      TEST_setup();
      break;
    case SETTINGS:
      SETTINGS_setup();
      break;
  }
}

void ExitState(int stateAsInt)
{
  RobotState state = (RobotState)stateAsInt;
  switch (state)
  {
    case INITIALIZING:
      INIT_exit();
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
    case DANGER:
      DANGER_exit();
    case TEST:
      TEST_exit();
      break;
    case SETTINGS:
      SETTINGS_exit();
      break;
  }
}
