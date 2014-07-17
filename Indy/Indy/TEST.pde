/*This state is for testing TINAH and the general systems of INDY*/

void testMotors()
{
  motor.speed(LEFT_MOTOR, 0);
  motor.speed(RIGHT_MOTOR, 0);
  
  delay(500);
  LCD.clear();
  LCD.home();
  LCD.print("Testing Motors");
  
  
  delay(500);
  
  motor.speed(LEFT_MOTOR, 1023);
  motor.speed(RIGHT_MOTOR, 1023);
  
  delay(500);
  
  motor.speed(LEFT_MOTOR, -1023);
  motor.speed(RIGHT_MOTOR, -1023);
  
  delay(500);
  
  motor.speed(LEFT_MOTOR, 0);
  motor.speed(RIGHT_MOTOR, 0);
}

void testCollectorArm()
{
  
  delay(500);
  
  LCD.clear();
  LCD.home();
  LCD.print("Testing");
  LCD.setCursor(0,1); LCD.print("Collector");
  
  delay(500);
  
  if(digitalRead(COLLECTOR_PIN) == HIGH)
  {
    LCD.print("Collector");
    LCD.setCursor(0,1); LCD.print("Not Connected!");
  }
  else
  {
    setCollectorTo(COLLECTOR_DOWN);
    delay(500);
    setCollectorTo(COLLECTOR_DROP);
    delay(500);
    setCollectorTo(COLLECTOR_TOP);
    delay(500);
    setCollectorTo(COLLECTOR_DOWN);
    delay(500);
  }
  
  delay(500);
  
  LCD.print("Testing");
  LCD.setCursor(0,1); LCD.print("Retriever");
  
  setRetrieverTo(RETRIEVER_EXTEND);
  delay(500);
  setRetrieverTo(RETRIEVER_WITHDRAWN);
  delay(500);
}


