//	@file Version: 1.0
//	@file Name: randomGroup.sqf
//	@file Author: Mabluz
//	@file Created: 16/02/2012 23:13
//	@file Args:

if(!X_Server) exitWith {};


private ["_group","_pos","_personSelected","_mainWeaponSelected","_mainAmmoSelected","_mainWeaponIndexSelected","_secondaryWeaponSelected","_grenadeSelected","_smokeSelected","_personClass","_mainWeaponClass","_mainWeaponAmmoClass","_sniperWeaponClass","_sniperWeaponAmmoClass","_secondaryWeaponClass","_useSecondary","_grenadeWeaponClass","_useGrenades","_smokeWeaponClass","_useSmoke"];
_randomGroupSize = floor(random(10));

_personClass			= ["RUS_Soldier1","RUS_Soldier2","RUS_Soldier3","RUS_Soldier_GL","RUS_Soldier_Marksman","RUS_Soldier_Sab","RUS_Soldier_TL","RU_Soldier_Sniper","RU_Soldier_SniperH","RU_Soldier_Spotter"];

// mainweapon index and ammo index must match weapontype vs ammotype
_mainWeaponClass 		= ["M16A4", 				"AKS_74_kobra", 	"G36a",				"M249", 				"PK"];
_mainWeaponAmmoClass 	= ["30Rnd_556x45_Stanag", 	"30Rnd_545x39_AK", 	"30Rnd_556x45_G36",	"200Rnd_556x45_M249", 	"100Rnd_762x54_PK"];

_sniperWeaponClass 		= ["M40A3", 			"SVD_CAMO", 			"M107"];
_sniperWeaponAmmoClass 	= ["5Rnd_762x51_M24", 	"10Rnd_762x54_SVD",    "10Rnd_127x99_m107"];

_secondaryWeaponClass 	= ["Strela", "Igla", "Javelin", "M136", "RPG18", "Stinger"];
_grenadeWeaponClass		= ["HandGrenade", "HandGrenade_West", "HandGrenade_East", "TimeBomb", "PipeBomb", "Mine", "MineE", "HandGrenade_Stone"];
_smokeWeaponClass		= ["SmokeShell", "SmokeShellRed", "SmokeShellGreen", "SmokeShellYellow", "SmokeShellOrange", "SmokeShellPurple", "SmokeShellBlue"];

_group = _this select 0;
_pos = _this select 1;

// Always spawn 3 guerrillas (1 leader + 2 men) (max 10 persons)
if(_randomGroupSize < 3) then { _randomGroupSize = 2; };

diag_log format["Guerrillia grupsize: %1",_randomGroupSize];

private ["_leader","_man","_p"];

// Create the leader
_leader = _group createunit ["RUS_Commander", [(_pos select 0), _pos select 1, 0], [], 0.5, "Form"];
removeAllWeapons _leader;
_mainWeaponIndexSelected = random(count(_mainWeaponClass) - 1);
_mainWeaponSelected = _mainWeaponClass select _mainWeaponIndexSelected;
_mainAmmoSelected = _mainWeaponAmmoClass select _mainWeaponIndexSelected;
_leader addWeapon _mainWeaponSelected;
_leader addMagazine _mainAmmoSelected;
_leader addMagazine _mainAmmoSelected;
_leader addMagazine _mainAmmoSelected;
_secondaryWeaponSelected = _secondaryWeaponClass call BIS_fnc_selectRandom;
_leader addMagazine _secondaryWeaponSelected;
_leader addWeapon _secondaryWeaponSelected;

_grenadeSelected = _grenadeWeaponClass call BIS_fnc_selectRandom;
_leader addMagazine _grenadeSelected;
_leader addMagazine _grenadeSelected;

_smokeSelected = _smokeWeaponClass call BIS_fnc_selectRandom;
_leader addMagazine _smokeSelected;
_leader addMagazine _smokeSelected;

// Create the rest of the group
for [{_p = 1},{_p <= _randomGroupSize},{_p = _p + 1}] do
{
	_personSelected = _personClass call BIS_fnc_selectRandom;
	_man = _group createunit [_personSelected, [(_pos select 0) + (_p * 15), (_pos select 1) + (_p * 5), 0], [], 0.5, "Form"];
	sleep 0.3;
	removeAllWeapons _man;
	// Sniper spawned (sniper weapons, no secondary)
	if(_personSelected == "RU_Soldier_Sniper" OR _personSelected == "RU_Soldier_SniperH" OR _personSelected == "RU_Soldier_Spotter") then
	{
		_mainWeaponIndexSelected = random(count(_sniperWeaponClass) - 1);
		_mainWeaponSelected = _sniperWeaponClass select _mainWeaponIndexSelected;
		_mainAmmoSelected = _sniperWeaponAmmoClass select _mainWeaponIndexSelected;
		_man addWeapon _mainWeaponSelected;
		_man addMagazine _mainAmmoSelected;
		_man addMagazine _mainAmmoSelected;
		_man addMagazine _mainAmmoSelected;
	}
	else // Regular gunner spawned (machineguns, secondary)
	{
		_mainWeaponIndexSelected = random(count(_mainWeaponClass) - 1);
		_mainWeaponSelected = _mainWeaponClass select _mainWeaponIndexSelected;
		_mainAmmoSelected = _mainWeaponAmmoClass select _mainWeaponIndexSelected;
		_man addWeapon _mainWeaponSelected;
		_man addMagazine _mainAmmoSelected;
		_man addMagazine _mainAmmoSelected;
		_man addMagazine _mainAmmoSelected;

		_useSecondary = floor(random(51));
		if(_useSecondary >= 40) then // 20% chance to spawn with secondary weapon
		{
			_secondaryWeaponSelected = _secondaryWeaponClass call BIS_fnc_selectRandom;
			_man addMagazine _secondaryWeaponSelected;
			_man addWeapon _secondaryWeaponSelected;
		};
	};
	_useGrenades = floor(random(51));
	if(_useSecondary >= 35) then // 30% chance to spawn with grenades
	{
		_grenadeSelected = _grenadeWeaponClass call BIS_fnc_selectRandom;
		_man addMagazine _grenadeSelected;
		_man addMagazine _grenadeSelected;
	};
	_useSmoke = floor(random(51));
	if(_useSecondary >= 25) then // 50% chance to spawn with smoke
	{
		_smokeSelected = _smokeWeaponClass call BIS_fnc_selectRandom;
		_man addMagazine _smokeSelected;
		_man addMagazine _smokeSelected;
	};
};	

_leader = leader _group;
[_group, _pos] call defendArea;