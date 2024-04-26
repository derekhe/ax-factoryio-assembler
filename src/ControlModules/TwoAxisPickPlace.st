USING System.Timer;

TYPE
    PickPlaceStatus : (        
IDLE,
        READY,
        PICK_MOVING_Z_DOWN,
        GRABING,
        PICK_MOVING_Z_UP,
        MOVING_X_RIGHT,
        PLACE_MOVING_Z_DOWN,
        RELEASE,
        PLACE_MOVING_Z_UP,
        DONE,
        EMERGENCY_STOP);
END_TYPE

CLASS TwoAxisPickPlace
    VAR
        _moveZCmd : BOOL;
        _movingZ : BOOL;
        _moveXCmd : BOOL;
        _movingX : BOOL;
        _grabCmd : BOOL;
        _itemDetected : BOOL;
        _status : PickPlaceStatus;
        _delayTimer : OnDelay;
    END_VAR

    METHOD PUBLIC Input
        VAR_INPUT
            movingX : BOOL;
            movingZ : BOOL;
            itemDetected : BOOL;
        END_VAR
        _movingX := movingX;
        _movingZ := movingZ;
        _itemDetected := itemDetected;
    END_METHOD

    METHOD PUBLIC Output
        VAR_OUTPUT
            qMoveX : BOOL;
            qMoveZ : BOOL;
            qGrab : BOOL;
        END_VAR
        qMoveX := _moveXCmd;
        qMoveZ := _moveZCmd;
        qGrab := _grabCmd;
    END_METHOD

    METHOD PUBLIC Start
        _status := PickPlaceStatus#READY;
    END_METHOD

    METHOD PUBLIC Cycle
        CASE _status OF
            PickPlaceStatus#IDLE:
                ;
            PickPlaceStatus#READY:
                _moveZCmd := TRUE;
                _status := PickPlaceStatus#PICK_MOVING_Z_DOWN;
                _delayTimer(FALSE);
            PickPlaceStatus#PICK_MOVING_Z_DOWN:
                _delayTimer(NOT (_movingZ), LT#200ms);
                IF _delayTimer.output THEN
                    _delayTimer(FALSE);
                    _grabCmd := TRUE;
                    _status := PickPlaceStatus#GRABING;
                END_IF;
            PickPlaceStatus#GRABING:
                _delayTimer(_itemDetected, LT#200ms);
                IF _delayTimer.output THEN
                    _moveZCmd := FALSE;
                    _delayTimer(FALSE);
                    _status := PickPlaceStatus#PICK_MOVING_Z_UP;
                END_IF;
            PickPlaceStatus#PICK_MOVING_Z_UP:
                _delayTimer(NOT (_movingZ), LT#200ms);
                IF _delayTimer.output THEN
                    _moveXCmd := TRUE;
                    _delayTimer(FALSE);
                    _status := PickPlaceStatus#MOVING_X_RIGHT;
                END_IF;
            PickPlaceStatus#MOVING_X_RIGHT:
                _delayTimer(NOT (_movingX), LT#200ms);
                IF _delayTimer.output THEN
                    _moveZCmd := TRUE;
                    _delayTimer(FALSE);
                    _status := PickPlaceStatus#PLACE_MOVING_Z_DOWN;
                END_IF;
            PickPlaceStatus#PLACE_MOVING_Z_DOWN:
                _delayTimer(NOT (_movingZ), LT#200ms);
                IF _delayTimer.output THEN
                    _moveZCmd := FALSE;
                    _grabCmd := FALSE;
                    _delayTimer(FALSE);
                    _status := PickPlaceStatus#PLACE_MOVING_Z_UP;
                END_IF;
            PickPlaceStatus#PLACE_MOVING_Z_UP:
                _moveZCmd := FALSE;
                
                _delayTimer(NOT(_movingZ), LT#200ms);
                IF _delayTimer.output THEN
                    _delayTimer(FALSE);
                    _status := PickPlaceStatus#DONE;
                END_IF;
            PickPlaceStatus#DONE:
                _moveZCmd := FALSE;
                _moveXCmd := FALSE;
                _grabCmd := FALSE;
            PickPlaceStatus#EMERGENCY_STOP:
                ;
        END_CASE;
    END_METHOD

    METHOD PUBLIC Reset
        _moveZCmd := FALSE;
        _moveXCmd := FALSE;
        _grabCmd := FALSE;
        _status := PickPlaceStatus#IDLE;
    END_METHOD

    METHOD PUBLIC IsDone : BOOL
        IsDone := (_status = PickPlaceStatus#DONE);
    END_METHOD

    METHOD PUBLIC EmergencyStop
        _status :=PickPlaceStatus#EMERGENCY_STOP;        
    END_METHOD
END_CLASS
