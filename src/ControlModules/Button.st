CLASS Button
    VAR PROTECTED
        _isPressed : BOOL;
    END_VAR

    METHOD PUBLIC IsPressed : BOOL
        IsPressed := _isPressed;
    END_METHOD

    METHOD PUBLIC Input
        VAR_INPUT
            ButtonInputSignal : BOOL;
        END_VAR
        _isPressed := ButtonInputSignal;
    END_METHOD
END_CLASS