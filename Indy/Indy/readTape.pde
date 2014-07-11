void readTape(){
  leftQRD = analogRead(LEFT_QRD_PIN);
  rightQRD = analogRead(RIGHT_QRD_PIN);

  kP = knob(6);
  baseSpeed= knob(7);

  controller.Compute();


  rightSpeed = baseSpeed+steerOutput;
  leftSpeed = baseSpeed-steerOutput;

  StandardCalc::boundValueBetween(&leftSpeed, -1023, 1023);
  StandardCalc::boundValueBetween(&rightSpeed, -1023, 1023);


  motor.speed(LEFT_MOTOR, leftSpeed);
  motor.speed(RIGHT_MOTOR, rightSpeed);
}
