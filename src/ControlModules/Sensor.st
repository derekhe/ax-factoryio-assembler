NAMESPACE Demo.ControlModule

INTERFACE IObjectSensor EXTENDS ICyclic
    METHOD HasObjectPassed : BOOL
    END_METHOD

    METHOD Reset
    END_METHOD
END_INTERFACE

CLASS ObjectSensor IMPLEMENTS IObjectSensor
    VAR PROTECTED
        _hasObjectPassed: BOOL;
    END_VAR

    VAR PUBLIC
        ObjectDetectedInput: REF_TO BOOL;
    END_VAR

    METHOD PUBLIC HasObjectPassed : BOOL        
        HasObjectPassed := _hasObjectPassed;
    END_METHOD

    METHOD PUBLIC Reset
        _hasObjectPassed :=FALSE;
    END_METHOD

    METHOD PUBLIC Cycle
        _hasObjectPassed :=  _hasObjectPassed | objectDetectedInput^;
    END_METHOD
END_CLASS
END_NAMESPACE