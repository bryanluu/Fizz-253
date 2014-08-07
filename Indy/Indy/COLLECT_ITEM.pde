void checkCollectorArm()
{
  if (digitalRead(COLLECTOR_PIN) == LOW)
  {
    ChangeToState(COLLECT_ITEM);
  }
}

// method to physically pick up

void collect()
{
  motor.stop_all();
  //  delay(200);

  delay(50);
  LCD.clear(); 
  LCD.home();
  LCD.setCursor(0,0); 
  LCD.print("Picking Up!");

//  if(itemCount == 0)
//  {
//    motor.speed(LEFT_MOTOR, -300);
//    motor.speed(RIGHT_MOTOR, -300);
//    delay(300);
//    motor.stop_all();
//  }

  setRetrieverTo(RETRIEVER_EXTEND);
  delay(10);

  setCollectorTo(COLLECTOR_DROP);
  delay(750);
  
  if(lastState==ROCKPIT) //Hold Idol While Ziplining
  {
    setCollectorTo(COLLECTOR_ROCK-15);
    return;
  }
  
  setCollectorTo(COLLECTOR_TOP);
  delay(800);
  

  
  for(int angle=RETRIEVER_EXTEND; angle>RETRIEVER_WITHDRAWN; angle--)
  {
    setRetrieverTo(angle);
    delay(5);
  }
  setRetrieverTo(RETRIEVER_WITHDRAWN);
  
  delay(200);
  setCollectorTo(COLLECTOR_DOWN);
  

  LCD.clear(); 
  LCD.home();
  LCD.print(++itemCount);
  LCD.setCursor(0,1);
  LCD.print("Collected");

  delay(300);
  setCollectorTo(COLLECTOR_DOWN);
}

void setRetrieverTo(int angle)
{
  RCServo0.write(angle);
}

void setCollectorTo(int angle)
{
  RCServo1.write(angle);
}

void delayFT(unsigned long delayTime)
{
  unsigned long delayStart = millis();
  do
  {
    readTape();
    followTape();
    delay(50);
  }while(millis()-delayStart < delayTime);
}
