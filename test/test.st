USING AxUnit;
USING Demo.ControlModule;

NAMESPACE MyTest

    {TestFixture}
    CLASS ButtonTests
        VAR
            _hmi:BOOL;
            _signal:BOOL;
            mybutton: Button;
        END_VAR

        {Test(signal:=FALSE, result:=FALSE)}
        {Test(signal:=TRUE, result:=TRUE)}
        METHOD PUBLIC Button_Should_BePressed_Given_Input_Without_HMI_Signal
            VAR_INPUT
                signal: BOOL;
                result:BOOL;
            END_VAR
            _signal := signal;
           
            mybutton.Signal := REF(_signal);
            mybutton.HMI := NULL;
            Assert.Equal(actual := mybutton.IsPressed(), expected := result);
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

            mybutton.Signal := REF(_signal);
            mybutton.HMI := REF(_hmi);
            Assert.Equal(actual := mybutton.IsPressed(), expected := result);
        END_METHOD
    END_CLASS

    {TestFixture}
    CLASS ButtonWithLightTests
        VAR
            _signal:BOOL;
            _lightSignal:BOOL;
            mybutton: ButtonWithLight;
        END_VAR

        {Test(signal:=FALSE, result:=FALSE)}
        {Test(signal:=TRUE, result:=TRUE)}
        METHOD PUBLIC Button_Should_BePressed_Given_Input_Without_HMI_Signal
            VAR_INPUT
                signal: BOOL;
                result:BOOL;
            END_VAR
            _signal := signal;
           
            mybutton.Signal := REF(_signal);
            mybutton.HMI := NULL;
            mybutton.LightSignal := REF(_lightSignal);

            mybutton.Cycle();

            Assert.Equal(actual := _lightSignal, expected := result);
        END_METHOD
    END_CLASS

END_NAMESPACE
