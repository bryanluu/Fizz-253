/*This state is for testing TINAH and the general systems of INDY*/
void test()
{
  leftSpeed = (int)map(knob(6), 0, 1023, -1023, 1023);  
  rightSpeed = (int)map(knob(7), 0, 1023, -1023, 1023);
  
  leftSpeed = constrain(leftSpeed, -1023, 1023);
  rightSpeed = constrain(rightSpeed, -1023, 1023);
  
  motor.speed(LEFT_MOTOR, leftSpeed);
  motor.speed(RIGHT_MOTOR, rightSpeed);
  
//  if(startbutton())
//  {
//    digitalWrite(HIGH);
//  }
}

void testLCD()
{
  LCD.print((int)leftSpeed);
  LCD.setCursor(5,0);LCD.print((int)rightSpeed);
}

