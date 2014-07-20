RobotState menuChoice;
boolean MENU_init = false;

void MENU_setup()
{
  if(!MENU_init)
  {
    MENU_init = true;
    motor.stop_all();
    delay(200);
  }
}

void MENU_exit()
{
  MENU_init = false;
  delay(200);
}

///===========MAIN CODE

void updateMenu()
{
  
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

