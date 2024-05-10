USING System.Timer;

TYPE
    AssemblerStatus: (
        IDLE,
        STARTED, WAITING_FOR_PARTS, CLAMPING_PARTS, PICK_AND_PLACE, MOVE_TO_FINISH, PARTS_LEAVING, 
        STOPPED, 
        EMERGENCY_STOPPING);
END_TYPE

CLASS Assembler IMPLEMENTS ICyclic
    VAR PUBLIC
        lidConveyor : REF_TO Conveyor;
        baseConveyor : REF_TO Conveyor;
        baseAtPlaceSensor : REF_TO ObjectSensor;
        partLeavingSensor : REF_TO ObjectSensor;
        lidAtPlaceSensor : REF_TO ObjectSensor;
        baseClamp : REF_TO Clamp;
        lidClamp : REF_TO Clamp;
        twoAxisPickPlace : REF_TO TwoAxisPickPlace;
    END_VAR

    VAR
        _status: AssemblerStatus;
        _baseAtPlaceDelayTimer: OnDelay;
        _lidAtPlaceDelayTimer: OnDelay;
        _raiseDelayTimer: OnDelay;
        _objectPassByDelayTimer: OnDelay;
        _delayTimer: OnDelay;

        _baseObjectInPosition:BOOL;
        _lidObjectInPosition:BOOL;

        _counter : DINT;
    END_VAR

    METHOD PUBLIC GetCount : DINT
        GetCount := _counter;
    END_METHOD

    METHOD PUBLIC Start
        IF _status = AssemblerStatus#IDLE THEN
            _status:= AssemblerStatus#STARTED;    
        END_IF;        
    END_METHOD

    METHOD PUBLIC Stop
        _status:= AssemblerStatus#STOPPED;
        lidConveyor^.Stop();
        baseConveyor^.Stop();
    END_METHOD
    
    METHOD PUBLIC Reset
        IF _status = AssemblerStatus#STOPPED OR _status = AssemblerStatus#EMERGENCY_STOPPING THEN
            _status := AssemblerStatus#STOPPED;
            _counter := 0;

            baseConveyor^.Stop();
            baseClamp^.Release();
            baseClamp^.Down();

            twoAxisPickPlace^.Reset();

            lidConveyor^.Stop();
            lidClamp^.Release();
            _status := AssemblerStatus#IDLE;
        END_IF;
    END_METHOD

    METHOD PUBLIC EmergencyStop
        _status := AssemblerStatus#EMERGENCY_STOPPING;
    END_METHOD

    METHOD PUBLIC Cycle
        CASE _status OF
            AssemblerStatus#IDLE:
            //Do nothing
            ;
            AssemblerStatus#STARTED:
                baseConveyor^.Start();
                lidConveyor^.Start();

                _baseObjectInPosition :=FALSE;
                _lidObjectInPosition:=FALSE;                

                _baseAtPlaceDelayTimer(FALSE);
                _lidAtPlaceDelayTimer(FALSE);

                baseAtPlaceSensor^.Reset();
                lidAtPlaceSensor^.Reset();

                _status := AssemblerStatus#WAITING_FOR_PARTS;
            AssemblerStatus#WAITING_FOR_PARTS:
                _baseAtPlaceDelayTimer(baseAtPlaceSensor^.HasObjectPassed(), LT#0.6s);

                IF _baseAtPlaceDelayTimer.output THEN
                    _baseAtPlaceDelayTimer(FALSE);
                    baseConveyor^.Stop();
                    baseClamp^.DoClamp();
                    _baseObjectInPosition:=TRUE;
                END_IF;

                _lidAtPlaceDelayTimer(lidAtPlaceSensor^.HasObjectPassed(), LT#0.6s);

                IF _lidAtPlaceDelayTimer.output THEN
                    _lidAtPlaceDelayTimer(FALSE);
                    lidConveyor^.Stop();
                    lidClamp^.DoClamp();
                    _lidObjectInPosition:=TRUE;
                END_IF;
                
                IF _baseObjectInPosition && _lidObjectInPosition THEN                    
                    _delayTimer(FALSE);
                    _status := AssemblerStatus#CLAMPING_PARTS;
                END_IF;
            AssemblerStatus#CLAMPING_PARTS:
                _delayTimer(TRUE, LT#1s);
                IF _delayTimer.output THEN
                    _delayTimer(FALSE);
                    lidClamp^.Release();
                    baseClamp^.Release();
                    twoAxisPickPlace^.Start();
                    _status := AssemblerStatus#PICK_AND_PLACE;
                END_IF;
            AssemblerStatus#PICK_AND_PLACE:
                IF twoAxisPickPlace^.IsDone() THEN                    
                    baseClamp^.Raise();
                    _status := AssemblerStatus#MOVE_TO_FINISH;
                END_IF;
            AssemblerStatus#MOVE_TO_FINISH:
                _raiseDelayTimer(TRUE, LT#1s);
                IF _raiseDelayTimer.output THEN
                    _raiseDelayTimer(FALSE);
                    baseConveyor^.Start();
                    _objectPassByDelayTimer(FALSE);
                    _status := AssemblerStatus#PARTS_LEAVING;                    
                END_IF;
            AssemblerStatus#PARTS_LEAVING:
                IF partLeavingSensor^.HasObjectPassed() THEN
                    _objectPassByDelayTimer(TRUE, LT#1s);
                    IF _objectPassByDelayTimer.output THEN
                        _objectPassByDelayTimer(FALSE);
                        baseClamp^.Down();
                        partLeavingSensor^.Reset();
                        _status := AssemblerStatus#STARTED;
                        _counter := _counter + 1;
                    END_IF;
                END_IF;
            AssemblerStatus#STOPPED:
                baseConveyor^.Stop();
                lidConveyor^.Stop();
                twoAxisPickPlace^.Stop();
            AssemblerStatus#EMERGENCY_STOPPING:
                baseConveyor^.Stop();
                lidConveyor^.Stop();
                twoAxisPickPlace^.EmergencyStop();
        END_CASE;
    END_METHOD
END_CLASS
