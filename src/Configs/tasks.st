USING Siemens.Simatic.S71500.Tasks;
USING Demo.ControlModule;
USING Demo.ControlModule.States.TwoAxisPickPlace;
USING Demo.EquipmentModule;
USING Demo.Utils;

CONFIGURATION MyTasks
    TASK Main (PRIORITY := 1);
    PROGRAM P1 WITH Main : MyProgram;

    TASK MyStartupTask : Startup;
    PROGRAM MyStartupProgram WITH MyStartupTask : InitPLC;
END_CONFIGURATION