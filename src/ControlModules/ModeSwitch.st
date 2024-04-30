TYPE 
    OperationMode : (Manual, Auto);
END_TYPE


CLASS ModeSwitch IMPLEMENTS ICyclic
    VAR PUBLIC
        ModeSignal: IBoolInput;
    END_VAR

    VAR PRIVATE
        _mode: OperationMode;
    END_VAR

    METHOD PUBLIC GetOperationMode: OperationMode
        GetOperationMode := _mode;
    END_METHOD

    METHOD PUBLIC Cycle
        IF ModeSignal.GetValue() THEN
            _mode := OperationMode#Auto;
        ELSE
            _mode := OperationMode#Manual;
        END_IF;
    END_METHOD
END_CLASS