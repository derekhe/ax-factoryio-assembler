USING System.Timer;

PROGRAM InitPLC
    VAR_EXTERNAL
        iMovingX : BOOL;
        iMovingZ : BOOL;
        iItemDetected : BOOL;
        iLidAtPlace : BOOL;
        iLidClamped : BOOL;
        iPosAtLimitLids : BOOL;
        iBaseAtPlace : BOOL;
        IBaseClamped : BOOL;
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
        twoAxisPickPlace: TwoAxisPickPlace;
        assembler: Assembler;
    END_VAR

    baseAtPlaceSensor.Reset();
    partLeavingSensor.Reset();
    lidAtPlaceSensor.Reset();    
    twoAxisPickPlace.Reset();

    assembler.lidConveyor := REF(lidsConveyor);
    assembler.baseConveyor := REF(basesConveyor);
    assembler.baseAtPlaceSensor := REF(baseAtPlaceSensor);
    assembler.partLeavingSensor := REF(partLeavingSensor);
    assembler.lidAtPlaceSensor := REF(lidAtPlaceSensor);
    assembler.baseClamp := REF(baseClamp);
    assembler.lidClamp := REF(lidClamp);
    assembler.twoAxisPickPlace := REF(twoAxisPickPlace);
END_PROGRAM