boolean DANGER_init = false;
unsigned long sweepStartTime = 0;
int sweepDirection = 1;

void DANGER_setup()
{
  if(!DANGER_init)
  {
    DANGER_init = true;

    //INITIALIZATION
    motor.stop_all();
  }
}

void DANGER_exit()
{
  DANGER_init = false;
}

void sweep(int straightSpeed)
{
  if(millis() - sweepStartTime >= SWEEP_DURATION)
  {
    sweepStartTime = millis();
    sweepDirection *= -1; //flip direction
    leftSpeed = straightSpeed - sweepDirection*SWEEP_OFFSET;
    rightSpeed = straightSpeed + sweepDirection*SWEEP_OFFSET;

    motor.speed(LEFT_MOTOR, leftSpeed);
    motor.speed(RIGHT_MOTOR, rightSpeed);
  }
}

void DANGER_LCD()
{
  LCD.print("Looking for");
  LCD.setCursor(0,1); 
  LCD.print("Tape...");
}

void watchForEdge()
{
  if (distance >= DANGER_HEIGHT)
  {
    ChangeToState(DANGER);
  }
}

