USING Demo.ControlModule.States.TwoAxisPickPlace;
USING Demo.ControlModule.States.TwoAxisPickPlace;
USING System.Timer;
USING DEMO.ControlModule.States.TwoAxisPickPlace;

NAMESPACE Demo.ControlModule

INTERFACE ITwoAxisPickPlace EXTENDS ICyclic
        METHOD Init
        END_METHOD
    
        METHOD SetState
            VAR_INPUT
                state : IPickPlaceState;
            END_VAR
        END_METHOD
    
        METHOD GetStateName : STRING
        END_METHOD
    
        METHOD Start
        END_METHOD
    
        METHOD Reset END_METHOD
    
        METHOD Stop END_METHOD
        
        METHOD EmergencyStop END_METHOD    

        METHOD GetIsDone:BOOL END_METHOD
END_INTERFACE

CLASS TwoAxisPickPlace IMPLEMENTS ITwoAxisPickPlace
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

    METHOD PUBLIC GetStateName : STRING
        GetStateName:= _status.GetStateName();
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

    METHOD PUBLIC GetIsDone: BOOL
        GetIsDone := IsDone;
    END_METHOD
END_CLASS

END_NAMESPACE