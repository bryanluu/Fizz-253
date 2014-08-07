/*This state is for testing TINAH and the general systems of INDY*/
boolean TEST_init = false;
enum TEST_KIND { 
  MOTORS, COLLECTOR, SERVO, QRD, ULS, IR, SWEEP, WINCH, NONE
};
TEST_KIND testChoice = NONE;
TEST_KIND currentTest = NONE;
int collectorAngle = 0;
int retrieverAngle = 0;
int sweepSpeed = 0;
int sweepOff = 0;
int servoNum = 0;
int servoAngle = 0;

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
    sweepOff = 0;
    servoNum = 0;
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
      delay(500);
    }
    break;
  case MOTORS:
    testMotors();
    break;
  case COLLECTOR:
    testCollector();
    break;
  case SERVO:
    testServos();
    break;
  case QRD:
    testQRDs();
    break;
  case ULS:
    testULS();
    break;
  case IR:
    testIR();
    break;
  case SWEEP:
    testSweep();
    break;
  case WINCH:
    testWinch();
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
  setCollectorTo(COLLECTOR_DOWN);
  setRetrieverTo(RETRIEVER_WITHDRAWN);
  if (digitalRead(COLLECTOR_PIN) == LOW)
  {
    collect();
  }
}

void testServos()
{
  servoAngle = (int)map(knob(6), 0, KNOB6_MAX, 0, 180);
  
  switch(servoNum)
  {
    case 0:
      RCServo0.write(servoAngle);
      break;
    case 1:
      RCServo1.write(servoAngle);
      break;
    case 2:
      RCServo2.write(servoAngle);
      break;
  }
  
  if(startbutton())
  {
    if(servoNum==2)
    {
      servoNum=0;
    }
    else
    {
      servoNum++;
    }
    delay(500);
  }
}

void testQRDs()
{
  readTape();
}

void testULS()
{
  senseHeight();
}

void testIR()
{
  leftIR = analogRead(LEFT_IR);
  rightIR = analogRead(RIGHT_IR);
}

void testSweep()
{
  sweepSpeed = (int)map(knob(6), 0, KNOB6_MAX, -1023, 1023);  
  sweepSpeed = constrain(sweepSpeed, -1023, 1023);
  sweepOff = (int)map(knob(7), 0, KNOB7_MAX, -1023, 1023);  
  sweepOff = constrain(sweepOff, -1023, 1023);

  sweep(sweepSpeed, sweepOff);
}

void testWinch()
{
  
  if(startbutton())
  {
    digitalWrite(WINCH_PIN, HIGH);
  }
  else
  {
    digitalWrite(WINCH_PIN, LOW);
  }
  
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
  case SERVO:
    testServosLCD();
    break;
  case QRD:
    testQRDsLCD();
    break;
  case ULS:
    testULSLCD();
    break;
  case IR:
    testIRLCD();
    break;
  case SWEEP:
    testSweepLCD();
    break;
  case WINCH:
    testWinchLCD();
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
  LCD.print("Waiting for");
  LCD.setCursor(0,1);
  LCD.print("Item...");
}

void testServosLCD()
{
  LCD.print("Servo "); LCD.print(servoNum);
  LCD.setCursor(0,1);
  LCD.print("Angle: ");
  LCD.print(servoAngle);
}

void testQRDsLCD()
{
  LCD.print((int)leftQRD);
  LCD.setCursor(5,0);
  LCD.print((int)midQRD);
  LCD.setCursor(11,0);
  LCD.print((int)rightQRD);
  LCD.setCursor(0,1);
  LCD.print("Error:"); LCD.print((int)controller.GetError());
}

void testULSLCD()
{
  LCD.print("Distance:");
  LCD.setCursor(0,1);
  LCD.print(distance);
}

void testIRLCD()
{
  LCD.print("L:"); LCD.print(leftIR);
  LCD.setCursor(8,0);
  LCD.print("R:"); LCD.print(rightIR);
  LCD.setCursor(0,1);
  if(beaconDetected())
  {
    LCD.print("Beacon");
  }
  else
  {
    LCD.print("No Beacon");
  }
}

void testSweepLCD()
{
  LCD.print("Speed:");
  LCD.setCursor(0,1);
  LCD.print(sweepSpeed);
}

void testWinchLCD()
{
  LCD.print("Use START");
  LCD.setCursor(0,1);
  if(startbutton())
  {
    LCD.print("Winch ON");
  }
  else
  {
    LCD.print("Winch OFF");
  }
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
  case SERVO:
    return "SERVOS";
  case QRD:
    return "QRDs";
  case ULS:
    return "ULS";
  case IR:
    return "IR";
  case SWEEP:
    return "SWEEP";
  case WINCH:
    return "WINCH";
  default:
    return "INVALID";
  }
}

