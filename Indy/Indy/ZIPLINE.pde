int zipArmSpeed;
boolean ZIP_init = false;

void ZIP_setup()
{
  if(!ZIP_init)
  {
    ZIP_init = true;
  }
}

void ZIP_exit()
{
  ZIP_init = false;
}

//Ben, insert code here
void swingZiplineArm()
{
  
}

boolean ziplineHit()
{
  return digitalRead(ZIPLINE_HIT) == LOW;
}

boolean ziplineMiss()
{
  return digitalRead(ZIPLINE_MISS) == LOW;
}

void ziplineLCD()
{
}

