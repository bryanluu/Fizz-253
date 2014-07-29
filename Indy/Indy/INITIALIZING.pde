boolean INIT_init = false;
Strategy choice = FullCourse;
boolean loaded = false;
  
void initializeChallenge()
{
  motor.stop_all();
  passedHill = false; // Resets the Hill Pass flag when set back to INIT
  itemCount = 0;
  goingHome = false;
}

void INIT_exit()
{
  INIT_init = false;
}

void INIT_update()
{
  if(!INIT_init)
  {
    INIT_init = true;
    
    //INITIALIZATION
    
    if(!loaded && hasSavedSettings())
    {
      LoadSettings();
    }
    
    initializeChallenge();
    
    LCD.clear();
    LCD.home();
    LCD.print("Press START");
    LCD.setCursor(0,1);
    LCD.print("to begin...");
    delay(1000);
  }
  
  choice = (Strategy)((int)(map(knob(6), 0, 1023, 0, OnlyIdolZip+1)));
  choice = (Strategy)constrain(choice, 0, OnlyIdolZip);
  if(startbutton())
  {
    currentStrat = choice;
    ChangeToState(FOLLOW_TAPE);
    LCD.clear();
    LCD.home();
    LCD.print("Going for...");
    LCD.setCursor(0,1);
    LCD.print(GetStratString(currentStrat));
    delay(1000);
  }
}

void INIT_LCD()
{
  LCD.print("Choose Strategy:");
  LCD.setCursor(0,1);
  LCD.print(GetStratString(choice));
}

String GetStratString(int stratAsInt)
{
  Strategy strat = (Strategy)stratAsInt;
  switch(strat)
  {
    case FullCourse:
      return "Full Course";
    case OnePoint:
      return "1 Pt";
    case TwoPoints:
      return "2 Pts";
    case ThreePoints:
      return "3 Pts";
    case OnlyIdolGround:
      return "Idol via Gnd";
    case OnlyIdolZip:
      return "Idol via Zip";
    default:
      return "INVALID";
  }
}
