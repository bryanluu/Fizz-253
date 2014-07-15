RobotState menuChoice;

void updateMenu()
{
  motor.speed(LEFT_MOTOR, 0);
  motor.speed(RIGHT_MOTOR, 0);
  motor.speed(ZIPLINE_ARM, 0);
  
  menuChoice = (RobotState)((int)(map(knob(6), 0, 1023, 0, MENU-1)));
  
  if(startbutton())
  {
    ChangeToState(menuChoice);
  }
}

void menuLCD()
{
  LCD.print("Choose State:");
  LCD.setCursor(0,1);
  LCD.print("{" + GetStateName(menuChoice) + "}");
}
