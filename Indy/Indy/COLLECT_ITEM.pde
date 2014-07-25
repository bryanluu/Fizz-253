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
  LCD.clear(); LCD.home();
  LCD.setCursor(0,0); LCD.print("Picking Up!");
  
  if(itemCount == 0)
  {
    motor.speed(LEFT_MOTOR, -280);
    motor.speed(RIGHT_MOTOR, -280);
    delay(500);
    motor.stop_all();
  }

  setRetrieverTo(RETRIEVER_EXTEND);
  delay(10);
  
  setCollectorTo(COLLECTOR_DROP);
  delay(2000);
  setCollectorTo(COLLECTOR_TOP);
  delay(2000);
  setRetrieverTo(RETRIEVER_WITHDRAWN);
  delay(1000);
  itemCount++;
  setCollectorTo(COLLECTOR_DOWN);
  
  LCD.clear(); LCD.home();
  LCD.print(itemCount);
  LCD.setCursor(0,1);
  LCD.print("Collected");
  
  
  if(itemCount == 3)
  {
    LCD.clear(); LCD.home();
    LCD.print("GOING HOME!");
    
    goingHome = true;
    
    turnAround();
    delay(200);
    do
    {
      readTape();
    }while(controller.offTape());
    
  }
  
}

void setRetrieverTo(int angle)
{
  RCServo0.write(angle);
}

void setCollectorTo(int angle)
{
  RCServo1.write(angle); 
}



