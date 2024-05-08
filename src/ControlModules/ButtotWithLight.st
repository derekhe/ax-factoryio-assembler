CLASS ButtonWithLight EXTENDS Button IMPLEMENTS ICyclic
    VAR PUBLIC
        LightSignal: REF_TO BOOL;
    END_VAR

    METHOD PUBLIC OVERRIDE Cycle
        LightSignal := Signal;
    END_METHOD
END_CLASS