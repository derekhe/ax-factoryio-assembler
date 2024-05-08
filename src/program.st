USING System.Timer;

PROGRAM MyProgram
    RefreshInput();
    Control();
    Cycle();
    RefreshOutput();
END_PROGRAM

FUNCTION Control
    VAR_EXTERNAL
        startButton : ButtonWithLight;
        resetButton : ButtonWithLight;
        stopButton : ButtonWithLight;
        emergencyStop: Button;
        assembler: Assembler;
    END_VAR
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
END_FUNCTION