unsigned long sweepStartTime = 0;
int sweepDirection = 1;

void sweep(int straightSpeed, int offSet)
{
  if(millis() - sweepStartTime >= SWEEP_DURATION)
  {
    sweepStartTime = millis();
    sweepDirection *= -1; //flip direction
    leftSpeed = straightSpeed - sweepDirection*offSet;
    rightSpeed = straightSpeed + sweepDirection*offSet;

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

