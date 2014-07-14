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
  motor.speed(LEFT_MOTOR, 0);
  motor.speed(RIGHT_MOTOR, 0);
  delay(200);
  
  int i = 0;
  delay(50);
  LCD.clear(); LCD.home();
  LCD.setCursor(0,0); LCD.print("Picking Up!");
  
  

  setRetrieverTo(RETRIEVER_EXTEND);
  delay(10);
  setCollectorTo(COLLECTOR_DROP);
  delay(2000);
  setCollectorTo(COLLECTOR_TOP);
  delay(2000);
  setRetrieverTo(RETRIEVER_WITHDRAWN);
  delay(1000);
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


