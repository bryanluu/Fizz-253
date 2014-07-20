RobotState menuChoice;

void updateMenu()
{
  motor.stop_all();
  
  menuChoice = (RobotState)((int)(map(knob(6), 0, 1023, 0, MENU)));
  
  menuChoice = (RobotState)constrain(menuChoice, 0, MENU-1);
  
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

