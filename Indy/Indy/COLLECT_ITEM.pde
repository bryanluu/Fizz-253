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
  
  
  RCServo0.write(180);
  delay(10);
  RCServo1.write(125);
  delay(2000);
  RCServo1.write(10);
  delay(2000);
  RCServo0.write(45)
  delay(1000);
  RCServo1.write(115);
}
