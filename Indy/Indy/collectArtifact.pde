void collectArtifact()
{
    if (digitalRead(COLLECTOR_PIN) == LOW && collect_flag)
    {
    collect();
    collect_flag = false;
    }
    collect_flag = true;
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
  
  for(i=45; i<181;i++){
    RCServo0.write(i);
    delay(10);
  }
  
  RCServo1.write(230);
  delay(2000);
  RCServo1.write(65);
  delay(2000);
  
  for(i=180; i>44; i--){
      RCServo0.write(i);
  }
  delay(1000);
  RCServo1.write(175);
}
