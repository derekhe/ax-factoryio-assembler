USING System.Timer;
USING Demo.ControlModule;
USING Demo.EquipmentModule;

PROGRAM InitPLC
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
    twoAxisPickPlace.Init();
END_PROGRAM