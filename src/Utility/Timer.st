USING System.Timer;
NAMESPACE Demo.Utils

INTERFACE ITimer
    METHOD SetDuration
        VAR_INPUT
            duration : LTIME;        
        END_VAR
    END_METHOD

    METHOD Reset
    END_METHOD

    METHOD Cycle
        VAR_INPUT
            signal: BOOL;
        END_VAR
    END_METHOD
    
    METHOD Output : BOOL
    END_METHOD
END_INTERFACE

CLASS Timer IMPLEMENTS ITimer
    VAR
        _duration:LTIME;
        _onDelay: OnDelay;
    END_VAR

    METHOD PUBLIC SetDuration
        VAR_INPUT
            duration : LTIME;            
        END_VAR
        _duration := duration;
    END_METHOD

    METHOD PUBLIC Reset
        _onDelay(FALSE);
    END_METHOD

    METHOD PUBLIC Cycle
        VAR_INPUT
            signal: BOOL;
        END_VAR
        _onDelay(signal, _duration);
    END_METHOD
    
    METHOD PUBLIC Output : BOOL
        Output:=_onDelay.output;
    END_METHOD
END_CLASS
    
END_NAMESPACE