USING Demo.Utils;
USING Demo.ControlModule;

NAMESPACE Demo.EquipmentModule

TYPE
    AssemblerStatus: INT (
        IDLE:=0,
        STARTED:= 1, WAITING_FOR_PARTS:=2, CLAMPING_PARTS:= 3, PICK_AND_PLACE:=4, MOVE_TO_FINISH:=5, PARTS_LEAVING:=6, 
        STOPPED:=7, 
        EMERGENCY_STOPPING:=8);
END_TYPE

CLASS Assembler IMPLEMENTS ICyclic
    VAR PUBLIC
        lidConveyor : IConveyor;
        baseConveyor : IConveyor;
        baseAtPlaceSensor : IObjectSensor;
        partLeavingSensor : IObjectSensor;
        lidAtPlaceSensor : IObjectSensor;
        baseClamp : IClamp;
        lidClamp : IClamp;
        twoAxisPickPlace : ITwoAxisPickPlace;
        counter: REF_TO DINT;
        baseAtPlaceDelayTimer: ITimer;
        lidAtPlaceDelayTimer: ITimer;
        normalDelayTimer: ITimer;
    END_VAR

    VAR PROTECTED
        _status: AssemblerStatus;
        _baseObjectInPosition:BOOL;
        _lidObjectInPosition:BOOL;
    END_VAR

    METHOD PUBLIC GetCount : DINT
        GetCount := counter^;
    END_METHOD

    METHOD PUBLIC GetStatus : AssemblerStatus
        GetStatus:= _status;
    END_METHOD

    METHOD PUBLIC Start
        IF _status = AssemblerStatus#IDLE THEN
            _status:= AssemblerStatus#STARTED;    
        END_IF;        
    END_METHOD

    METHOD PUBLIC Stop
        _status:= AssemblerStatus#STOPPED;
        lidConveyor.Stop();
        baseConveyor.Stop();
    END_METHOD
    
    METHOD PUBLIC Reset
        IF _status = AssemblerStatus#STOPPED OR _status = AssemblerStatus#EMERGENCY_STOPPING THEN
            _status := AssemblerStatus#STOPPED;
            counter^ := 0;

            baseConveyor.Stop();
            baseClamp.Release();
            baseClamp.Down();

            twoAxisPickPlace.Reset();

            lidConveyor.Stop();
            lidClamp.Release();
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
                baseConveyor.Start();
                lidConveyor.Start();

                _baseObjectInPosition :=FALSE;
                _lidObjectInPosition:=FALSE;                
                
                baseAtPlaceSensor.Reset();
                baseAtPlaceDelayTimer.Reset();
                lidAtPlaceSensor.Reset();
                lidAtPlaceDelayTimer.Reset();

                _status := AssemblerStatus#WAITING_FOR_PARTS;
            AssemblerStatus#WAITING_FOR_PARTS:
                baseAtPlaceDelayTimer.SetDuration(LT#0.6s);
                baseAtPlaceDelayTimer.Cycle(baseAtPlaceSensor.HasObjectPassed());

                IF baseAtPlaceDelayTimer.Output() THEN
                    baseAtPlaceDelayTimer.Reset();
                    baseConveyor.Stop();
                    baseClamp.DoClamp();
                    _baseObjectInPosition:=TRUE;
                END_IF;

                lidAtPlaceDelayTimer.SetDuration(LT#0.6s);                
                lidAtPlaceDelayTimer.Cycle(lidAtPlaceSensor.HasObjectPassed());

                IF lidAtPlaceDelayTimer.Output() THEN
                    lidAtPlaceDelayTimer.Reset();
                    lidConveyor.Stop();
                    lidClamp.DoClamp();
                    _lidObjectInPosition:=TRUE;
                END_IF;
                
                IF _baseObjectInPosition && _lidObjectInPosition THEN                    
                    normalDelayTimer.Reset();
                    _status := AssemblerStatus#CLAMPING_PARTS;
                END_IF;
            AssemblerStatus#CLAMPING_PARTS:
                normalDelayTimer.SetDuration(LT#1s);
                normalDelayTimer.Cycle(TRUE);
                IF normalDelayTimer.Output() THEN
                    normalDelayTimer.Reset();
                    lidClamp.Release();
                    baseClamp.Release();
                    twoAxisPickPlace.Start();
                    _status := AssemblerStatus#PICK_AND_PLACE;
                END_IF;
            AssemblerStatus#PICK_AND_PLACE:
                IF twoAxisPickPlace.GetIsDone() THEN                    
                    baseClamp.Raise();
                    _status := AssemblerStatus#MOVE_TO_FINISH;
                END_IF;
            AssemblerStatus#MOVE_TO_FINISH:
                normalDelayTimer.SetDuration(LT#1s);
                normalDelayTimer.Cycle(TRUE);
                IF normalDelayTimer.Output() THEN
                    normalDelayTimer.Reset();
                    baseConveyor.Start();
                    _status := AssemblerStatus#PARTS_LEAVING;                    
                END_IF;
            AssemblerStatus#PARTS_LEAVING:
                IF partLeavingSensor.HasObjectPassed() THEN
                    normalDelayTimer.SetDuration(LT#1s);
                    normalDelayTimer.Cycle(TRUE);

                    IF normalDelayTimer.Output() THEN
                        normalDelayTimer.Reset();
                        baseClamp.Down();
                        partLeavingSensor.Reset();
                        _status := AssemblerStatus#STARTED;
                        counter^ := counter^ + 1;
                    END_IF;
                END_IF;
            AssemblerStatus#STOPPED:
                baseConveyor.Stop();
                lidConveyor.Stop();
                twoAxisPickPlace.Stop();
            AssemblerStatus#EMERGENCY_STOPPING:
                baseConveyor.Stop();
                lidConveyor.Stop();
                twoAxisPickPlace.EmergencyStop();
        END_CASE;
    END_METHOD
END_CLASS
END_NAMESPACE