USING System.Timer;

CLASS Conveyor IMPLEMENTS ICyclic
    VAR
        _isOn : BOOL;
        _isStopped : BOOL;
    END_VAR

    VAR PUBLIC
        ControlSignal: REF_TO BOOL;
    END_VAR

    METHOD PUBLIC Start
        _isOn := TRUE;
    END_METHOD

    METHOD PUBLIC Stop
        _isOn := FALSE;
    END_METHOD

    METHOD IsStopped : BOOL
        IsStopped := NOT(_isOn);
    END_METHOD

    METHOD PUBLIC Cycle
        ControlSignal^ := _isOn;
    END_METHOD
END_CLASS
