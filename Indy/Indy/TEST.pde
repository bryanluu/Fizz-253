/*This state is for testing TINAH and the general systems of INDY*/
boolean TEST_init = false;
enum TEST_KIND { 
  MOTORS, COLLECTOR, SWEEP, NONE
};
TEST_KIND testChoice = NONE;
TEST_KIND currentTest = NONE;
int collectorAngle = 0;
int retrieverAngle = 0;
int sweepSpeed = 0;

void TEST_setup()
{
  if(!TEST_init)
  {
    TEST_init = true;
    testChoice = NONE;
    currentTest = NONE;
    motor.stop_all();
    collectorAngle = 0;
    retrieverAngle = 0;
    sweepSpeed = 0;
    delay(200);
  }
}

void TEST_exit()
{
  TEST_init = false;
  delay(200);
}

void updateTest()
{
  switch(currentTest)
  {
  case NONE:
    testChoice = (TEST_KIND)((int)(map(knob(6), 0, KNOB6_MAX, 0, NONE)));
    testChoice = (TEST_KIND)constrain(testChoice, 0, NONE-1);

    if(startbutton())
    {
      currentTest = testChoice;
    }
    break;
  case MOTORS:
    testMotors();
    break;
  case COLLECTOR:
    testCollector();
    break;
  case SWEEP:
    testSweep();
    break;
  }
}

void testMotors()
{
  leftSpeed = (int)map(knob(7), 0, KNOB7_MAX, -1023, 1023);  
  rightSpeed = (int)map(knob(6), 0, KNOB6_MAX, -1023, 1023);

  leftSpeed = constrain(leftSpeed, -1023, 1023);
  rightSpeed = constrain(rightSpeed, -1023, 1023);

  if(abs(leftSpeed) < 20)
  {
    leftSpeed = 0;
  }

  if(abs(rightSpeed) < 20)
  {
    rightSpeed = 0;
  }

  motor.speed(LEFT_MOTOR, leftSpeed);
  motor.speed(RIGHT_MOTOR, rightSpeed);
}

void testCollector()
{
  collectorAngle = (int)map(knob(6), 0, KNOB6_MAX, 0, 180);  
  retrieverAngle = (int)map(knob(7), 0, KNOB7_MAX, 0, 180);

  setCollectorTo(collectorAngle);
  setRetrieverTo(retrieverAngle);
}

void testSweep()
{
  sweepSpeed = (int)map(knob(6), 0, KNOB6_MAX, -1023, 1023);  
  sweepSpeed = constrain(sweepSpeed, -1023, 1023);

  sweep(sweepSpeed);
}

///////TEST LCD/////////

void testLCD()
{
  switch(currentTest)
  {
  case NONE:
    LCD.print("Choose Test:");
    LCD.setCursor(0,1); 
    LCD.print(GetTestName(testChoice));
    break;
  case MOTORS:
    testMotorsLCD();
    break;
  case COLLECTOR:
    testCollectorLCD();
    break;
  case SWEEP:
    testSweepLCD();
    break;
  }
}

void testMotorsLCD()
{
  LCD.print("LEFT:");
  LCD.setCursor(0,1);
  LCD.print((int)leftSpeed);
  LCD.setCursor(8,0);
  LCD.print("RIGHT:");
  LCD.setCursor(8,1);
  LCD.print((int)rightSpeed);
}

void testCollectorLCD()
{
  LCD.print("Collector:");
  LCD.setCursor(12,0);
  LCD.print(collectorAngle);
  LCD.setCursor(0,1);
  LCD.print("Retriever:");
  LCD.setCursor(12,1);
  LCD.print(retrieverAngle);
}

void testSweepLCD()
{
  LCD.print("Speed:");
  LCD.setCursor(0,1);
  LCD.print(sweepSpeed);
}

String GetTestName(int testAsInt)
{
  TEST_KIND test = (TEST_KIND)testAsInt;
  switch(test)
  {
  case MOTORS:
    return "MOTORS";
  case COLLECTOR:
    return "COLLECTOR";
  case SWEEP:
    return "SWEEP";
  default:
    return "INVALID";
  }
}

