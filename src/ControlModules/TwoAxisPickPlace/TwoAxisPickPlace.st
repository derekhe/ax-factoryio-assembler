USING Demo.ControlModule.States.TwoAxisPickPlace;
USING Demo.ControlModule.States.TwoAxisPickPlace;
USING System.Timer;
USING DEMO.ControlModule.States.TwoAxisPickPlace;

NAMESPACE Demo.ControlModule

CLASS TwoAxisPickPlace IMPLEMENTS ICyclic
    VAR PUBLIC
        MovingX : REF_TO BOOL;
        MovingZ: REF_TO BOOL;
        ItemDetected : REF_TO BOOL;

        MoveX: REF_TO BOOL;
        MoveZ: REF_TO BOOL;
        Grab: REF_TO BOOL;
        InitState: IPickPlaceState;
        IsDone: BOOL;
        TheStopState: IPickPlaceState;
        TheResetState: IPickPlaceState;
    END_VAR

    VAR PRIVATE
        _status: IPickPlaceState;
    END_VAR

    METHOD PUBLIC Init
        _status := InitState;
    END_METHOD

    METHOD PUBLIC SetState
        VAR_INPUT
            state : IPickPlaceState;
        END_VAR
        _status.OnExit();
        _status := state;
        _status.OnEntry();
    END_METHOD

    METHOD PUBLIC Start
        _status.Start();
    END_METHOD

    METHOD PUBLIC Reset
        _status.Reset();
    END_METHOD

    METHOD PUBLIC Stop
        This.SetState(TheStopState);
    END_METHOD
    
    METHOD PUBLIC EmergencyStop
        This.SetState(TheStopState);
    END_METHOD

    METHOD PUBLIC Cycle
        _status.Cycle();
    END_METHOD
END_CLASS

END_NAMESPACE