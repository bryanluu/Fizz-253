enum Stage { FOLLOWING_LINE, TRAVERSING_ROCKPIT, ESCAPING };
Stage ROBOT_STATE = TRAVERSING_ROCKPIT;

public void setup()
{
	attachInterrupt(EDGE_DETECTOR_PIN, ReverseFromCliff});
}

public void ReverseFromCliff()
{
	while(edgeDetected())
	{
		LeftMotor(-MAX_SPEED);
		RightMotor(-MAX_SPEED);
	}

	if (ROBOT_STATE == TRAVERSING_ROCKPIT)
	{
		lookForBeacon();

		while(!beaconSignalDetected())
		{
			LeftMotor(-SLOW_SPEED);
			RightMotor(-SLOW_SPEED);

			if (beaconSignal < THRESHOLD)
			{
				break;
			}
		}
	}
	else
	{
		int startTime = millis();
		while(millis() - startTime > 1000)
		{
			LeftMotor(-SLOW_SPEED);
			RightMotor(-SLOW_SPEED);
		}
	}

}