CLASS Button
    VAR PRIVATE
        _isPressed : BOOL;
    END_VAR

    METHOD PUBLIC IsPressed : BOOL
        ;
        IsPressed := _isPressed;
    END_METHOD

    METHOD PUBLIC Input
        VAR_INPUT
            ButtonInputSignal : BOOL;
        END_VAR
        _isPressed := NOT(ButtonInputSignal);
    END_METHOD
END_CLASS

CLASS ButtonWithLight
    VAR PRIVATE
        _isPressed : BOOL;
    END_VAR

    METHOD PUBLIC IsPressed : BOOL
        ;
        IsPressed := _isPressed;
    END_METHOD

    METHOD PUBLIC Input
        VAR_INPUT
            ButtonInputSignal : BOOL;
        END_VAR
        _isPressed := ButtonInputSignal;
    END_METHOD

    METHOD PUBLIC Output
        VAR_OUTPUT
            ButtonLightOutputSignal : BOOL;
        END_VAR
        ButtonLightOutputSignal := _isPressed;
    END_METHOD
END_CLASS
