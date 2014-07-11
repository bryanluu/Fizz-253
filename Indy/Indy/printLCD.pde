void printLCD()
{
  if (LCDcounter > 10)
  {
    LCDcounter = 0;
  
    LCD.clear();LCD.home();
    LCD.setCursor(0,0);
    //LCD.print("Error: ");
    LCD.print(controller.GetError());
    LCD.setCursor(5,0);LCD.print(leftQRD);
    LCD.setCursor(11,0);LCD.print(rightQRD);
    LCD.setCursor(0,1);LCD.print("kP: ");LCD.print(kP);
    LCD.setCursor(8,1);LCD.print("bS: ");LCD.print(baseSpeed);
  }

  LCDcounter++;
}
