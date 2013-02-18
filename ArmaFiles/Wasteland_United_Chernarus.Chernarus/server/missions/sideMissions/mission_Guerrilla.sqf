//	@file Version: 1.0
//	@file Name: mission_Guerrilla.sqf
//	@file Author: Mabluz
//	@file Created: 16/02/2013 23:55
//	@file Args:
#include "setup.sqf"
#include "sideMissionDefines.sqf";

if(!isServer) exitwith {};

private ["_result","_missionMarkerName","_missionType","_startTime","_returnData","_randomPos","_randomIndex","_vehicleClass","_box","_box2","_picture","_vehicleName","_hint","_currTime","_playerPresent","_unitsAlive","_currentCalloutAlive"];

//Mission Initialization.
_result = 0;
_missionMarkerName = "WeaponCache_Marker";
_missionType = "Guerrilla Infiltration Squad";
#ifdef __A2NET__
_startTime = floor(netTime);
#else
_startTime = floor(time);
#endif

diag_log format["WASTELAND SERVER - Side Mission Started: %1",_missionType];

//Get Mission Location
_returnData = call createMissionLocation;
_randomPos = _returnData select 0;
_randomIndex = _returnData select 1;

diag_log format["WASTELAND SERVER - Side Mission Waiting to run: %1 in %2 min",_missionType, sideMissionDelayTime / 60];
[sideMissionDelayTime] call createWaitCondition;
diag_log format["WASTELAND SERVER - Side Mission Resumed: %1",_missionType];

[_missionMarkerName,_randomPos,_missionType] call createClientMarker;

_hint = parseText format ["<t align='center' color='%2' shadow='2' size='1.75'>Side Objective</t><br/><t align='center' color='%2'>------------------------------</t><br/><t align='center' color='%3' size='1.25'>%1</t><br/><t align='center' color='%3'>A guerrilla squad has been spotted near the marker</t>", _missionType,  sideMissionColor, subTextColor];
[nil,nil,rHINT,_hint] call RE;

CivGrpS = createGroup civilian;
[CivGrpS,_randomPos] spawn createRandomGroup;
_currentCalloutAlive = 100; // Big dummy number to show remaining guerrillas before anyone is killed

diag_log format["WASTELAND SERVER - Side Mission Waiting to be Finished: %1",_missionType];
#ifdef __A2NET__
_startTime = floor(netTime);
#else
_startTime = floor(time);
#endif
waitUntil
{
    sleep 1; 
	_playerPresent = false;
	#ifdef __A2NET__
	_currTime = floor(netTime);
	#else
    _currTime = floor(time);
	#endif
    if(_currTime - _startTime >= sideMissionTimeout) then {_result = 1;};
    {if((isPlayer _x) AND (_x distance _randomPos <= missionRadiusTrigger)) then {_playerPresent = true};}forEach playableUnits;
    _unitsAlive = ({alive _x} count units CivGrpS);
    if(_currentCalloutAlive > _unitsAlive) then
    {
        if(_currentCalloutAlive == 100) then
        {
            sleep 5;
        };
        _currentCalloutAlive = _unitsAlive;
        _hint = parseText format ["<t align='center' color='%2' shadow='2' size='1.75'>Guerrilla remaning: %1</t>", _unitsAlive, subTextColor];
        [nil,nil,rHINT,_hint] call RE;
    };
    (_result == 1) OR ((_playerPresent) AND (_unitsAlive < 1))
};

if(_result == 1) then
{
	//Mission Failed.
    //Delete units that are still alive, leave dead ones
    {
        if(alive _x) then
        {
            deleteVehicle _x;
        };
    }forEach units CivGrps;
    deleteGroup CivGrpS;

    _hint = parseText format ["<t align='center' color='%2' shadow='2' size='1.75'>Objective Failed</t><br/><t align='center' color='%2'>------------------------------</t><br/><t align='center' color='%2' size='1.25'>%1</t><br/><t align='center' color='%3'>Objective failed, better luck next time</t>", _missionType, failMissionColor, subTextColor];
	[nil,nil,rHINT,_hint] call RE;
    diag_log format["WASTELAND SERVER - Side Mission Failed: %1",_missionType];
} else {
	//Mission Complete.
    deleteGroup CivGrpS;
    _hint = parseText format ["<t align='center' color='%2' shadow='2' size='1.75'>Objective Complete</t><br/><t align='center' color='%2'>------------------------------</t><br/><t align='center' color='%3' size='1.25'>%1</t><br/><t align='center' color='%3'>The guerrilla squad has been killed. Well done team</t>", _missionType, successMissionColor, subTextColor];
	[nil,nil,rHINT,_hint] call RE;
    diag_log format["WASTELAND SERVER - Side Mission Success: %1",_missionType];
};

//Reset Mission Spot.
MissionSpawnMarkers select _randomIndex set[1, false];
[_missionMarkerName] call deleteClientMarker;