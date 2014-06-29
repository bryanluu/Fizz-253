enum Stage { FOLLOWING_LINE, TRAVERSING_ROCKPIT, ESCAPING };
Stage ROBOT_STATE = FOLLOWING_LINE;

public void loop()
{
	if(collectorArmIsTouched())
	{
		CollectItem();
	}
	
}

public void CollectItem()
{
	setServoAngle(90);

	while(getServoAngle() < 90)
	{
		turnOnEM();
	}
	//exits when arm is all the way up

	delay(100);
	turnOffEM();
	delay(100);
	setServoAngle(0);
}