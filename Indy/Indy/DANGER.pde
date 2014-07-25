boolean DANGER_init = false;
  
void DANGER_setup()
{
  if(!DANGER_init)
  {
    DANGER_init = true;
    
    //INITIALIZATION
    
  }
}

void DANGER_exit()
{
  DANGER_init = false;
}

void lookForTape()
{
  if(controller.offTape())
  {
    sweepBackwards();
  }
}

void sweepBackwards()
{

}

void DANGER_LCD()
{
  LCD.print("Looking for");
  LCD.setCursor(0,1); LCD.print("Tape...");
}

void watchForEdge()
{
  if (distance >= DANGER_HEIGHT)
  {
    ChangeToState(DANGER);
  }
}
