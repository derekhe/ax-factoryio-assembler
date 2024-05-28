USING System.Timer;

NAMESPACE Demo.ControlModule.States.TwoAxisPickPlace

INTERFACE IPickPlaceState
    METHOD Start END_METHOD
    METHOD Reset END_METHOD
    METHOD Stop END_METHOD
    METHOD EmergencyStop END_METHOD
    METHOD Cycle END_METHOD
    METHOD OnEntry END_METHOD
    METHOD OnExit END_METHOD
    METHOD GetStateName:STRING END_METHOD
END_INTERFACE

CLASS StateBase IMPLEMENTS IPickPlaceState
    VAR PUBLIC 
        Device: REF_TO TwoAxisPickPlace;
        NextState: IPickPlaceState;
        Name: STRING;
    END_VAR

    METHOD PUBLIC Start
        ;
    END_METHOD

    METHOD PUBLIC Reset
        ;
    END_METHOD

    METHOD PUBLIC Stop
        ;
    END_METHOD

    METHOD PUBLIC Cycle
        ;
    END_METHOD

    METHOD PUBLIC OnEntry
        ;
    END_METHOD

    METHOD PUBLIC IsDone:BOOL
        IsDone := FALSE;
    END_METHOD

    METHOD PUBLIC EmergencyStop
        ;
    END_METHOD

    METHOD PUBLIC OnExit
        ;
    END_METHOD

    METHOD PUBLIC GetStateName : STRING
        GetStateName := Name;
    END_METHOD
END_CLASS

CLASS IdleState EXTENDS StateBase
    METHOD PUBLIC OVERRIDE Start
        Device^.IsDone := FALSE;
        Device^.SetState(NextState);
    END_METHOD
END_CLASS

CLASS StartingState EXTENDS StateBase
    METHOD PUBLIC OVERRIDE Cycle
        Device^.MoveZ^ := TRUE;
        Device^.SetState(NextState);
    END_METHOD
END_CLASS

CLASS PickMovingZDownState EXTENDS StateBase
    VAR PRIVATE
        _delayTimer: OnDelay;
    END_VAR
    
    METHOD PUBLIC OVERRIDE OnEntry
        _delayTimer(FALSE);
    END_METHOD

    METHOD PUBLIC OVERRIDE Cycle
        _delayTimer(NOT (Device^.MovingZ^), LT#200ms);
        IF _delayTimer.output THEN
            Device^.Grab^ := TRUE;
            Device^.SetState(NextState);
        END_IF;
    END_METHOD
END_CLASS

CLASS GrabbingState EXTENDS StateBase
    VAR PRIVATE
        _delayTimer: OnDelay;
    END_VAR

    METHOD PUBLIC OVERRIDE OnEntry
        _delayTimer(FALSE);
    END_METHOD

    METHOD PUBLIC OVERRIDE Cycle
        _delayTimer(Device^.ItemDetected^, LT#200ms);
        IF _delayTimer.output THEN
            Device^.MoveZ^ := FALSE;
            Device^.SetState(NextState);
        END_IF;
    END_METHOD
END_CLASS

CLASS PickMovingZUpState EXTENDS StateBase
    VAR PRIVATE
        _delayTimer: OnDelay;
    END_VAR

    METHOD PUBLIC OVERRIDE OnEntry
        _delayTimer(FALSE);
    END_METHOD

    METHOD PUBLIC OVERRIDE Cycle
        _delayTimer(NOT (Device^.MovingZ^), LT#200ms);
        IF _delayTimer.output THEN
            Device^.MoveX^ := TRUE;
            Device^.SetState(NextState);
        END_IF;
    END_METHOD
END_CLASS

CLASS MovingXRightState EXTENDS StateBase
    VAR PRIVATE
        _delayTimer: OnDelay;
    END_VAR

    METHOD PUBLIC OVERRIDE OnEntry
        _delayTimer(FALSE);
    END_METHOD

    METHOD PUBLIC OVERRIDE Cycle
        _delayTimer(NOT (Device^.MovingX^), LT#200ms);
        IF _delayTimer.output THEN
            Device^.MoveZ^ := TRUE;
            Device^.SetState(NextState);
        END_IF;
    END_METHOD
END_CLASS

Class PlaceMovingZDownState EXTENDS StateBase
    VAR PRIVATE
        _delayTimer: OnDelay;
    END_VAR

    METHOD PUBLIC OVERRIDE OnEntry
        _delayTimer(FALSE);
    END_METHOD

    METHOD PUBLIC OVERRIDE Cycle
        _delayTimer(NOT (Device^.MovingZ^), LT#200ms);
        IF _delayTimer.output THEN
            Device^.MoveZ^:=FALSE;
            Device^.Grab^:=FALSE;
            Device^.SetState(NextState);
        END_IF;
    END_METHOD
END_CLASS

CLASS PlaceMovingZUpState EXTENDS StateBase
    VAR PRIVATE
        _delayTimer: OnDelay;
    END_VAR

    METHOD PUBLIC OVERRIDE OnEntry
        _delayTimer(FALSE);
    END_METHOD

    METHOD PUBLIC OVERRIDE Cycle
        Device^.MoveZ^:=FALSE;

        _delayTimer(NOT (Device^.MovingZ^), LT#200ms);
        IF _delayTimer.output THEN
            Device^.SetState(NextState);
        END_IF;
    END_METHOD
END_CLASS

CLASS CompleteState EXTENDS StateBase
    METHOD PUBLIC OVERRIDE Cycle
        Device^.IsDone := TRUE;
        Device^.MoveZ^:=FALSE;
        Device^.MoveX^:=FALSE;
        Device^.Grab^:=FALSE;
        Device^.SetState(NextState);
    END_METHOD
END_CLASS

CLASS StopState EXTENDS StateBase
    METHOD PUBLIC OVERRIDE Reset
        Device^.SetState(NextState);
    END_METHOD
END_CLASS

CLASS ResetingState EXTENDS StateBase
    METHOD PUBLIC OVERRIDE OnEntry
        Device^.MoveZ^:=FALSE;
        Device^.MoveX^:=FALSE;
        Device^.Grab^:=FALSE;
        Device^.IsDone := FALSE;
    END_METHOD

    METHOD PUBLIC OVERRIDE Cycle
        Device^.SetState(NextState);
    END_METHOD
END_CLASS

CLASS EmergencyStopState EXTENDS StateBase
    METHOD PUBLIC OVERRIDE Reset
        Device^.SetState(NextState);
    END_METHOD
END_CLASS

END_NAMESPACE

