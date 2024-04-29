CLASS Button
    VAR PUBLIC
        Signal: IBoolInput;
    END_VAR

    METHOD PUBLIC IsPressed : BOOL
        IsPressed := Signal.GetValue();
    END_METHOD
END_CLASS