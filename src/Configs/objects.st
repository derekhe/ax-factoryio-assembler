USING Siemens.Simatic.S71500.Tasks;
USING Demo.ControlModule;
USING Demo.ControlModule.States.TwoAxisPickPlace;
USING Demo.EquipmentModule;
USING Demo.Utils;

CONFIGURATION MyObjects    
    VAR_GLOBAL        
        // Controls
        StartSignal: BOOL;
        StartLightSignal: BOOL;
        startButton : ButtonWithLight := (Signal:= REF(StartSignal) ,  LightSignal:= REF(StartLightSignal), HMI:=REF(hmiStart));

        ResetSignal: BOOL;
        ResetLightSignal: BOOL;        
        resetButton : ButtonWithLight := (Signal:= REF(ResetSignal),  LightSignal:= REF(ResetLightSignal), HMI:=REF(hmiReset));

        StopSignal: BOOL;
        StopLightSignal: BOOL;
        stopButton : ButtonWithLight := (Signal:=REF(StopSignal), LightSignal:= REF(StopLightSignal), HMI:=REF(hmiStop));

        ModeSwitchSignal: BOOL;
        switch: ModeSwitch := (ModeSignal:= REF(ModeSwitchSignal));

        EmergencyStopSignal: BOOL;
        emergencyStop: Button := (Signal:= REF(EmergencyStopSignal));

        // Conveyor
        BaseConveyorControlSignal: BOOL;
        LidsConveyorControlSignal: BOOL;

        basesConveyor: Conveyor:=(ControlSignal:= REF(BaseConveyorControlSignal));
        lidsConveyor: Conveyor:=(ControlSignal:= REF(LidsConveyorControlSignal));

        //Sensors        
        BaseAtPlaceSensorSignal: BOOL;
        PartLeavingSensorSignal: BOOL;
        LidAtPlaceSensorSignal: BOOL;

        baseAtPlaceSensor: ObjectSensor:=(ObjectDetectedInput:= REF(BaseAtPlaceSensorSignal));
        partLeavingSensor: ObjectSensor:=(ObjectDetectedInput:= REF(PartLeavingSensorSignal));
        lidAtPlaceSensor: ObjectSensor:=(ObjectDetectedInput:= REF(LidAtPlaceSensorSignal));

        //Clamps
        BaseClampedSignal: BOOL;
        BaseClampControlSignal: BOOL;
        BaseClampRaiseSignal: BOOL;

        LidClampedSignal: BOOL;
        LidClampControlSignal: BOOL;
        LidClampRaiseSignal: BOOL;

        baseClamp: Clamp:=(ClampedSignal:= REF(BaseClampedSignal), ClampSignal:= REF(BaseClampControlSignal), RaiseSignal:= REF(BaseClampRaiseSignal));
        lidClamp: Clamp:=(ClampedSignal:= REF(LidClampedSignal), ClampSignal:= REF(LidClampControlSignal), RaiseSignal:= REF(LidClampRaiseSignal));
        
        // PickPlace
        MovingXSignal: BOOL;
        MovingZSignal: BOOL;
        ItemDetectedSignal: BOOL;

        MoveXControlSignal: BOOL;
        MoveZControlSignal: BOOL;
        GrabControlSignal: BOOL;

        twoAxisPickPlace: TwoAxisPickPlace:=(
            MovingX:=REF(MovingXSignal),
            MovingZ:=REF(MovingZSignal),
            ItemDetected:=REF(ItemDetectedSignal),
            MoveX:=REF(MoveXControlSignal),
            MoveZ:=REF(MoveZControlSignal),
            Grab:=REF(GrabControlSignal),
            InitState:=idleState,
            TheStopState:=stopState,
            TheResetState:=resetingState
            );

        // Assemble PickPlace states
        idleState: IdleState := (Name:='Idle', Device := REF(twoAxisPickPlace), NextState:= startingState);
        startingState: StartingState:=(Name:='Starting', Device := REF(twoAxisPickPlace), NextState:= pickMovingZDwonState);
        pickMovingZDwonState: PickMovingZDownState:=(Name:='PickMovingZDown', Device := REF(twoAxisPickPlace), NextState:=grabbingState);
        grabbingState: GrabbingState:=(Name:='Grabbing', Device := REF(twoAxisPickPlace), NextState:=pickMovingZUpState);
        pickMovingZUpState: PickMovingZUpState:=(Name:='PickMovingZUp', Device := REF(twoAxisPickPlace), NextState:=movingXRightState);
        movingXRightState: MovingXRightState:=(Name:='MovingXRight', Device := REF(twoAxisPickPlace), NextState:=placeMovingZDownState);
        placeMovingZDownState: PlaceMovingZDownState:=(Name:='PlaceMovingZDown', Device := REF(twoAxisPickPlace), NextState:=placeMovingZUpState);
        placeMovingZUpState: PlaceMovingZUpState:=(Name:='PlaceMovingZUp', Device := REF(twoAxisPickPlace), NextState:=completeState);
        completeState: CompleteState:=(Name:='Complete', Device := REF(twoAxisPickPlace), NextState:=idleState);
        stopState: StopState:=(Name:='Stop', Device := REF(twoAxisPickPlace), NextState:=resetingState);
        resetingState: ResetingState:=(Name:='Resetting', Device := REF(twoAxisPickPlace), NextState:=idleState);
        
        // Assembler
        baseAtPlaceDelayTimer: Timer;
        lidAtPlaceDelayTimer: Timer;
        normalDelayTimer: Timer;

        assembler: Assembler := (
            baseAtPlaceDelayTimer := baseAtPlaceDelayTimer,
            lidAtPlaceDelayTimer := lidAtPlaceDelayTimer,
            normalDelayTimer := normalDelayTimer,
            lidConveyor:=lidsConveyor,
            baseConveyor:=basesConveyor,
            baseAtPlaceSensor:=baseAtPlaceSensor,
            partLeavingSensor:=partLeavingSensor,
            lidAtPlaceSensor := lidAtPlaceSensor,
            baseClamp := baseClamp,
            lidClamp := lidClamp,
            twoAxisPickPlace := twoAxisPickPlace,
            counter := REF(counter)
        );
    END_VAR
END_CONFIGURATION