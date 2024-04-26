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
        startButton : ButtonWithLight;
        stopButton : ButtonWithLight;
        resetButton : ButtonWithLight;        
        switch : ModeSwitch;
        emergencyStop: Button;
    END_VAR
    VAR_EXTERNAL
        basesConveyor: Conveyor;
        lidsConveyor: Conveyor;
        baseAtPlaceSensor: ObjectSensor;
        partLeavingSensor: ObjectSensor;
        lidAtPlaceSensor: ObjectSensor;
        baseClamp: Clamp;
        lidClamp: Clamp;
    END_VAR
    VAR_EXTERNAL
        twoAxisPickPlace: TwoAxisPickPlace;
    END_VAR
    VAR_EXTERNAL
        assembler : Assembler;
    END_VAR    
    VAR
        baseDelayTimer: OnDelay;
        lidDelayTimer: OnDelay;
    END_VAR
    
    startButton.Input(iStart);
    resetButton.Input(iReset);
    stopButton.Input(NOT(iStop));
    switch.Input(iAuto);
    baseAtPlaceSensor.Input(iBaseAtPlace);
    partLeavingSensor.Input(iPartLeaving);
    lidAtPlaceSensor.Input(iLidAtPlace);
    twoAxisPickPlace.Input(iMovingX, iMovingZ, iItemDetected);
    lidClamp.Input(iLidClamped);
    baseClamp.Input(iBaseClamped);

    IF startButton.IsPressed() THEN
        assembler.Start();
    END_IF;

    IF resetButton.IsPressed() THEN
        assembler.Reset();
    END_IF;

    IF stopButton.IsPressed() THEN
        assembler.Stop();
    END_IF;

    qCounter:=assembler.GetCount();
    
    twoAxisPickPlace.Cycle();
    assembler.Cyclic();

    startButton.Output(qStartLight);
    resetButton.Output(qResetLight);
    stopButton.Output(qStopLight);
    basesConveyor.Output(qBasesConveyor);
    lidsConveyor.Output(qLidsConveyor);
    baseClamp.Output(qClampBase, qPosRaiseBases);
    lidClamp.Output(qClampLid, qPosRaiseLids);
    twoAxisPickPlace.Output(qMoveX, qMoveZ, qGrab);
END_PROGRAM