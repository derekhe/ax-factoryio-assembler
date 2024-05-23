USING AxUnit;
USING Demo.ControlModule;

NAMESPACE ControlModuleTest
    {TestFixture}
    CLASS ButtonTests
        VAR PRIVATE
            _hmi:BOOL;
            _signal:BOOL;
            _myButton: Button;
        END_VAR

        {Test(signal:=FALSE, result:=FALSE)}
        {Test(signal:=TRUE, result:=TRUE)}
        METHOD PUBLIC Button_Should_BePressed_Given_Input_Without_HMI_Signal
            VAR_INPUT
                signal: BOOL;
                result:BOOL;                
            END_VAR
    
            _signal := signal;
           
            _myButton.Signal := REF(_signal);
            _myButton.HMI := NULL;
            Assert.Equal(actual := _myButton.IsPressed(), expected := result);
        END_METHOD

        {Test(signal:=FALSE, hmi:=TRUE, result:=TRUE)}
        {Test(signal:=FALSE, hmi:=FALSE, result:=FALSE)}
        {Test(signal:=TRUE, hmi:=FALSE, result:=TRUE)}
        {Test(signal:=TRUE, hmi:=TRUE, result:=TRUE)}
        METHOD PUBLIC Button_Should_BePressed_Given_Input_OR_HMI_Signal
            VAR_INPUT
                signal: BOOL;
                hmi: BOOL;
                result:BOOL;
            END_VAR
            _signal := signal;
            _hmi := hmi;

            _myButton.Signal := REF(_signal);
            _myButton.HMI := REF(_hmi);
            Assert.Equal(actual := _myButton.IsPressed(), expected := result);
        END_METHOD
    END_CLASS

    {TestFixture}
    CLASS ButtonWithLightTests
        VAR PRIVATE
            _signal:BOOL;
            _hmi: BOOL;
            _lightSignal:BOOL;
            _myButtonWithLight: ButtonWithLight;
        END_VAR

        {Test(signal:=FALSE, result:=FALSE)}
        {Test(signal:=TRUE, result:=TRUE)}
        METHOD PUBLIC Light_Should_LightUp_Given_Input_Only
            VAR_INPUT
                signal: BOOL;
                result:BOOL;
            END_VAR
            _signal := signal;
           
            _myButtonWithLight.Signal := REF(_signal);
            _myButtonWithLight.HMI := NULL;
            _myButtonWithLight.LightSignal := REF(_lightSignal);

            _myButtonWithLight.Cycle();

            Assert.Equal(actual := _lightSignal, expected := result);
        END_METHOD

        {Test(signal:=FALSE, hmi:=TRUE, result:=FALSE)}
        {Test(signal:=TRUE, hmi:=FALSE, result:=TRUE)}
        METHOD PUBLIC Light_Should_LightUp_According_To_Input_Not_HMI
            VAR_INPUT
                signal: BOOL;                
                result:BOOL;
                hmi:BOOL;
            END_VAR
            _signal := signal;
            _hmi := hmi;
           
            _myButtonWithLight.Signal := REF(_signal);
            _myButtonWithLight.HMI := REF(_hmi);
            _myButtonWithLight.LightSignal := REF(_lightSignal);

            _myButtonWithLight.Cycle();

            Assert.Equal(actual := _lightSignal, expected := result);
        END_METHOD
    END_CLASS

END_NAMESPACE
