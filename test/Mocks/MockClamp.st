USING Demo.EquipmentModule;
USING Demo.ControlModule;

NAMESPACE EquipmentModuleTest
    CLASS MockClamp IMPLEMENTS IClamp
        VAR PUBLIC
            clamped: BOOL;
            raised: BOOL;
        END_VAR

        METHOD PUBLIC Setup
            clamped := FALSE;
            raised := FALSE;
        END_METHOD
    
        METHOD PUBLIC DoClamp
            clamped := TRUE;
        END_METHOD
    
        METHOD PUBLIC Release
            clamped := FALSE;
        END_METHOD
    
        METHOD PUBLIC Raise
            raised := TRUE;
        END_METHOD
    
        METHOD PUBLIC Down
            raised := FALSE;
        END_METHOD
    
        METHOD PUBLIC Reset
            clamped := FALSE;
            raised := FALSE;
        END_METHOD
    
        METHOD PUBLIC Cycle
            ;
        END_METHOD
    END_CLASS
END_NAMESPACE