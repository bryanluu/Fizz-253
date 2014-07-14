#include <phys253.h>
#include <servo253.h>
#include <LiquidCrystal.h>

#define TRIGGER 8
#define ECHO 7

int maxRange = 35; //max distance in centimeters
double onHill = 3.6;
double offHill = 5.5;
double duration;

void setup() 
{
  portMode(1, OUTPUT) ;      	 	
  portMode(0, INPUT);   

  pinMode(TRIGGER, OUTPUT);
  pinMode(ECHO, INPUT);
  Serial.begin(9600);
  LCD.home();
}

void loop() 
{
  digitalWrite(TRIGGER, LOW);
  delayMicroseconds(2);
  
  digitalWrite(TRIGGER, HIGH);
  delayMicroseconds(10);
  
  digitalWrite(TRIGGER,LOW);
  duration = pulseIn(ECHO,HIGH);
  
  //serialPrint();
  lcdPrint(duration);
   
  delay(100); 
  

}


// getting distance
double distance(double duration)
{
  return(duration/58.2);
}


// viewing methods
void serialPrint()
{
   Serial.println(distance(duration)); Serial.print(" cm");
}

void lcdPrint(long duration)
{
   if(distance(duration) > maxRange)
  {
    LCD.home();LCD.clear();
    LCD.print("OH SHEEEEEEEEEEEEEEE");
  }
 
 else if(distance(duration) <= onHill)
 {
   LCD.home();LCD.clear();
   LCD.print("JONAH HILL");
   delay(2000);
   return;
 }
 
  else if(distance(duration) >= offHill)
 {
   LCD.home();LCD.clear();
   LCD.print("NO JONAH HILL");
   delay(2000);
   return;
 }
  
 else
  { 
    LCD.home();LCD.clear();
    LCD.setCursor(0,0);
    LCD.print("YEEEE");
    LCD.setCursor(0,1);
    LCD.print(distance(duration));
    LCD.setCursor(6  ,1);
    LCD.print("cm");
  }  
}
