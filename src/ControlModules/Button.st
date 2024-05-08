CLASS Button IMPLEMENTS ICyclic
    VAR PUBLIC
        Signal: REF_TO BOOL;
    END_VAR

    METHOD PUBLIC IsPressed : BOOL
        IsPressed := Signal^;
    END_METHOD

    METHOD PUBLIC Cycle
        ;
    END_METHOD
END_CLASS