void printDebug()
{
  Serial.print("Current: ");
  Serial.print(GetStateName(currentState));  
  Serial.print(", ");
  Serial.print("Last: ");
  Serial.print(GetStateName(lastState));  
  Serial.print(", ");
  
  Serial.print("Left QRD: ");
  Serial.print(leftQRD);
  Serial.print(", ");
  Serial.print("Right QRD: ");
  Serial.print(rightQRD);
  Serial.print(", ");
  
  Serial.print("Left IR: ");
  Serial.print(leftIR);
  Serial.print(", ");
  Serial.print("Right IR: ");
  Serial.print(rightIR);
  Serial.print(", ");
  
  Serial.print("Left Speed: ");
  Serial.print(leftSpeed);
  Serial.print(", ");
  Serial.print("Right Speed: ");
  Serial.print(rightSpeed);
  Serial.print(", ");
  
  Serial.print('\n');
}



