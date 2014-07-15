/*This state is for testing TINAH and the general systems of INDY*/

void testMotors()
{
  LCD.print("Testing Motors");
  
  motor.speed(LEFT_MOTOR, 0);
  motor.speed(RIGHT_MOTOR, 0);
  
  delay(10);
  
  motor.speed(LEFT_MOTOR, 280);
  motor.speed(RIGHT_MOTOR, 280);
  
  delay(10);
  
  motor.speed(LEFT_MOTOR, -280);
  motor.speed(RIGHT_MOTOR, -280);
  
  delay(10);
  
  motor.speed(LEFT_MOTOR, 0);
  motor.speed(RIGHT_MOTOR, 0);
}
/*
void testCollectorArm()
{
  LCD.print("Testing");
  LCD.setCursor(0,1); LCD.print("Collector");
  
  if(digitalRead(COLLECTOR_PIN) == HIGH)
  {
    LCD.print("Collector");
    LCD.setCursor(0,1); LCD.print("Not Connected!");
  }
  else
  {
    setCollectorTo(COLLECTOR_DOWN);
    delay(10);
    setCollectorTo(COLLECTOR_DROP);
    delay(10);
    setCollectorTo(COLLECTOR_TOP);
    delay(10);
    setCollectorTo(COLLECTOR_DOWN);
    delay(10);
  }
  
  delay(10);
  
  LCD.print("Testing");
  LCD.setCursor(0,1); LCD.print("Retriever");
  
  setRetriever(RETRIEVER_EXTEND);
  delay(10);
  setRetriever(RETRIEVER_WITHDRAWN);
  delay(10);
}
*/

