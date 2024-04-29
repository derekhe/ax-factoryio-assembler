CLASS ObjectSensor IMPLEMENTS ICyclic
    VAR
        _hasObjectPassed: BOOL;
    END_VAR

    VAR PUBLIC
        ObjectDetectedInput: IBoolInput;
    END_VAR

    METHOD PUBLIC HasObjectPassed : BOOL        
        HasObjectPassed := _hasObjectPassed;
    END_METHOD

    METHOD PUBLIC Reset
        _hasObjectPassed :=FALSE;
    END_METHOD

    METHOD PUBLIC Cycle
        _hasObjectPassed :=  _hasObjectPassed | objectDetectedInput.GetValue();
    END_METHOD
END_CLASS