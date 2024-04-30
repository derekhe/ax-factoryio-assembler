USING System.Timer;

PROGRAM MyProgram
    VAR_EXTERNAL
        qCounter : DINT;
    END_VAR
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
    VAR
        baseDelayTimer: OnDelay;
        lidDelayTimer: OnDelay;
    END_VAR
    
    // Inputs
    RefreshInput();

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
        
    // Cycles
    twoAxisPickPlace.Cycle();
    assembler.Cycle();

    // Outputs
    qCounter:=assembler.GetCount();
    RefreshOutput();
END_PROGRAM