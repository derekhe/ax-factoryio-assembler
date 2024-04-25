TYPE 
    OperationMode : (Manual, Auto);
END_TYPE


CLASS ModeSwitch
    VAR PRIVATE
        _mode: OperationMode;
    END_VAR

    METHOD PUBLIC GetOperationMode: OperationMode
        GetOperationMode := _mode;
    END_METHOD

    METHOD PUBLIC Input
        VAR_INPUT
            Auto:BOOL;
        END_VAR

        IF Auto THEN
            _mode := OperationMode#Auto;
        ELSE
            _mode := OperationMode#Manual;
        END_IF;
    END_METHOD
END_CLASS