#include "StandardCalc.h"


void StandardCalc::boundValueBetween(double* value, const double &lowerBound, const double &higherBound)
{
	if (*value < lowerBound)
		*value = lowerBound;
	else if (*value > higherBound)
		*value = higherBound;
	return;
}
