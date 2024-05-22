NAMESPACE Demo.ControlModule
CLASS PUBLIC Button IMPLEMENTS ICyclic
    VAR PUBLIC
        Signal: REF_TO BOOL;
        HMI: REF_TO BOOL;
    END_VAR

    METHOD PUBLIC IsPressed : BOOL
        IF HMI <> NULL THEN
            IsPressed := Signal^ OR HMI^;
        ELSE
            IsPressed := Signal^;
        END_IF;
    END_METHOD

    METHOD PUBLIC Cycle
        ;
    END_METHOD
END_CLASS
END_NAMESPACE