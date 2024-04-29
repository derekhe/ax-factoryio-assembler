USING System.Timer;

PROGRAM MyProgram
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
        StartSignal: BoolInput;
        StartLightSignal: BoolOutput;
        startButton : ButtonWithLight;

        ResetSignal: BoolInput;
        ResetLightSignal: BoolOutput;        
        resetButton : ButtonWithLight;

        StopSignal: BoolInput;
        StopLightSignal: BoolOutput;
        stopButton : ButtonWithLight;

        ModeSwitchSignal: BoolInput;
        switch: ModeSwitch;

        EmergencyStopSignal: BoolInput;
        emergencyStop: Button;

        // Conveyor
        BaseConveyorControlSignal: BoolOutput;
        LidsConveyorControlSignal: BoolOutput;

        basesConveyor: Conveyor;
        lidsConveyor: Conveyor;

        //Sensors        
        BaseAtPlaceSensorSignal: BoolInput;
        PartLeavingSensorSignal: BoolInput;
        LidAtPlaceSensorSignal: BoolInput;

        baseAtPlaceSensor: ObjectSensor;
        partLeavingSensor: ObjectSensor;
        lidAtPlaceSensor: ObjectSensor;

        //Clamps
        BaseClampedSignal: BoolInput;
        BaseClampControlSignal: BoolOutput;
        BaseClampRaiseSignal: BoolOutput;

        LidClampedSignal: BoolInput;
        LidClampControlSignal: BoolOutput;
        LidClampRaiseSignal: BoolOutput;

        baseClamp: Clamp;
        lidClamp: Clamp;
        
        // PickPlace
        MovingXSignal: BoolInput;
        MovingZSignal: BoolInput;
        ItemDetectedSignal: BoolInput;

        MoveXControlSignal: BoolOutput;
        MoveZControlSignal: BoolOutput;
        GrabControlSignal: BoolOutput;

        twoAxisPickPlace: TwoAxisPickPlace;
        
        // Assembler
        assembler: Assembler;
    END_VAR    
    VAR
        baseDelayTimer: OnDelay;
        lidDelayTimer: OnDelay;
    END_VAR
    
    // Inputs
    StartSignal.ReadCyclic(iStart);
    ResetSignal.ReadCyclic(iReset);
    StopSignal.ReadCyclic(iStop);
    ModeSwitchSignal.ReadCyclic(iAuto);
    EmergencyStopSignal.ReadCyclic(iEmergencyStop);
    BaseAtPlaceSensorSignal.ReadCyclic(iBaseAtPlace);
    PartLeavingSensorSignal.ReadCyclic(iPartLeaving);
    LidAtPlaceSensorSignal.ReadCyclic(iLidAtPlace);
    BaseClampedSignal.ReadCyclic(iBaseClamped);
    LidClampedSignal.ReadCyclic(iLidClamped);
    MovingXSignal.ReadCyclic(iMovingX);
    MovingZSignal.ReadCyclic(iMovingZ);
    ItemDetectedSignal.ReadCyclic(iItemDetected);

    // Executions
    IF emergencyStop.IsPressed() THEN
        assembler.EmergencyStop();
    ELSE
        IF startButton.IsPressed() THEN
            assembler.Start();
        END_IF;

        IF resetButton.IsPressed() THEN
            assembler.Reset();
        END_IF;

        IF stopButton.IsPressed() THEN
            assembler.Stop();
        END_IF;
    END_IF;

    qCounter:=assembler.GetCount();
    
    // Cycles
    twoAxisPickPlace.Cycle();
    assembler.Cycle();

    // Outputs
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
END_PROGRAM