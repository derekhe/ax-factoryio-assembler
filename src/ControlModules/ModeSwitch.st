TYPE 
    OperationMode : (Manual, Auto);
END_TYPE

NAMESPACE Demo.ControlModule
CLASS ModeSwitch IMPLEMENTS ICyclic
    VAR PUBLIC
        ModeSignal: REF_TO BOOL;
    END_VAR

    VAR PROTECTED
        _mode: OperationMode;
    END_VAR

    METHOD PUBLIC GetOperationMode: OperationMode
        GetOperationMode := _mode;
    END_METHOD

    METHOD PUBLIC Cycle
        IF ModeSignal^ THEN
            _mode := OperationMode#Auto;
        ELSE
            _mode := OperationMode#Manual;
        END_IF;
    END_METHOD
END_CLASS
END_NAMESPACE