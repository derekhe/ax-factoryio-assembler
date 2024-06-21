USING Demo.Utils;

NAMESPACE EquipmentModuleTest
    CLASS MockTimer IMPLEMENTS ITimer
        VAR PUBLIC
            timeUp: BOOL;
        END_VAR

        METHOD PUBLIC SetDuration
            VAR_INPUT
                duration : LTIME;
            END_VAR

            ;
        END_METHOD
    
        METHOD PUBLIC Reset
            timeUp:=FALSE;
        END_METHOD
    
        METHOD PUBLIC Cycle
            VAR_INPUT
                signal : BOOL;
            END_VAR

            ;
        END_METHOD
    
        METHOD PUBLIC Output : BOOL
            Output := timeUp;
        END_METHOD
    END_CLASS
END_NAMESPACE