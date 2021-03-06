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
    startTime = millis(); 
    //    hillCount++;
  }
}

void checkOffHill()
{
  senseHeight();
  if(!passedHill && distance >= OFF_HILL && (millis()-startTime>1000)) //needs 2 seconds on the hill
  {
    passedHill = true;   
    LCD.clear();
    LCD.home();
    LCD.print("OFF HILL!");
    
    motor.speed(LEFT_MOTOR, -100);
    motor.speed(RIGHT_MOTOR, -100);
    delay(100);
    
    ChangeToState(COLLECT_ITEM);
  }

//  if(passedHill)
//  {
//    if(distance <= FLAT_GROUND)
//    {
//      motor.stop(LEFT_MOTOR);
//      motor.stop(RIGHT_MOTOR);
//      collect();
//      ChangeToState(FOLLOW_TAPE);
//    }
//  }
}



/* Measures the distance from the ULS sensor */
void senseHeight()
{
  // 60 milliseconds between pulses
  if(millis() - pulseStartTime > 60)
  {

    digitalWrite(TRIGGER, LOW);
    delayMicroseconds(2);

    digitalWrite(TRIGGER, HIGH);
    delayMicroseconds(10);

    digitalWrite(TRIGGER,LOW);
    //Time out of 3000 microseconds == 51 dist
    duration = pulseInCapped(ECHO,HIGH,5000);

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
  LCD.print((int)distance);
  LCD.setCursor(0,1);
//  LCD.print((int)controller.GetError());
  LCD.print(minDist);
  LCD.setCursor(5,1);
  LCD.print(maxDist);
}

unsigned long pulseInCapped(int pinNum, int state, unsigned long capTime)
{
  if(state != LOW && state != HIGH)
  {
    return -1;
  }
  
  while(digitalRead(pinNum) != state){}
  unsigned long pulseStart = micros();
  while(!(digitalRead(pinNum) != state || micros()-pulseStart > capTime)){} //caps out at a certain specified time
  return micros()-pulseStart;
}


