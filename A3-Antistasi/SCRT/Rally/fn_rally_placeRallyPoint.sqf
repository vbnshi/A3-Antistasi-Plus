params ["_pos", "_dir"];

rallyProps = [];

private _convertPositionToWorldPosition = {
    params ["_position"];

    private _tempVehicle = createVehicle ["Land_BottlePlastic_V2_F", [0,0,1000], [], 0, "NONE"];
    _tempVehicle setPosASL _position;
    private _tempVehiclePositionWorld = getPosWorld _tempVehicle;
    deleteVehicle _tempVehicle;

    _tempVehiclePositionWorld
};

private _radioWorldPosition = [_pos] call _convertPositionToWorldPosition;
private _rootRadio = [rallyPointRoot, _radioWorldPosition] call BIS_fnc_createSimpleObject;
private _rootPos = position _rootRadio;
private _rootHeight = (_rootPos select 2) - 0.185;
_rootRadio setPos [_rootPos select 0, _rootPos select 1, _rootHeight];

private _backpack1 = ["B_Carryall_oli", _radioWorldPosition] call BIS_fnc_createSimpleObject;
private _backpack1Pos = position _backpack1;
_backpack1 setPos [(_backpack1Pos select 0) - 0.15, (_backpack1Pos select 1) + 0.05, _rootHeight];
_backpack1 setDir 135;
[_backpack1, -30, 0] call BIS_fnc_setPitchBank;

private _backpack2 = ["B_Carryall_oli", _radioWorldPosition] call BIS_fnc_createSimpleObject;
private _backpack2Pos = position _backpack2;
_backpack2 setPos [(_backpack2Pos select 0) + 0.15, (_backpack2Pos select 1) + 0.05, _rootHeight];
_backpack2 setDir 225;
[_backpack2, -30, 0] call BIS_fnc_setPitchBank;

private _bag = ["Item_Sleeping_bag_folded_01", _radioWorldPosition] call BIS_fnc_createSimpleObject;
private _bagPos = position _bag;
_bag setPos [(_bagPos select 0) + 0.025, (_bagPos select 1) - 0.1, (_bagPos select 2) + 0.4];


private _ammobox = ["Land_Ammobox_rounds_F", _radioWorldPosition] call BIS_fnc_createSimpleObject;
private _ammoboxPos = position _ammobox;
_ammobox setPos [(_ammoboxPos select 0) + 0.35, (_ammoboxPos select 1) - 0.15, (_ammoboxPos select 2) - 0.15];
_ammobox setDir 115;

[_rootRadio, [0, 0, -0.5], 0.2] remoteExec ["SCRT_fnc_common_attachLightSource", 0, _rootRadio];

rallyPointMarker = createMarker ["RallyPointMarker", _rootPos];
rallyPointMarker setMarkerType "hd_join";
rallyPointMarker setMarkerSize [1, 1];
rallyPointMarker setMarkerText "Rally Point";
rallyPointMarker setMarkerColor "colorIndependent";
rallyPointMarker setMarkerAlpha 1;
sidesX setVariable [rallyPointMarker,teamPlayer,true];
publicVariable "rallyPointMarker";

rallyProps append [_rootRadio, _backpack1, _backpack2, _bag, _ammobox];
publicVariable "rallyProps";

_rootRadio