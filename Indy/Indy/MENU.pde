RobotState menuChoice;

void updateMenu()
{
  motor.speed(LEFT_MOTOR, 0);
  motor.speed(RIGHT_MOTOR, 0);
  
  menuChoice = (RobotState)((int)floor(map(knob(6), 0, 1023, 0, MENU)));
  
  if(startbutton())
  {
    ChangeToState(menuChoice);
  }
  
  if(stopbutton())
  {
    ChangeToState(lastState);
  }
}

void menuLCD()
{
  LCD.print("Choose State:");
  LCD.setCursor(0,1);
  LCD.print("{" + GetStateName(menuChoice) + "}");
}
