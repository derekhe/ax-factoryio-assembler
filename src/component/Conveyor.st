USING System.Timer;

CLASS Conveyor
    VAR
        _isOn : BOOL;
        _isStopped : BOOL;
        _stopTimer: OnDelay;
        _elapsedTime: LTIME;
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

    METHOD PUBLIC Output
        VAR_OUTPUT
            run : BOOL;
        END_VAR
        run := _isOn;
    END_METHOD
END_CLASS
