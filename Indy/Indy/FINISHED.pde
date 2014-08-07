void FIN_setup()
{
  motor.stop_all();
}

void rollCredits()
{
  LCD.clear();
  LCD.home();
  LCD.print("Credits...");
  delay(2000);
  
  LCD.clear();
  LCD.home();
  LCD.print("Bryan Luu");
  LCD.setCursor(0,1);
  LCD.print("(Software Lead)");
  delay(3000);
  
  LCD.clear();
  LCD.home();
  LCD.print("Ben Mattison");
  LCD.setCursor(0,1);
  LCD.print("(Mech Lead)");
  delay(3000);
  
  LCD.clear();
  LCD.home();
  LCD.print("Conrad Ng");
  LCD.setCursor(0,1);
  LCD.print("(Elec Lead)");
  delay(3000);
  
  LCD.clear();
  LCD.home();
  LCD.print("Kevin Multani");
  LCD.setCursor(0,1);
  LCD.print("(EM Integration)");
  delay(3000);
  
  LCD.clear();
  LCD.home();
  LCD.print("Thank you!");
  delay(3000);
  
  ChangeToState(MENU);
}
