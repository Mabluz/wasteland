_x = 0;
for [{_p = 0},{_p < 10},{_p = _p + 1}] do
{
	_x = _p * 100 + _x;
};
hint format ["%1",_x];