USING Demo.Utils;
USING Demo.ControlModule;
USING Demo.ControlModule.States.TwoAxisPickPlace;
USING AxUnit;
USING Demo.EquipmentModule;

NAMESPACE EquipmentModuleTest
    CLASS TestAssembler EXTENDS Assembler
        METHOD PUBLIC Setup
            _status:= AssemblerStatus#IDLE;
        END_METHOD

        METHOD PUBLIC SetStatus
            VAR_INPUT
                status: AssemblerStatus;
            END_VAR

            THIS._status := status;
        END_METHOD        
    END_CLASS

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

    CLASS MockTwoAxisPickPlace IMPLEMENTS ITwoAxisPickPlace
        METHOD PUBLIC Init
            ;
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
            ;
        END_METHOD
    
        METHOD PUBLIC Reset
            ;
        END_METHOD
    
        METHOD PUBLIC Stop
            ;
        END_METHOD
    
        METHOD PUBLIC EmergencyStop
            ;
        END_METHOD
    
        METHOD PUBLIC GetIsDone : BOOL
            ;
        END_METHOD
    
        METHOD PUBLIC Cycle
            ;
        END_METHOD
    END_CLASS

    {TestFixture}
    CLASS AssemblerTest
        VAR PRIVATE
            assembler: TestAssembler;
            lidConveyor : MockConveyor;
            baseConveyor : MockConveyor;
            baseAtPlaceSensor : MockObjectSensor;
            partLeavingSensor : MockObjectSensor;
            lidAtPlaceSensor : MockObjectSensor;
            baseClamp : MockClamp;
            lidClamp : MockClamp;
            twoAxisPickPlace : MockTwoAxisPickPlace;
            counter: DINT;
            baseAtPlaceDelayTimer: MockTimer;
            lidAtPlaceDelayTimer: MockTimer;
            normalDelayTimer: MockTimer;
        END_VAR

        {TestSetup}
        METHOD PUBLIC SetUp            
            baseConveyor.Setup();
            lidConveyor.Setup();
            baseAtPlaceSensor.Setup();
            lidAtPlaceSensor.Setup();
            partLeavingSensor.Setup();
            baseClamp.Setup();
            lidClamp.Setup();
            twoAxisPickPlace.Init();
            baseAtPlaceDelayTimer.SetDuration(LTIME#1s);
            lidAtPlaceDelayTimer.SetDuration(LTIME#1s);
            normalDelayTimer.SetDuration(LTIME#1s);
            counter:=0;
            
            assembler.baseConveyor := baseConveyor;
            assembler.lidConveyor := lidConveyor;
            assembler.baseAtPlaceSensor := baseAtPlaceSensor;
            assembler.lidAtPlaceSensor := lidAtPlaceSensor;
            assembler.partLeavingSensor := partLeavingSensor;
            assembler.baseClamp := baseClamp;
            assembler.lidClamp := lidClamp;
            assembler.twoAxisPickPlace := twoAxisPickPlace;
            assembler.baseAtPlaceDelayTimer := baseAtPlaceDelayTimer;
            assembler.lidAtPlaceDelayTimer := lidAtPlaceDelayTimer;
            assembler.normalDelayTimer := normalDelayTimer;
            assembler.counter := REF(Counter);
            assembler.Setup();
        END_METHOD

        {Test}
        METHOD PUBLIC Should_Be_In_Idle_Status_When_Inited
            Assert.Equal(actual := assembler.GetStatus(), expected := AssemblerStatus#IDLE);
        END_METHOD

        {Test}
        METHOD PUBLIC Should_Move_To_Starting_Status_When_StartButtonPressed
            assembler.Start();

            Assert.Equal(actual := assembler.GetStatus(), expected := AssemblerStatus#STARTED);            
        END_METHOD

        {Test}
        METHOD PUBLIC Should_Move_Keep_Current_status_If_Not_In_Idle_Status_When_StartButtonPressed
            assembler.SetStatus(AssemblerStatus#CLAMPING_PARTS);

            assembler.Start();

            Assert.Equal(actual := assembler.GetStatus(), expected := AssemblerStatus#CLAMPING_PARTS);
        END_METHOD

        {Test}
        METHOD PUBLIC Should_Start_Moving_Conveyors_When_Status_Is_Started
            assembler.Start();
            assembler.Cycle();

            Assert.Equal(actual := baseConveyor.started, expected := TRUE);
            Assert.Equal(actual := lidConveyor.started, expected := TRUE);
            Assert.Equal(actual := assembler.GetStatus(), expected := AssemblerStatus#WAITING_FOR_PARTS);
        END_METHOD
    END_CLASS    
END_NAMESPACE