comment "Check if there is time left.";
_timeLeft = 3;
if (_timeLeft < 2) then
{
	hint "Hurry up, only a few minutes remaining!";
} else {
	hint "Plenty of time left.";
};