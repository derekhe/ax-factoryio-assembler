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
        iBastClamped : BOOL;
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

    IF startButton.IsPressed() THEN
        twoAxisPickPlace.Start();
    END_IF;

    IF resetButton.IsPressed() THEN
        twoAxisPickPlace.Reset();
    END_IF;

    // IF lidAtPlaceSensor.HasObjectPassed() THEN        
    //     lidDelayTimer(TRUE, LT#1s);
    //     IF lidDelayTimer.output THEN
    //         lidDelayTimer(FALSE, LT#0.5s);
    //         lidsConveyor.Stop();               
    //         lidAtPlaceSensor.Reset();            
    //         lidClamp.DoClamp();
    //     END_IF;
    // END_IF;

    // IF baseAtPlaceSensor.HasObjectPassed() THEN        
    //     baseDelayTimer(TRUE, LT#1s);
    //     IF baseDelayTimer.output THEN
    //         baseDelayTimer(FALSE, LT#0.5s);
    //         basesConveyor.Stop();        
    //         baseAtPlaceSensor.Reset();
    //         baseClamp.DoClamp();
    //     END_IF;        
    // END_IF;

    qCounter:=qCounter+1;
    twoAxisPickPlace.Cycle();

    startButton.Output(qStartLight);
    resetButton.Output(qResetLight);
    stopButton.Output(qStopLight);
    basesConveyor.Output(qBasesConveyor);
    lidsConveyor.Output(qLidsConveyor);
    baseClamp.Output(qClampBase);
    lidClamp.Output(qClampLid);
    twoAxisPickPlace.Output(qMoveX, qMoveZ, qGrab);
END_PROGRAM