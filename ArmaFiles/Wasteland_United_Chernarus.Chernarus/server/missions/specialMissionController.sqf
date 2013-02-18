//	@file Version: 1.0
//	@file Name: specialMissionController.sqf
//	@file Author: Dreadlord
//	@file Created: 02/18/2013 21:55
#include "setup.sqf"
#include "specialMissions\specialMissionDefines.sqf";

if(!isServer) exitWith {};

private ["_MMarray","_lastMission","_randomIndex","_mission","_missionType","_newMissionArray","_lastMission"];

diag_log format["WASTELAND SERVER - Started Special Mission State"];

//Main Mission Array
_MMarray = [
            [mission_Guerrilla,"mission_Guerrilla"]];
            
_lastMission = "nomission";
while {true} do
{
    //Select Mission
    _randomIndex = (random (count _MMarray - 1));
	_mission = _MMarray select _randomIndex select 0;
    _missionType = _MMarray select _randomIndex select 1;

	//Select new mission if the same
    if(str(_missionType) == _lastMission) then
    {
        _newMissionArray = _MMarray;
        _newMissionArray set [_randomIndex, "REMOVETHISCRAP"];
        _newMissionArray = _newMissionArray - ["REMOVETHISCRAP"];
        _randomIndex = (random (count _newMissionArray - 1));
        _missionType = _newMissionArray select _randomIndex select 1;
        _mission = _newMissionArray select _randomIndex select 0;    
    };
    
	_missionRunning = [] spawn _mission;
    diag_log format["WASTELAND SERVER - Execute New Special Mission: %1",_missionType];
    _hint = parseText format ["<t align='center' color='%2' shadow='2' size='1.75'>Special Objective</t><br/><t align='center' color='%2'>------------------------------</t><br/><t color='%3' size='1.0'>Starting in %1 Minutes</t>", specialMissionDelayTime / 60, specialMissionColor, subTextColor];
	[nil,nil,rHINT,_hint] call RE;
    _lastMission = _missionType;
	waitUntil{sleep 0.1; scriptDone _missionRunning};
    sleep 5; 
};