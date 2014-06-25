#include "StandardCalc.h"

void boundValueBetween(double* value, double lowerBound, double higherBound)
{
	if (*value < lowerBound)
		*value = lowerBound;
	else if (*value > higherBound)
		*value = higherBound;
}