USING Demo.EquipmentModule;
USING Demo.ControlModule;
USING Demo.ControlModule.States.TwoAxisPickPlace;

NAMESPACE EquipmentModuleTest
    TYPE
        MockTwoAxisPickPlaceStatus: INT (
            IDLE:=0,
            STARTED:=1,
            RESET:=2,
            STOP:=3,
            EMERGENCY_STOP:=4);
    END_TYPE

    CLASS MockTwoAxisPickPlace IMPLEMENTS ITwoAxisPickPlace
        VAR PUBLIC
            mockState: MockTwoAxisPickPlaceStatus;
            isDone: BOOL;
        END_VAR

        METHOD PUBLIC Setup
            mockState := MockTwoAxisPickPlaceStatus#IDLE;
            isDone := FALSE;
        END_METHOD
    
        METHOD PUBLIC SetState
            VAR_INPUT
                state : IPickPlaceState;
            END_VAR
            ;
        END_METHOD
    
        METHOD PUBLIC GetStateName : STRING
            ;
        END_METHOD
    
        METHOD PUBLIC Start
            mockState := MockTwoAxisPickPlaceStatus#STARTED;
        END_METHOD
    
        METHOD PUBLIC Reset
            mockState := MockTwoAxisPickPlaceStatus#RESET;
        END_METHOD
    
        METHOD PUBLIC Stop
            mockState := MockTwoAxisPickPlaceStatus#STOP;
        END_METHOD
    
        METHOD PUBLIC EmergencyStop
            mockState := MockTwoAxisPickPlaceStatus#EMERGENCY_STOP;
        END_METHOD
    
        METHOD PUBLIC GetIsDone : BOOL
            GetIsDone := isDone;
        END_METHOD
    
        METHOD PUBLIC Cycle
            ;
        END_METHOD
    
        METHOD PUBLIC Init
            ;
        END_METHOD
    END_CLASS
END_NAMESPACE