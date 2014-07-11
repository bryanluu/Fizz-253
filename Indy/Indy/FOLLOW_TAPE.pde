

void readTape()
{
  leftQRD = analogRead(LEFT_QRD_PIN);
  rightQRD = analogRead(RIGHT_QRD_PIN);

  kP = knob(6);
  baseSpeed= knob(7);
}

void followTape()
{

  controller.Compute();


  rightSpeed = baseSpeed+steerOutput;
  leftSpeed = baseSpeed-steerOutput;

  leftSpeed = constrain(leftSpeed, -1023, 1023);
  rightSpeed = constrain(rightSpeed, -1023, 1023);


  motor.speed(LEFT_MOTOR, leftSpeed);
  motor.speed(RIGHT_MOTOR, rightSpeed);
}

void tapeFollowingLCD()
{
    LCD.print((int)controller.GetError());
    LCD.setCursor(5,0);LCD.print(leftQRD);
    LCD.setCursor(11,0);LCD.print(rightQRD);
    LCD.setCursor(0,1);LCD.print("kP: ");LCD.print((int)kP);
    LCD.setCursor(8,1);LCD.print("bS: ");LCD.print(baseSpeed);
}
