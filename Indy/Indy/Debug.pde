void printDebug()
{
  Serial.print("======TIME: ");
  Serial.print(millis());
  Serial.print("======\n");
  
  Serial.print("Left QRD: ");
  Serial.print(leftQRD);
  Serial.print(", ");
  Serial.print("Right QRD: ");
  Serial.print(rightQRD);
  Serial.print("\n");
  
  Serial.print("kP: ");
  Serial.print(kP);
  Serial.print(", ");
  Serial.print("kD: ");
  Serial.print(kD);
  Serial.print("\n");
  
  Serial.print("Error: ");
  Serial.print(controller.GetError());
  Serial.print(", ");
  Serial.print("Steer Output: ");
  Serial.print(steerOutput);
  Serial.print("\n");
  
  Serial.print("Left Speed: ");
  Serial.print(leftSpeed);
  Serial.print(", ");
  Serial.print("Right Speed: ");
  Serial.print(rightSpeed);
  Serial.print("\n");
}



