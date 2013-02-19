//	@file Version: 1.0
//	@file Name: missionDefines.sqf
//	@file Author: [404] Deadbeat
//	@file Created: 08/12/2012 15:19

//Special Mission Colour = #EE11BB - Pink 
//Fail Mission Colour = #FF1717 - Light red
//Fail Mission Colour = #17FF41 - Light green
//Sub Colour = #FFF - White
#include "setup.sqf"
#ifdef __DEBUG__

	#define specialMissionTimeout 1000
	#define specialMissionDelayTime 5

#else

	#define specialMissionTimeout 3600
	#define specialMissionDelayTime 1800

#endif

#define missionRadiusTrigger 50
#define specialMissionColor "#EE11BB"
#define failMissionColor "#FF1717"
#define successMissionColor "#17FF41"
#define subTextColor "#FFFFFF"