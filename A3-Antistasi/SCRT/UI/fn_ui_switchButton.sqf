params ["_table", "_idc", ["_change", true], ["_action", "NONE"]];	
private _optionData = [_table, _idc] call SCRT_fnc_ui_getSwitchLookup;

private _varStr = (_optionData select 0);
private _currentValue = (_optionData select 1);	
private _allValues = (_optionData select 2);

private _newValue = nil;
private _representation = nil;

if (_change) then {
    switch (true) do {
        case(_currentValue isEqualType true): { //fast check if type is boolean
            _newValue = !_currentValue;
            _representation = if(_newValue) then {_allValues select 0} else {_allValues select 1};
        };  
        //TODO: other types
    };

    missionNamespace setVariable [_varStr, _newValue];
    ctrlSetText [(_idc + 3), _representation];

    if (_action == "NONE") exitWith {};
    if (_action == "MUSIC") exitWith {execVM "musica.sqf"};
    if (_action == "CAMERA") exitWith {
        if(isLauncherCamEnabled) then {
            ['ADD'] call SCRT_fnc_misc_toggleLauncherCamEventHandler;
        } else {
            ['REMOVE'] call SCRT_fnc_misc_toggleLauncherCamEventHandler; 
        };
    };
    if (_action == "PARADROP") exitWith {
        if (isPlayerParadropable) then {
            paradropAttendants = [missionNamespace, "paradropAttendants", []] call BIS_fnc_getServerVariable;
            paradropAttendants pushBack player;
            publicVariableServer "paradropAttendants";
            paradropAttendants = nil;
        } else {
            paradropAttendants = [missionNamespace, "paradropAttendants", []] call BIS_fnc_getServerVariable;
            private _playerIndex = paradropAttendants deleteAt (paradropAttendants find player);
            publicVariableServer "paradropAttendants";
            paradropAttendants = nil;
        };
    };
} else {
    _representation = if(_currentValue) then {_allValues select 0} else {_allValues select 1};
    ctrlSetText [(_idc + 3), _representation];
};