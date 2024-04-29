INTERFACE IBoolOutput
    METHOD SetValue : BOOL
        VAR_INPUT
            value : BOOL;
        END_VAR
    END_METHOD
    METHOD WriteCyclic : BOOL
        VAR_OUTPUT
            signal : BOOL;
        END_VAR
    END_METHOD
END_INTERFACE

CLASS BoolOutput IMPLEMENTS IBoolOutput
    VAR PRIVATE
        _value : BOOL;
    END_VAR

    METHOD PUBLIC SetValue : BOOL
        VAR_INPUT
            value : BOOL;
        END_VAR
        _value := value;
    END_METHOD

    METHOD PUBLIC WriteCyclic : BOOL
        VAR_OUTPUT
            signal : BOOL;
        END_VAR
        signal := _value;
    END_METHOD
END_CLASS
