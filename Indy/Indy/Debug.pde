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
  
  Serial.print("kP: ");
  Serial.print(kP);
  Serial.print(", ");
  Serial.print("kD: ");
  Serial.print(kD);
  Serial.print(", ");
  
  Serial.print("Error: ");
  Serial.print(controller.GetError());
  Serial.print(", ");
  Serial.print("Steer Output: ");
  Serial.print(steerOutput);
  Serial.print(", ");
  
  Serial.print("Left Speed: ");
  Serial.print(leftSpeed);
  Serial.print(", ");
  Serial.print("Right Speed: ");
  Serial.print(rightSpeed);
  Serial.print(", ");
  
  Serial.print('\n');
}



