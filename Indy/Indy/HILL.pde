int startTime = 0;
double minDist = -1;
double maxDist = -1;

void checkOnHill()
{
  distance = senseHeight();
  if(distance <= ON_HILL)
  {
    ChangeToState(CLIMB_HILL);
  }
}

void checkOffHill()
{
  distance = senseHeight();
  if(!passedHill && distance >= OFF_HILL)
  {
    passedHill = true;
    startTime = millis();    
  }
  
  if(passedHill)
  {
    if(millis() - startTime > DURATION)
    {
      motor.stop(LEFT_MOTOR);
      motor.stop(RIGHT_MOTOR);
      collect();
      ChangeToState(FOLLOW_TAPE);
    }
  }
}

void checkDanger()
{
   distance = senseHeight();
  if(distance >= DANGER_HEIGHT)
  {
//    ChangeToState();
  }
}


double senseHeight()
{
  digitalWrite(TRIGGER, LOW);
  delayMicroseconds(2);
  
  digitalWrite(TRIGGER, HIGH);
  delayMicroseconds(10);
  
  digitalWrite(TRIGGER,LOW);
  duration = pulseIn(ECHO,HIGH);
  return (duration/58.2);
}

void calibrateHeight()
{
  motor.stop_all();
  distance = senseHeight();
  if(distance < minDist || minDist == -1)
  {
    minDist = distance;
  }
  if(distance > maxDist || maxDist == -1)
  {
    maxDist = distance;
  }
}

void hill_LCD()
{
  LCD.print("D: "); LCD.print(distance);
  LCD.setCursor(0,1); LCD.print(minDist);
  LCD.setCursor(8,1); LCD.print(maxDist);
}



