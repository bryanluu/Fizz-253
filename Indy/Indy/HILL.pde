unsigned long startTime = 0;
boolean CH_init = false;
unsigned long pulseStartTime = 0;

void CH_setup()
{
  if(!CH_init)
  {
    CH_init = true;
    minDist = -1;
    maxDist = -1;
    startTime = 0;
    passedHill = false;
    LCD_FREQ = 100;
    baseSpeed = HILL_SPEED;
    
    setRetrieverTo(RETRIEVER_WITHDRAWN);
    setCollectorTo(COLLECTOR_DOWN);
    
//    motor.speed(LEFT_MOTOR, -100);
//    motor.speed(RIGHT_MOTOR, -100);
//    delay(100);
//    
//    motor.speed(LEFT_MOTOR, HILL_SPEED);
//    motor.speed(RIGHT_MOTOR, HILL_SPEED);
  }
}

void CH_exit()
{
  CH_init = false;
  LCD_FREQ = LCD_FREQ_DEFAULT;
  baseSpeed = FLAT_SPEED;
}

///===========MAIN CODE

void checkOnHill()
{
  senseHeight();
  if(distance <= ON_HILL)
  {
//    LCD.clear();
//    LCD.home();
//    LCD.print("HILL!");
//    delay(500);
    ChangeToState(CLIMB_HILL);
//    hillCount++;
  }
}

void checkOffHill()
{
  senseHeight();
  if(!passedHill && distance >= OFF_HILL)
  {
    passedHill = true;
    startTime = millis();    
    LCD.clear();
    LCD.home();
    LCD.print("OFF HILL!");
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
   senseHeight();
  if(distance >= DANGER_HEIGHT)
  {
//    ChangeToState();
  }
}

/* Measures the distance from the ULS sensor */
void senseHeight()
{
  if(millis() - pulseStartTime > 100)
  {
  
    digitalWrite(TRIGGER, LOW);
    delayMicroseconds(2);
    
    digitalWrite(TRIGGER, HIGH);
    delayMicroseconds(10);
    
    digitalWrite(TRIGGER,LOW);
    duration = pulseIn(ECHO,HIGH);
    
    pulseStartTime = millis();
    
    distance = (duration/58.2);
    if(distance < minDist || minDist == -1)
    {
      minDist = distance;
    }
    if(distance > maxDist || maxDist == -1)
    {
      maxDist = distance;
    }
  }
}

void calibrateHeight()
{
  motor.stop_all();
  senseHeight();
}

void hill_LCD()
{
//  LCD.print("D: "); LCD.print(distance);
//  LCD.setCursor(0,1); LCD.print(minDist);
//  LCD.setCursor(8,1); LCD.print(maxDist);
  LCD.print((int)leftQRD);
  LCD.setCursor(5,0);LCD.print((int)midQRD);
  LCD.setCursor(11,0);LCD.print((int)rightQRD);
  LCD.setCursor(0,1);LCD.print((int)controller.GetError());
  LCD.setCursor(5,1);LCD.print(maxDist);
}



