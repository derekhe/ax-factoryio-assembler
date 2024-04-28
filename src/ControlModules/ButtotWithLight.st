CLASS ButtonWithLight EXTENDS Button
    METHOD PUBLIC Output
        VAR_OUTPUT
            ButtonLightOutputSignal : BOOL;
        END_VAR
        ButtonLightOutputSignal := _isPressed;
    END_METHOD
END_CLASS
