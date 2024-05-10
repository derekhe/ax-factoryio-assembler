USING System.Timer;

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