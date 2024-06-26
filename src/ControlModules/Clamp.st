NAMESPACE Demo.ControlModule

INTERFACE IClamp EXTENDS ICyclic
    METHOD DoClamp
    END_METHOD

    METHOD Release
    END_METHOD

    METHOD Raise
    END_METHOD

    METHOD Down
    END_METHOD

    METHOD Reset
    END_METHOD
END_INTERFACE
    
CLASS Clamp IMPLEMENTS IClamp
    VAR PROTECTED
        _clampCmd: BOOL;
        _raiseCmd: BOOL;
    END_VAR

    VAR PUBLIC
        ClampedSignal: REF_TO BOOL;
        ClampSignal: REF_TO BOOL;
        RaiseSignal: REF_TO BOOL;
    END_VAR

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
        ClampSignal^ := _clampCmd;
        RaiseSignal^ := _raiseCmd;
    END_METHOD
END_CLASS
END_NAMESPACE