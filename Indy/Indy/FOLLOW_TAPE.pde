void readTape()
{
  leftQRD = analogRead(LEFT_QRD_PIN);
  midQRD = analogRead(MID_QRD_PIN);
  rightQRD = analogRead(RIGHT_QRD_PIN);

  kP = knob(6);
  kD = knob(7);

//  leftSpeed = (int)map(knob(6), 0, 1023, -1023, 1023);
//  rightSpeed = (int)map(knob(7), 0, 1023, -1023, 1023);
}

void followTape()
{

  controller.Compute();

//  switch((int)controller.GetError())
//  {
//    case 3:
//      rightSpeed = 900;
//      leftSpeed = -500;
//      break;
//    case -3:
//      rightSpeed = -500;
//      leftSpeed = 900;
//      break;
//    default:
//      rightSpeed = baseSpeed+steerOutput;
//      leftSpeed = baseSpeed-steerOutput;
//      break;
//  }

  rightSpeed = baseSpeed+steerOutput;
  leftSpeed = baseSpeed-steerOutput;

  leftSpeed = constrain(leftSpeed, -1023, 1023);
  rightSpeed = constrain(rightSpeed, -1023, 1023);

  motor.speed(LEFT_MOTOR, leftSpeed);
  motor.speed(RIGHT_MOTOR, rightSpeed);
}

void tapeFollowingLCD()
{
    LCD.print((int)leftQRD);
    LCD.setCursor(5,0);LCD.print((int)midQRD);
    LCD.setCursor(11,0);LCD.print((int)rightQRD);
    LCD.setCursor(0,1);LCD.print((int)controller.GetError());
    LCD.setCursor(5,1);LCD.print((int)kP);
    LCD.setCursor(11,1);LCD.print((int)kD);
}

