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
      ChangeToState(FOLLOW_TAPE);
      collect();
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


