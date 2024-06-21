USING Demo.EquipmentModule;
USING Demo.ControlModule;

NAMESPACE EquipmentModuleTest
    CLASS MockConveyor IMPLEMENTS IConveyor        
        VAR PUBLIC
            started:BOOL;
        END_VAR

        METHOD PUBLIC Setup
            started := FALSE;
        END_METHOD

        METHOD PUBLIC Start
            started := TRUE;
        END_METHOD

        METHOD PUBLIC Stop
            started := FALSE;
        END_METHOD

        METHOD PUBLIC Cycle
            ;
        END_METHOD
    END_CLASS
END_NAMESPACE