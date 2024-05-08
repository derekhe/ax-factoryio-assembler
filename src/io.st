FUNCTION RefreshInput
    VAR_EXTERNAL
        iMovingX : BOOL;
        iMovingZ : BOOL;
        iItemDetected : BOOL;
        iLidAtPlace : BOOL;
        iLidClamped : BOOL;
        iPosAtLimitLids : BOOL;
        iBaseAtPlace : BOOL;
        iBaseClamped : BOOL;
        iPosAtLimitBase : BOOL;
        iPartLeaving : BOOL;
        iStart : BOOL;
        iReset : BOOL;
        iStop : BOOL;
        iEmergencyStop : BOOL;
        iAuto : BOOL;
    END_VAR
    VAR_EXTERNAL
        StartSignal: BoolInput;
        ResetSignal: BoolInput;
        StopSignal: BoolInput;
        ModeSwitchSignal: BoolInput;
        EmergencyStopSignal: BoolInput;
        BaseAtPlaceSensorSignal: BoolInput;
        PartLeavingSensorSignal: BoolInput;
        LidAtPlaceSensorSignal: BoolInput;
        BaseClampedSignal: BoolInput;
        LidClampedSignal: BoolInput;
        MovingXSignal: BoolInput;
        MovingZSignal: BoolInput;
        ItemDetectedSignal: BoolInput;
    END_VAR    

    StartSignal.ReadCyclic(iStart);
    ResetSignal.ReadCyclic(iReset);
    StopSignal.ReadCyclic(NOT(iStop));
    ModeSwitchSignal.ReadCyclic(iAuto);
    EmergencyStopSignal.ReadCyclic(NOT(iEmergencyStop));
    BaseAtPlaceSensorSignal.ReadCyclic(iBaseAtPlace);
    PartLeavingSensorSignal.ReadCyclic(iPartLeaving);
    LidAtPlaceSensorSignal.ReadCyclic(iLidAtPlace);
    BaseClampedSignal.ReadCyclic(iBaseClamped);
    LidClampedSignal.ReadCyclic(iLidClamped);
    MovingXSignal.ReadCyclic(iMovingX);
    MovingZSignal.ReadCyclic(iMovingZ);
    ItemDetectedSignal.ReadCyclic(iItemDetected);
END_FUNCTION

FUNCTION Cycle
    VAR_EXTERNAL
        startButton : ButtonWithLight;
        resetButton : ButtonWithLight;
        stopButton : ButtonWithLight;
        emergencyStop: Button;
        switch: ModeSwitch;

        basesConveyor: Conveyor;
        lidsConveyor: Conveyor;

        baseAtPlaceSensor: ObjectSensor;
        partLeavingSensor: ObjectSensor;
        lidAtPlaceSensor: ObjectSensor;

        baseClamp: Clamp;
        lidClamp: Clamp;

        twoAxisPickPlace: TwoAxisPickPlace;

        assembler: Assembler;
    END_VAR

    startButton.Cycle();
    resetButton.Cycle();
    stopButton.Cycle();
    emergencyStop.Cycle();
    switch.Cycle();

    basesConveyor.Cycle();
    lidsConveyor.Cycle();

    baseAtPlaceSensor.Cycle();
    partLeavingSensor.Cycle();
    lidAtPlaceSensor.Cycle();

    baseClamp.Cycle();
    lidClamp.Cycle();

    twoAxisPickPlace.Cycle();
    assembler.Cycle();
END_FUNCTION

FUNCTION RefreshOutput
    VAR_EXTERNAL
        qMoveX : BOOL;
        qMoveZ : BOOL;
        qGrab : BOOL;
        qLidsConveyor : BOOL;
        qClampLid : BOOL;
        qPosRaiseLids : BOOL;
        qBasesConveyor : BOOL;
        qClampBase : BOOL;
        qPosRaiseBases : BOOL;
        qStartLight : BOOL;
        qResetLight : BOOL;
        qStopLight : BOOL;
        qCounter : DINT;
    END_VAR
    VAR_EXTERNAL
        StartLightSignal: BoolOutput;
        ResetLightSignal: BoolOutput;        
        StopLightSignal: BoolOutput;
        BaseConveyorControlSignal: BoolOutput;
        LidsConveyorControlSignal: BoolOutput;
        BaseClampControlSignal: BoolOutput;
        BaseClampRaiseSignal: BoolOutput;
        LidClampControlSignal: BoolOutput;
        LidClampRaiseSignal: BoolOutput;
        MoveXControlSignal: BoolOutput;
        MoveZControlSignal: BoolOutput;
        GrabControlSignal: BoolOutput;
        assembler: Assembler;
    END_VAR

    qCounter:=assembler.GetCount();
    StartLightSignal.WriteCyclic(qStartLight);
    ResetLightSignal.WriteCyclic(qResetLight);
    StopLightSignal.WriteCyclic(qStopLight);
    BaseConveyorControlSignal.WriteCyclic(qBasesConveyor);
    LidsConveyorControlSignal.WriteCyclic(qLidsConveyor);
    BaseClampControlSignal.WriteCyclic(qClampBase);
    BaseClampRaiseSignal.WriteCyclic(qPosRaiseBases);
    LidClampControlSignal.WriteCyclic(qClampLid);
    LidClampRaiseSignal.WriteCyclic(qPosRaiseLids);
    MoveXControlSignal.WriteCyclic(qMoveX);
    MoveZControlSignal.WriteCyclic(qMoveZ);
    GrabControlSignal.WriteCyclic(qGrab);
END_FUNCTION