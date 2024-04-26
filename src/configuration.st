USING Siemens.Simatic.S71500.Tasks;

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

    // Controls
    VAR_GLOBAL
        startButton : ButtonWithLight;
        resetButton : ButtonWithLight;
        stopButton : ButtonWithLight;
        switch: ModeSwitch;
        emergencyStop: Button;        
    END_VAR

    // Conveyor
    VAR_GLOBAL
        basesConveyor: Conveyor;
        lidsConveyor: Conveyor;
        baseAtPlaceSensor: ObjectSensor;
        partLeavingSensor: ObjectSensor;
        lidAtPlaceSensor: ObjectSensor;
        baseClamp: Clamp;
        lidClamp: Clamp;
    END_VAR

    // PickPlace
    VAR_GLOBAL
        twoAxisPickPlace: TwoAxisPickPlace;
    END_VAR

    // Assembler
    VAR_GLOBAL
        assembler: Assembler;
    END_VAR
END_CONFIGURATION
