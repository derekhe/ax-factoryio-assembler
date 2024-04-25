CONFIGURATION MyConfiguration
    TASK Main (INTERVAL := T#10ms, PRIORITY := 1);
    PROGRAM P1 WITH Main : MyProgram;
    VAR_GLOBAL
        IMovingX AT %I0.0 : BOOL;
        IMovingZ AT %I0.1 : BOOL;
        IItemDetected AT %I0.2 : BOOL;
        ILidAtPlace AT %I0.3 : BOOL;
        ILidClamped AT %I0.4 : BOOL;
        IPosAtLimitLids AT %I0.5 : BOOL;
        IBaseAtPlace AT %I0.6 : BOOL;
        IBastClamped AT %I0.7 : BOOL;
        IPosAtLimitBase AT %I1.0 : BOOL;
        IPartLeaving AT %I1.1 : BOOL;
        IStart AT %I1.2 : BOOL;
        IReset AT %I1.3 : BOOL;
        IStop AT %I1.4 : BOOL;
        IEmergencyStop AT %I1.5 : BOOL;
        IAuto AT %I1.6 : BOOL;
        QMoveX AT %Q0.0 : BOOL;
        QMoveZ AT %Q0.1 : BOOL;
        QGrab AT %Q0.2 : BOOL;
        QLidsConveyor AT %Q0.3 : BOOL;
        QClampLid AT %Q0.4 : BOOL;
        QPosRaiseLids AT %Q0.5 : BOOL;
        QBasesConveyor AT %Q0.6 : BOOL;
        QClampBase AT %Q0.7 : BOOL;
        QPosRaiseBases AT %Q1.0 : BOOL;
        QStartLight AT %Q1.1 : BOOL;
        QResetLight AT %Q1.2 : BOOL;
        QStopLight AT %Q1.3 : BOOL;
        QCounter AT %QD30 : DINT;
    END_VAR
END_CONFIGURATION
