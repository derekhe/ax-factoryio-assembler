CLASS Clamp
    VAR
        _clampCmd : BOOL;
        _clamped : BOOL;
    END_VAR

    METHOD PUBLIC Input
        VAR_INPUT
            clamped : BOOL;
        END_VAR
        _clamped := clamped;
    END_METHOD

    METHOD PUBLIC Output
        VAR_OUTPUT
            clamp : BOOL;
        END_VAR
        clamp := _clampCmd;
    END_METHOD

    METHOD IsClamped : BOOL
        IsClamped := _clamped;
    END_METHOD

    METHOD PUBLIC DoClamp
        _clampCmd := TRUE;
    END_METHOD

    METHOD PUBLIC Release
        _clampCmd := FALSE;
    END_METHOD
END_CLASS
