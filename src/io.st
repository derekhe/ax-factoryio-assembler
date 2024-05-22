USING Demo.ControlModule;
USING Demo.EquipmentModule;

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
        StartSignal: BOOL;
        ResetSignal: BOOL;
        StopSignal: BOOL;
        ModeSwitchSignal: BOOL;
        EmergencyStopSignal: BOOL;
        BaseAtPlaceSensorSignal: BOOL;
        PartLeavingSensorSignal: BOOL;
        LidAtPlaceSensorSignal: BOOL;
        BaseClampedSignal: BOOL;
        LidClampedSignal: BOOL;
        MovingXSignal: BOOL;
        MovingZSignal: BOOL;
        ItemDetectedSignal: BOOL;
    END_VAR    

    StartSignal := iStart;
    ResetSignal := iReset;
    StopSignal := NOT(iStop);
    ModeSwitchSignal := iAuto;
    EmergencyStopSignal := NOT(iEmergencyStop);
    BaseAtPlaceSensorSignal := iBaseAtPlace;
    PartLeavingSensorSignal := iPartLeaving;
    LidAtPlaceSensorSignal := iLidAtPlace;
    BaseClampedSignal := iBaseClamped;
    LidClampedSignal := iLidClamped;
    MovingXSignal := iMovingX;
    MovingZSignal := iMovingZ;
    ItemDetectedSignal := iItemDetected;
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
        StartLightSignal: BOOL;
        ResetLightSignal: BOOL;        
        StopLightSignal: BOOL;
        BaseConveyorControlSignal: BOOL;
        LidsConveyorControlSignal: BOOL;
        BaseClampControlSignal: BOOL;
        BaseClampRaiseSignal: BOOL;
        LidClampControlSignal: BOOL;
        LidClampRaiseSignal: BOOL;
        MoveXControlSignal: BOOL;
        MoveZControlSignal: BOOL;
        GrabControlSignal: BOOL;
        assembler: Assembler;
        hmiCount : DINT;
    END_VAR

    qCounter:=assembler.GetCount();
    hmiCount:=assembler.GetCount();    
    qStartLight := StartLightSignal;
    qResetLight := ResetLightSignal;
    qStopLight := StopLightSignal;
    qBasesConveyor := BaseConveyorControlSignal;
    qLidsConveyor := LidsConveyorControlSignal;
    qClampBase := BaseClampControlSignal;
    qPosRaiseBases := BaseClampRaiseSignal;
    qClampLid := LidClampControlSignal;
    qPosRaiseLids := LidClampRaiseSignal;
    qMoveX := MoveXControlSignal;
    qMoveZ := MoveZControlSignal;
    qGrab := GrabControlSignal;    
END_FUNCTION