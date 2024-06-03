USING System.Timer;
NAMESPACE Demo.ControlModule

INTERFACE IConveyor EXTENDS ICyclic
    METHOD Start
    END_METHOD

    METHOD Stop
    END_METHOD
END_INTERFACE

CLASS Conveyor IMPLEMENTS IConveyor
    VAR PROTECTED
        _isOn : BOOL;
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

    METHOD PUBLIC Cycle
        ControlSignal^ := _isOn;
    END_METHOD
END_CLASS
END_NAMESPACE