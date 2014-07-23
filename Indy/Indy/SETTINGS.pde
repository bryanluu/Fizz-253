/*This state is for adjusting the settings of INDY*/
boolean SETTINGS_init = false;
enum Setting { FLATSPEED, FT_KP, FT_KD, HILLSPEED, CH_ON_HILL, CH_OFF_HILL, ROCKSPEED, RP_KP, RP_KD, NO_SETTING };
Setting settingChoice = NO_SETTING;
Setting currentSetting = NO_SETTING;
double value;

void SETTINGS_setup()
{
  if(!SETTINGS_init)
  {
    SETTINGS_init = true;
    settingChoice = NO_SETTING;
    currentSetting = NO_SETTING;
    motor.stop_all();
    delay(200);
  }
}

void SETTINGS_exit()
{
  SETTINGS_init = false;
  delay(200);
}

void updateSettings()
{
  if (currentSetting == NO_SETTING)
  {
    settingChoice = (Setting)((int)(map(knob(6), 0, 1023, 0, NO_SETTING)));
    settingChoice = (Setting)constrain(settingChoice, 0, NO_SETTING-1);
    
    if(startbutton())
    {
      LCD.clear(); LCD.print("...");
      currentSetting = settingChoice;
      delay(500);
    }
  }
  else
  {
  
    switch(currentSetting)
    {
      case CH_ON_HILL:
      case CH_OFF_HILL:
        value = map(knob(6), 0, 1023, 0, 10.0);
        break;
      default:
        value = knob(6);
        break;
    }
    
    if (startbutton())
    {
      switch(currentSetting)
      {
        case FLATSPEED:
          FLAT_SPEED = (int)value;
          break;
        case FT_KP:
          kP = (int)value;
          break;
        case FT_KD:
          kD = (int)value;
          break;
        case HILLSPEED:
          HILL_SPEED = (int)value;
          break;
        case CH_ON_HILL:
          ON_HILL = value;
          break;
        case CH_OFF_HILL:
          OFF_HILL = value;
          break;
        case ROCKSPEED:
          ROCK_SPEED = (int)value;
          break;
        case RP_KP:
          beacon_kP = (int)value;
          break;
        case RP_KD:
          beacon_kD = (int)value;
          break;
        default:
          break;
      }
      
      //Notify that setting has been set
      LCD.clear();
      LCD.home();
      LCD.print(GetSettingName(currentSetting));
      LCD.setCursor(0,1); LCD.print(" set to:");LCD.print(value);
      
      delay(1000);
      
      currentSetting = NO_SETTING;
    }
  }
}

///////SETTINGS LCD/////////

void settings_LCD()
{
  switch(currentSetting)
  {
    case NO_SETTING:
      LCD.print("Set: "); LCD.print(GetSettingName(settingChoice)); 
      LCD.setCursor(0,1); LCD.print("("); LCD.print(GetSettingValue(settingChoice)); LCD.print(")");
      break;
    default:
      LCD.print("Adjust:");
      LCD.setCursor(0,1);
      LCD.print(GetSettingName(currentSetting)); LCD.print(": "); LCD.print(value);
  }
}

String GetSettingName(int settingAsInt)
{
  Setting setting = (Setting)settingAsInt;
  switch(setting)
  {
    case FLATSPEED:
      return "Flat Speed";
    case FT_KP:
      return "FT kP";
    case FT_KD:
      return "FT kD";
    case HILLSPEED:
      return "Hill Speed";
    case CH_ON_HILL:
      return "On Hill";
    case CH_OFF_HILL:
      return "Off Hill";
    case ROCKSPEED:
      return "Rock Speed";
    case RP_KP:
      return "Beacon kP";
    case RP_KD:
      return "Beacon kD";
    default:
      return "INVALID";
  }
}

double GetSettingValue(int settingAsInt)
{
  Setting setting = (Setting)settingAsInt;
  switch(setting)
  {
    case FLATSPEED:
      return FLAT_SPEED;
    case FT_KP:
      return kP;
    case FT_KD:
      return kD;
    case HILLSPEED:
      return HILL_SPEED;
    case CH_ON_HILL:
      return ON_HILL;
    case CH_OFF_HILL:
      return OFF_HILL;
    case ROCKSPEED:
      return ROCK_SPEED;
    case RP_KP:
      return beacon_kP;
    case RP_KD:
      return beacon_kD;
    default:
      return 1337;
  }
}

