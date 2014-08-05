unsigned long sweepStartTime = 0;
int sweepDirection = 1;

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

//If last error is positive => clockwise, if last error negative => counter clock wise
void turnAround(int spinSpeed)
{
  motor.speed(LEFT_MOTOR, spinSpeed);
  motor.speed(RIGHT_MOTOR, -spinSpeed);
}

