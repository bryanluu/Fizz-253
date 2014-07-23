boolean RP_init = false;
  
void RP_setup()
{
  if(!RP_init)
  {
    RP_init = true;
    
    //INITIALIZATION
    
    baseSpeed = ROCK_SPEED;
  }
}

void RP_exit()
{
  RP_init = false;
  baseSpeed = 0;
}

///===========MAIN CODE

void lookForBeacon()
{
  leftIR = analogRead(LEFT_IR);
  rightIR = analogRead(RIGHT_IR);
  
//  beacon_kP = knob(6);
  
  beaconAim.Compute();
}

void rockpit_LCD()
{
  LCD.print((int)beaconAim.GetError());
  LCD.setCursor(5,0);LCD.print((int)leftIR);
  LCD.setCursor(11,0);LCD.print((int)rightIR);
  LCD.setCursor(0,1);LCD.print("kP: ");LCD.print((int)beacon_kP);
}

