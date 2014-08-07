//need macro DEPOLY_SPEED
//digitalRead 3, 4? assign macros to these pins


//random setup function for variables that need to be reset everytime this script is called
boolean ZIP_init = false;

void ZIP_setup()
{
  if(!ZIP_init)
  {
    ZIP_init = true;
    setZiplineDeployTo(DEPLOY_HOLD);
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
//    swingZiplineArm();
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
  setZiplineDeployTo(DEPLOY_RETRACT);
  delay(500);



  //start winching
  digitalWrite(WINCH_PIN,HIGH);
  //swag
  delay(5000);
  // retract deployment arm
  motor.speed(DEPLOY_MOTOR,700);

  while(digitalRead(ARM_STOP_PIN) == HIGH)
  {
    delay(15);
  }

  // chill at the bottom
  motor.speed(DEPLOY_MOTOR,0);
  
  delay(4000);
  digitalWrite(WINCH_PIN,LOW);


//  //hit start to reset the servo holding the carabiner in (instead of resetting TINAH)
//  LCD.clear(); LCD.home();
//  LCD.print("Press start...");
//  while(!startbutton()){
//    delay(15);
//  }
//  setZiplineDeployTo(DEPLOY_HOLD);
//     
//  ChangeToState(MENU);
  
  ChangeToState(FINISHED);
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
  motor.speed(LEFT_MOTOR,-600);
  motor.speed(RIGHT_MOTOR,-600);

  delay(300);
  
  motor.stop_all();
}

inline boolean ziplineHit()
{
  return digitalRead(ZIPLINE_HIT) == LOW;
}

inline boolean ziplineMiss()
{
  return digitalRead(ZIPLINE_MISS) == LOW;
}

void ziplineLCD()
{
}

void setZiplineDeployTo(int angle)
{
  RCServo2.write(angle);
}

