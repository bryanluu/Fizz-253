void readTape()
{
  leftQRD = analogRead(LEFT_QRD_PIN);
  rightQRD = analogRead(RIGHT_QRD_PIN);

  kP = knob(6);
  kD = knob(7);
}

void followTape()
{

  controller.Compute();

  switch((int)controller.GetError())
  {
    case -2:
      rightSpeed = -260;
      leftSpeed = 920;
      break;
    case 2:
      rightSpeed = 920;
      leftSpeed = -260;
      break;
    default:
      rightSpeed = baseSpeed+steerOutput;
      leftSpeed = baseSpeed-steerOutput;
      break;
  }


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
    LCD.setCursor(0,1);LCD.print((int)kP);
    LCD.setCursor(5,1);LCD.print((int)leftSpeed);
    LCD.setCursor(11,1);LCD.print(rightSpeed);
}
