int zipArmSpeed;
boolean ZIP_init = false;

void ZIP_setup()
{
  if(!ZIP_init)
  {
    ZIP_init = true;
    zipArmSpeed = 100;
  }
}

void ZIP_exit()
{
  ZIP_init = false;
}

void testZipArm()
{
  zipArmSpeed = map(knob(6), 0, 1023, -1023, 1023);
  motor.speed(ZIPLINE_ARM, zipArmSpeed);
}

void swingZiplineArm()
{
  if(ziplineHit())
  {
    motor.speed(ZIPLINE_ARM, 0);
    LCD.print("Hit!");
    delay(50);
    ChangeToState(FINISHED);
  }
  else if(ziplineMiss())
  {
    motor.speed(ZIPLINE_ARM, -30);
    LCD.print("Miss...");
    delay(50);
    ChangeToState(lastState);
  }
  else
  {
    motor.speed(ZIPLINE_ARM, zipArmSpeed);
  }
  
  if(zipArmSpeed > 50)
  {
    zipArmSpeed -= 1;
  }
  
  
}

boolean ziplineHit()
{
  return digitalRead(ZIPLINE_HIT) == LOW;
}

boolean ziplineMiss()
{
  return digitalRead(ZIPLINE_MISS) == LOW;
}

void ziplineLCD()
{
  LCD.print("Zip Speed: ");
  LCD.setCursor(0,1);LCD.print(zipArmSpeed);
}

