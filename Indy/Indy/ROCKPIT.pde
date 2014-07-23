boolean RP_init = false;
  
void RP_setup()
{
  if(!RP_init)
  {
    RP_init = true;
    
    //INITIALIZATION
    
    baseSpeed = ROCK_SPEED;
  }
}

void RP_exit()
{
  RP_init = false;
  baseSpeed = 0;
}

///===========MAIN CODE

void lookForBeacon()
{
  leftIR = analogRead(LEFT_IR);
  rightIR = analogRead(RIGHT_IR);
  
  beacon_kP = knob(6);
  beacon_kD = knob(7);
  
  beaconAim.Compute();
  
}

void driveTowardsBeacon()
{
  rightSpeed = baseSpeed+steerOutput;
  leftSpeed = baseSpeed-steerOutput;

  leftSpeed = constrain(leftSpeed, -1023, 1023);
  rightSpeed = constrain(rightSpeed, -1023, 1023);

  motor.speed(LEFT_MOTOR, leftSpeed);
  motor.speed(RIGHT_MOTOR, rightSpeed);
}

void rockpit_LCD()
{
  LCD.print((int)beaconAim.GetError());
  LCD.setCursor(5,0);LCD.print((int)leftIR);
  LCD.setCursor(11,0);LCD.print((int)rightIR);
  LCD.setCursor(0,1);LCD.print("kP: ");LCD.print((int)beacon_kP);
  LCD.setCursor(0,1);LCD.print("kD: ");LCD.print((int)beacon_kD);
}

