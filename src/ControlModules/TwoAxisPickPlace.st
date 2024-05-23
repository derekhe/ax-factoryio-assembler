USING System.Timer;
NAMESPACE Demo.ControlModule

TYPE
    PickPlaceStatus : (        
        IDLE,
        STARTING,
        // Execute
        PICK_MOVING_Z_DOWN, GRABING, PICK_MOVING_Z_UP, MOVING_X_RIGHT, PLACE_MOVING_Z_DOWN, RELEASE, PLACE_MOVING_Z_UP, COMPLETE,
        // Stops
        STOPPING,
        STOPPED,
        // Abort
        EMERGENCY_STOP);
END_TYPE

CLASS TwoAxisPickPlace IMPLEMENTS ICyclic
    VAR PROTECTED
        _moveZCmd : BOOL;
        _moveXCmd : BOOL;
        _grabCmd : BOOL;
        _status : PickPlaceStatus;
        _delayTimer : OnDelay;
    END_VAR

    VAR PUBLIC
        MovingX : REF_TO BOOL;
        MovingZ: REF_TO BOOL;
        ItemDetected : REF_TO BOOL;

        MoveX: REF_TO BOOL;
        MoveZ: REF_TO BOOL;
        Grab: REF_TO BOOL;
    END_VAR
    
    METHOD PUBLIC Start
        _status := PickPlaceStatus#STARTING;
    END_METHOD
    
    METHOD PUBLIC Reset
        _moveZCmd := FALSE;
        _moveXCmd := FALSE;
        _grabCmd := FALSE;
        _status := PickPlaceStatus#IDLE;
    END_METHOD

    METHOD PUBLIC Stop
        _status := PickPlaceStatus#STOPPED;
    END_METHOD

    METHOD PUBLIC IsDone : BOOL
        IsDone := (_status = PickPlaceStatus#COMPLETE);
    END_METHOD

    METHOD PUBLIC EmergencyStop
        _status :=PickPlaceStatus#EMERGENCY_STOP;        
    END_METHOD

    METHOD PUBLIC Cycle
        CASE _status OF
            PickPlaceStatus#IDLE:
                ;
            PickPlaceStatus#STARTING:
                _moveZCmd := TRUE;
                _status := PickPlaceStatus#PICK_MOVING_Z_DOWN;
                _delayTimer(FALSE);
            PickPlaceStatus#PICK_MOVING_Z_DOWN:
                _delayTimer(NOT (MovingZ^), LT#200ms);
                IF _delayTimer.output THEN
                    _delayTimer(FALSE);
                    _grabCmd := TRUE;
                    _status := PickPlaceStatus#GRABING;
                END_IF;
            PickPlaceStatus#GRABING:
                _delayTimer(ItemDetected^, LT#200ms);
                IF _delayTimer.output THEN
                    _moveZCmd := FALSE;
                    _delayTimer(FALSE);
                    _status := PickPlaceStatus#PICK_MOVING_Z_UP;
                END_IF;
            PickPlaceStatus#PICK_MOVING_Z_UP:
                _delayTimer(NOT (MovingZ^), LT#200ms);
                IF _delayTimer.output THEN
                    _moveXCmd := TRUE;
                    _delayTimer(FALSE);
                    _status := PickPlaceStatus#MOVING_X_RIGHT;
                END_IF;
            PickPlaceStatus#MOVING_X_RIGHT:
                _delayTimer(NOT (MovingX^), LT#200ms);
                IF _delayTimer.output THEN
                    _moveZCmd := TRUE;
                    _delayTimer(FALSE);
                    _status := PickPlaceStatus#PLACE_MOVING_Z_DOWN;
                END_IF;
            PickPlaceStatus#PLACE_MOVING_Z_DOWN:
                _delayTimer(NOT (MovingZ^), LT#200ms);
                IF _delayTimer.output THEN
                    _moveZCmd := FALSE;
                    _grabCmd := FALSE;
                    _delayTimer(FALSE);
                    _status := PickPlaceStatus#PLACE_MOVING_Z_UP;
                END_IF;
            PickPlaceStatus#PLACE_MOVING_Z_UP:
                _moveZCmd := FALSE;
                
                _delayTimer(NOT(MovingZ^), LT#200ms);
                IF _delayTimer.output THEN
                    _delayTimer(FALSE);
                    _status := PickPlaceStatus#COMPLETE;
                END_IF;
            PickPlaceStatus#COMPLETE:
                _moveZCmd := FALSE;
                _moveXCmd := FALSE;
                _grabCmd := FALSE;
                _status := PickPlaceStatus#IDLE;
            PickPlaceStatus#STOPPING:
                // Do nothing
                ;
            PickPlaceStatus#EMERGENCY_STOP:
                // Do nothing
                ;
        END_CASE;

        MoveX^ := _moveXCmd;        
        MoveZ^ := _moveZCmd;
        Grab^ := _grabCmd;
    END_METHOD
END_CLASS
END_NAMESPACE