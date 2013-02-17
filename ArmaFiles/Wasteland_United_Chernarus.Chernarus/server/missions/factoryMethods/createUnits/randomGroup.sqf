//	@file Version: 1.0
//	@file Name: randomGroup.sqf
//	@file Author: Mabluz
//	@file Created: 16/02/2012 23:13
//	@file Args:

if(!X_Server) exitWith {};


private ["_group","_pos","_personSelected","_mainWeaponSelected","_mainAmmoSelected","_mainWeaponIndexSelected","_secondaryWeaponSelected","_personClass","_mainWeaponClass","_mainWeaponAmmoClass","_secondaryWeaponClass","_useSecondary"];
_randomGroupSize = floor(random(2));
_randomGroupSize = _randomGroupSize + 1;

diag_log format["Guerrillia grupsize: %1",_randomGroupSize];

_personClass			= ["RUS_Soldier1","RUS_Soldier2","RUS_Soldier3","RUS_Commander","RUS_Soldier_Marksman","RUS_Soldier_GL","RUS_Soldier_Sab"];
// mainweapon index and ammo index must match weapontype vs ammotype
_mainWeaponClass 		= ["M16A4", 				"AKS_74_kobra", 	"G36a",				"M249", 				"PK", 				"M40A3", 			"SVD_CAMO", 		"M107"];
_mainWeaponAmmoClass 	= ["30Rnd_556x45_Stanag", 	"30Rnd_545x39_AK", 	"30Rnd_556x45_G36",	"200Rnd_556x45_M249", 	"100Rnd_762x54_PK", "5Rnd_762x51_M24", 	"10Rnd_762x54_SVD",    "10Rnd_127x99_m107"];
_secondaryWeaponClass 	= ["Strela", "Igla", "Javelin", "M136", "RPG18", "Stinger"];

_group = _this select 0;
_pos = _this select 1;


switch(_randomGroupSize) do
{
	case 2:
	{
		private ["_leader","_man2"];

		_leader = _group createunit ["RUS_Soldier_TL", [(_pos select 0) + 30, _pos select 1, 0], [], 0.5, "Form"];
		_mainWeaponIndexSelected = random(count(_mainWeaponClass) - 1);
		_mainWeaponSelected = _mainWeaponClass select _mainWeaponIndexSelected;
		_mainAmmoSelected = _mainWeaponAmmoClass select _mainWeaponIndexSelected;
		_leader addWeapon _mainWeaponSelected;
		_leader addMagazine _mainAmmoSelected;
		_leader addMagazine _mainAmmoSelected;
		_leader addMagazine _mainAmmoSelected;
		_useSecondary = floor(random(50));
		if(_useSecondary >= 25) then // 50% chance to spawn with secondary weapon
		{
			_secondaryWeaponSelected = _secondaryWeaponClass call BIS_fnc_selectRandom;
			_leader addMagazine _secondaryWeaponSelected;
			_leader addWeapon _secondaryWeaponSelected;
		};

		// Person 2
		_personSelected = _personClass call BIS_fnc_selectRandom;
		_man2 = _group createunit [_personSelected, [(_pos select 0) - 30, _pos select 1, 0], [], 0.5, "Form"];
		_mainWeaponIndexSelected = random(count(_mainWeaponClass) - 1);
		_mainWeaponSelected = _mainWeaponClass select _mainWeaponIndexSelected;
		_mainAmmoSelected = _mainWeaponAmmoClass select _mainWeaponIndexSelected;
		_man2 addWeapon _mainWeaponSelected;
		_man2 addMagazine _mainAmmoSelected;
		_man2 addMagazine _mainAmmoSelected;
		_man2 addMagazine _mainAmmoSelected;
		if(_useSecondary >= 40) then // 20% chance to spawn with secondary weapon
		{
			_secondaryWeaponSelected = _secondaryWeaponClass call BIS_fnc_selectRandom;
			_man2 addMagazine _secondaryWeaponSelected;
			_man2 addWeapon _secondaryWeaponSelected;
		};
	};
	default
	{
		private ["_leader"];

		_leader = _group createunit ["RUS_Soldier_TL", [(_pos select 0) + 30, _pos select 1, 0], [], 0.5, "Form"];
		_mainWeaponIndexSelected = random(count(_mainWeaponClass) - 1);
		_mainWeaponSelected = _mainWeaponClass select _mainWeaponIndexSelected;
		_mainAmmoSelected = _mainWeaponAmmoClass select _mainWeaponIndexSelected;
		//_leader addWeapon _mainWeaponSelected;
		//_leader addMagazine _mainAmmoSelected;
		//_leader addMagazine _mainAmmoSelected;
		//_leader addMagazine _mainAmmoSelected;
		_useSecondary = floor(random(50));
		if(_useSecondary >= 25) then // 50% chance to spawn with secondary weapon
		{
			_secondaryWeaponSelected = _secondaryWeaponClass call BIS_fnc_selectRandom;
			_leader addMagazine _secondaryWeaponSelected;
			_leader addWeapon _secondaryWeaponSelected;
		};
	};
};

_leader = leader _group;
[_group, _pos] call defendArea;