USING Demo.Utils;
USING Demo.ControlModule;
USING Demo.ControlModule.States.TwoAxisPickPlace;
USING AxUnit;
USING Demo.EquipmentModule;

NAMESPACE EquipmentModuleTest
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
            twoAxisPickPlace.Setup();
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

        {Test}
        METHOD PUBLIC Should_Stop_BaseConveyor_When_Base_Arrived
            baseConveyor.started := TRUE;
            lidConveyor.started := TRUE;
            assembler.SetStatus(AssemblerStatus#WAITING_FOR_PARTS);
            baseAtPlaceDelayTimer.timeUp :=TRUE;

            assembler.Cycle();

            Assert.Equal(actual := baseConveyor.started, expected := FALSE);
            Assert.Equal(actual := lidConveyor.started, expected := TRUE);
            Assert.Equal(actual := baseClamp.clamped, expected := TRUE);
            Assert.Equal(actual := assembler.GetStatus(), expected := AssemblerStatus#WAITING_FOR_PARTS);
        END_METHOD

        
        {Test}
        METHOD PUBLIC Should_Stop_Both_Conveyor_And_Clamp_Both_Parts_When_Lid_And_Base_Arrived
            baseConveyor.started := TRUE;
            lidConveyor.started := TRUE;
            assembler.SetStatus(AssemblerStatus#WAITING_FOR_PARTS);
            baseAtPlaceDelayTimer.timeUp :=TRUE;
            lidAtPlaceDelayTimer.timeUp :=TRUE;

            assembler.Cycle();

            Assert.Equal(actual := baseConveyor.started, expected := FALSE);
            Assert.Equal(actual := lidConveyor.started, expected := FALSE);
            Assert.Equal(actual := baseClamp.clamped, expected := TRUE);
            Assert.Equal(actual := lidClamp.clamped, expected := TRUE);
            Assert.Equal(actual := assembler.GetStatus(), expected := AssemblerStatus#CLAMPING_PARTS);
        END_METHOD
        
        {Test}
        METHOD PUBLIC Should_Release_Clamps_And_Start_AxixPickPlace_When_ClampingParts
            baseClamp.clamped := TRUE;
            lidClamp.clamped := TRUE;
            assembler.SetStatus(AssemblerStatus#CLAMPING_PARTS);
            normalDelayTimer.timeUp := TRUE;
            
            assembler.Cycle();

            Assert.Equal(actual := baseClamp.clamped, expected := FALSE);
            Assert.Equal(actual := lidClamp.clamped, expected := FALSE);
            Assert.Equal(actual := twoAxisPickPlace.GetIsDone(), expected := FALSE);
            Assert.Equal(actual := twoAxisPickPlace.mockState, expected := MockTwoAxisPickPlaceStatus#STARTED);
            Assert.Equal(actual := assembler.GetStatus(), expected := AssemblerStatus#PICK_AND_PLACE);
        END_METHOD
    END_CLASS
END_NAMESPACE