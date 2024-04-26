CLASS ObjectSensor
    VAR
        _hasObjectPassed: BOOL;
    END_VAR

    METHOD PUBLIC Input : Int
        VAR_INPUT
            objectDetectedInput: BOOL;
        END_VAR

        _hasObjectPassed :=  _hasObjectPassed | objectDetectedInput;
    END_METHOD 
    
    METHOD PUBLIC HasObjectPassed : BOOL        
        HasObjectPassed := _hasObjectPassed;
    END_METHOD

    METHOD PUBLIC Reset
        _hasObjectPassed :=FALSE;
    END_METHOD
END_CLASS