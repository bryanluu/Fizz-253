boolean RP_init = false;

void RP_setup()
{
  if(!RP_init)
  {
    RP_init = true;

    //INITIALIZATION

    baseSpeed = ROCK_SPEED;
    setCollectorTo(COLLECTOR_ROCK);
    LCD_FREQ = 100;
  }
}

void RP_exit()
{
  RP_init = false;
  baseSpeed = 0;
  LCD_FREQ = LCD_FREQ_DEFAULT;
}

///===========MAIN CODE

inline boolean beaconDetected()
{
  return leftIR > IR_THRESHOLD || rightIR > IR_THRESHOLD;
}

void lookForBeacon()
{
  int left = analogRead(LEFT_IR);
  int right = analogRead(RIGHT_IR);
  
  if(!(left == 0 && right == 0))//ignores 0 readings
  {
    leftIR = left;
    rightIR = right;
  }
}

void driveTowardsBeacon()
{
  beaconAim.Compute();
  
  if(isCloseToIdol())
  {
    baseSpeed = ROCK_SPEED - 30;
  }
  
  steerOutput = constrain(steerOutput, -500, 500);
  
  rightSpeed = baseSpeed + steerOutput;
  leftSpeed = baseSpeed - steerOutput;
  

  leftSpeed = constrain(leftSpeed, -1023, 1023);
  rightSpeed = constrain(rightSpeed, -1023, 1023);

  motor.speed(LEFT_MOTOR, leftSpeed);
  motor.speed(RIGHT_MOTOR, rightSpeed);

//  LCD.clear();
//  LCD.home();
//  LCD.print((int)leftSpeed);
//  LCD.setCursor(0,1);
//  LCD.print((int)rightSpeed);
//  delay(50);
}

void rockpit_LCD()
{
  LCD.print((int)steerOutput);
  LCD.setCursor(5,0);
  LCD.print((int)leftIR);
  LCD.setCursor(11,0);
  LCD.print((int)rightIR);
  LCD.setCursor(0,1);
  LCD.print("L: ");
  LCD.print((int)leftSpeed);
  LCD.setCursor(8,1);
  LCD.print("R: ");
  LCD.print((int)rightSpeed);
}

inline boolean isCloseToIdol()
{
  return leftIR > IR_SLOWDIST || rightIR > IR_SLOWDIST;
}
