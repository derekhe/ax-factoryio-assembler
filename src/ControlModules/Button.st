CLASS Button IMPLEMENTS ICyclic
    VAR PUBLIC
        Signal: IBoolInput;
    END_VAR

    METHOD PUBLIC IsPressed : BOOL
        IsPressed := Signal.GetValue();
    END_METHOD

    METHOD PUBLIC Cycle
        ;
    END_METHOD
END_CLASS