INTERFACE IBoolInput
    METHOD GetValue : BOOL
    END_METHOD
    METHOD ReadCyclic
        VAR_INPUT
            signal : BOOL;
        END_VAR
    END_METHOD
END_INTERFACE

CLASS BoolInput IMPLEMENTS IBoolInput
    VAR PRIVATE
        _value : BOOL;
    END_VAR

    METHOD PUBLIC GetValue : BOOL
        GetValue := _value;
    END_METHOD

    METHOD PUBLIC ReadCyclic
        VAR_INPUT
            signal : BOOL;
        END_VAR
        _value := signal;
    END_METHOD
END_CLASS
