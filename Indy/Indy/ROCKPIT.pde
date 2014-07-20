void lookForBeacon()
{
  leftIR = analogRead(LEFT_IR);
  rightIR = analogRead(RIGHT_IR);
  
  beacon_kP = knob(6);
  
  beaconAim.Compute();
}

void rockpit_LCD()
{
  LCD.print((int)beaconAim.GetError());
  LCD.setCursor(5,0);LCD.print((int)leftIR);
  LCD.setCursor(11,0);LCD.print((int)rightIR);
  LCD.setCursor(0,1);LCD.print("kP: ");LCD.print((int)beacon_kP);
}

