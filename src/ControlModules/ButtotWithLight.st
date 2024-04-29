CLASS ButtonWithLight EXTENDS Button IMPLEMENTS ICyclic
    VAR PUBLIC
        LightSignal: IBoolOutput;
    END_VAR

    METHOD PUBLIC Cycle
        LightSignal.SetValue(Signal.GetValue());
    END_METHOD
END_CLASS