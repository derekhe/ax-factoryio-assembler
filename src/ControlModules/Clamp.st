CLASS Clamp IMPLEMENTS ICyclic
    VAR
        _clampCmd : BOOL;
        _raiseCmd: BOOL;
    END_VAR

    VAR PUBLIC
        ClampedSignal: IBoolInput;
        ClampSignal: IBoolOutput;
        RaiseSignal: IBoolOutput;
    END_VAR

    METHOD IsClamped : BOOL
        IsClamped := ClampedSignal.GetValue();
    END_METHOD

    METHOD PUBLIC DoClamp
        _clampCmd := TRUE;
    END_METHOD

    METHOD PUBLIC Release
        _clampCmd := FALSE;
    END_METHOD

    METHOD PUBLIC Raise
        _raiseCmd := TRUE;
    END_METHOD

    METHOD PUBLIC Down        
        _raiseCmd := FALSE;
    END_METHOD

    METHOD PUBLIC Reset
        _raiseCmd := FALSE;
        _clampCmd := FALSE;
    END_METHOD

    METHOD PUBLIC Cycle
        ClampSignal.SetValue(_clampCmd);
        RaiseSignal.SetValue(_raiseCmd);
    END_METHOD
END_CLASS
