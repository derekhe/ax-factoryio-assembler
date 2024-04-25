PROGRAM MyProgram
    VAR_EXTERNAL
        IMovingX : BOOL;
        IMovingZ : BOOL;
        IItemDetected : BOOL;
        ILidAtPlace : BOOL;
        ILidClamped : BOOL;
        IPosAtLimitLids : BOOL;
        IBaseAtPlace : BOOL;
        IBastClamped : BOOL;
        IPosAtLimitBase : BOOL;
        IPartLeaving : BOOL;
        IStart : BOOL;
        IReset : BOOL;
        IStop : BOOL;
        IEmergencyStop : BOOL;
        IAuto : BOOL;
        QMoveX : BOOL;
        QMoveZ : BOOL;
        QGrab : BOOL;
        QLidsConveyor : BOOL;
        QClampLid : BOOL;
        QPosRaiseLids : BOOL;
        QBasesConveyor : BOOL;
        QClampBase : BOOL;
        QPosRaiseBases : BOOL;
        QStartLight : BOOL;
        QResetLight : BOOL;
        QStopLight : BOOL;
        QCounter : DINT;
    END_VAR
    VAR
    END_VAR 

    ;
END_PROGRAM