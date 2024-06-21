USING Demo.EquipmentModule;
USING Demo.ControlModule;

NAMESPACE EquipmentModuleTest
    CLASS MockObjectSensor IMPLEMENTS IObjectSensor
        VAR PUBLIC
            objectDetected:BOOL;
        END_VAR

        METHOD PUBLIC Setup
            objectDetected := FALSE;            
        END_METHOD
   
        METHOD PUBLIC HasObjectPassed : BOOL
            objectDetected:=TRUE;
        END_METHOD
    
        METHOD PUBLIC Reset
            objectDetected:=FALSE;
        END_METHOD
    
        METHOD PUBLIC Cycle
            objectDetected:=TRUE;
        END_METHOD
    END_CLASS
END_NAMESPACE