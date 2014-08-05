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

      LCD.clear();
      LCD.home();

      LCD.print("STATE:");
      LCD.setCursor(0,1);
      LCD.print("{" + GetStateName(currentState) + "}");
    }
  }
  else if (LCDcounter % LCD_FREQ == 0)
  {
    LCD.clear();
    LCD.home();

    switch (currentState)
    {
    case INITIALIZING:
      INIT_LCD();
      //        LCD.print(LCDcounter);
      break;
    case FOLLOW_TAPE:
      tapeFollowingLCD();
      break;
    case COLLECT_ITEM:
      break;
    case CLIMB_HILL:
      //        tapeFollowingLCD();
      hill_LCD();
      break;
    case ROCKPIT:
      rockpit_LCD();
      break;
    case ZIPLINE:
      ziplineLCD();
      break;
    case FINISHED:
      break;
    case TEST:
      testLCD();
      break;
    case SETTINGS:
      settings_LCD();
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

