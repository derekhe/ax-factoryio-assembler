USING Siemens.Simatic.S71500.Tasks;
USING Demo.ControlModule;
USING Demo.ControlModule.States.TwoAxisPickPlace;
USING Demo.EquipmentModule;
USING Demo.Utils;

CONFIGURATION MyConfiguration
    TASK Main (PRIORITY := 1);
    PROGRAM P1 WITH Main : MyProgram;

    TASK MyStartupTask : Startup;
    PROGRAM MyStartupProgram WITH MyStartupTask : InitPLC;

    // IO
    VAR_GLOBAL
        iMovingX AT %I0.0 : BOOL;
        iMovingZ AT %I0.1 : BOOL;
        iItemDetected AT %I0.2 : BOOL;
        iLidAtPlace AT %I0.3 : BOOL;
        iLidClamped AT %I0.4 : BOOL;
        iPosAtLimitLids AT %I0.5 : BOOL;
        iBaseAtPlace AT %I0.6 : BOOL;
        iBaseClamped AT %I0.7 : BOOL;
        iPosAtLimitBase AT %I1.0 : BOOL;
        iPartLeaving AT %I1.1 : BOOL;
        iStart AT %I1.2 : BOOL;
        iReset AT %I1.3 : BOOL;
        iStop AT %I1.4 : BOOL;
        iEmergencyStop AT %I1.5 : BOOL;
        iAuto AT %I1.6 : BOOL;
        qMoveX AT %Q0.0 : BOOL;
        qMoveZ AT %Q0.1 : BOOL;
        qGrab AT %Q0.2 : BOOL;
        qLidsConveyor AT %Q0.3 : BOOL;
        qClampLid AT %Q0.4 : BOOL;
        qPosRaiseLids AT %Q0.5 : BOOL;
        qBasesConveyor AT %Q0.6 : BOOL;
        qClampBase AT %Q0.7 : BOOL;
        qPosRaiseBases AT %Q1.0 : BOOL;
        qStartLight AT %Q1.1 : BOOL;
        qResetLight AT %Q1.2 : BOOL;
        qStopLight AT %Q1.3 : BOOL;
        qCounter AT %QD30 : DINT;
    END_VAR

    VAR_GLOBAL RETAIN
        counter: DINT;
    END_VAR
    
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

    VAR_GLOBAL
        {S7.extern=ReadWrite}
        {OpcUa = ReadWrite}
        hmiStart:BOOL;

        {S7.extern=ReadWrite}
        {OpcUa = ReadWrite}
        hmiStop:BOOL;

        {S7.extern=ReadWrite}
        {OpcUa = ReadWrite}
        hmiReset:BOOL;

        {S7.extern=Read}
        {OpcUa = Read}
        hmiCount:DINT;

        {S7.extern=Read}
        {OpcUa = Read}
        hmiTwoAxisStateName:STRING;
    END_VAR
END_CONFIGURATION