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
  if(distance >= OFF_HILL)
  {
    startTime = millis();    
    while((endTime-startTime) < DURATION)
    {
      endTime = millis();
    }
    ChangeToState(FOLLOW_TAPE);
  }
}

void checkDanger()
{
   distance = senseHeight();
  if(distance >= DANGER_HEIGHT)
  {
    ChangeToState();
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


