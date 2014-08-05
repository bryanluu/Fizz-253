boolean FT_init = false;

void FT_setup()
{
  if(!FT_init)
  {
    FT_init = true;

    //INITIALIZATION
    LCD_FREQ = 100;
    if(!goingHome)
    {
      baseSpeed = FLAT_SPEED;
    }
    else
    {
      baseSpeed = FLAT_SPEED-50;
    }
    hillCount = 0;
    minDist = -1;
    maxDist = -1;
    setRetrieverTo(RETRIEVER_WITHDRAWN);

    if(itemCount==0)
    {
      setCollectorTo(COLLECTOR_START);
    }
    else if (goingHome)
    {
      setCollectorTo(COLLECTOR_TOP);
    }
    else
    {
      setCollectorTo(COLLECTOR_DOWN);
    }

    if(lastState == COLLECT_ITEM && currentStrat == FullCourse && passedHill)
    {
      baseSpeed = ROCK_SPEED;
    }
  }
}

void FT_exit()
{
  FT_init = false;
  LCD_FREQ = LCD_FREQ_DEFAULT;
}

///===========MAIN CODE

void readTape()
{
  leftQRD = analogRead(LEFT_QRD_PIN);
  midQRD = analogRead(MID_QRD_PIN);
  rightQRD = analogRead(RIGHT_QRD_PIN);

  //  kP = knob(6);
  //  kD = knob(7);

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
  LCD.setCursor(5,0);
  LCD.print((int)midQRD);
  LCD.setCursor(11,0);
  LCD.print((int)rightQRD);
  LCD.setCursor(0,1);
  LCD.print((int)controller.GetError());
  LCD.setCursor(5,1);
  LCD.print(minDist);
}

