//need macro DEPOLY_SPEED
//digitalRead 3, 4? assign macros to these pins


//random setup function for variables that need to be reset everytime this script is called
boolean ZIP_init = false;

void ZIP_setup()
{
  if(!ZIP_init)
  {
    ZIP_init = true;
  }
}

void ZIP_exit()
{
  ZIP_init = false;
}

void swingZiplineArm()
{
  motor.speed(DEPLOY_MOTOR,DEPLOY_SPEED);

  if (ziplineHit())
  {
    ziplineGo();
  }

  else if(ziplineMiss())
  {
    ziplineTryAgain();
    swingZiplineArm();
  }
}

void ziplineGo()
{
  LCD.clear();
  LCD.home();
  LCD.print("YEEE");

  // stop arm
  motor.speed(DEPLOY_MOTOR,0);

  // retract servo, carabiner drops onto zipline
  RCServo2.write(90);
  delay(500);

  delay(500);
  // retract deployment arm
  motor.speed(DEPLOY_MOTOR,700);

  //start winching
  digitalWrite(WINCH_PIN,HIGH);

  while(digitalRead(ARM_STOP_PIN) == HIGH)
  {
    delay(15);
  }

  // chill at the bottom
  motor.speed(DEPLOY_MOTOR,0);
  
  delay(2000);
  digitalWrite(WINCH_PIN,LOW);

     //while(digitalRead(4) == HIGH)
     //{
     // delay(15);
     // }

}

void ziplineTryAgain()
{
  motor.speed(DEPLOY_MOTOR,0);
  motor.speed(DEPLOY_MOTOR,700);
  while(digitalRead(ARM_STOP_PIN) == HIGH)
  {
    delay(15);
  }  
  motor.speed(DEPLOY_MOTOR,0);

  // reverse to get closer to zipline
  // motor.speed(LEFT_MOTOR,-500);
  // motor.speed(RIGHT_MOTOR,-500);

  delay(2000);
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
}

