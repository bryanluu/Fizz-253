void printLCD()
{
  if (LCDcounter >= LCD_STATE_FREQ)
  {
    if (LCDcounter % LCD_FREQ == 0) // display only a certain amount, prevents from flashing too fast
    {
      if(LCDcounter > LCD_STATE_FREQ + LCD_STATE_DUR)
      {
        LCDcounter = 0;
      }
    
      LCD.clear();LCD.home();
      LCD.setCursor(0,0);
      
      LCD.print("STATE:");
      LCD.setCursor(0,1);
      LCD.print("{" + GetStateName(currentState) + "}");
    }
  }
  else if (LCDcounter % LCD_FREQ == 0)
  {
    LCD.clear();LCD.home();
    LCD.setCursor(0,0);
    
    switch (currentState)
    {
      case INITIALIZING:
        LCD.print("Press START");
        LCD.setCursor(0,1);
        LCD.print("to begin...");
        break;
      case FOLLOW_TAPE:
        tapeFollowingLCD();
        break;
      case COLLECT_ITEM:
        break;
      case CLIMB_HILL:
        break;
      case ROCKPIT:
        break;
      case ESCAPING:
        break;
      case FINISHED:
        break;
      case MENU:
        menuLCD();
        break;
      default:
        break;
    }
  }

  LCDcounter++;
}
