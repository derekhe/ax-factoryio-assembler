USING Siemens.Simatic.S71500.Tasks;
USING Demo.ControlModule;
USING Demo.ControlModule.States.TwoAxisPickPlace;
USING Demo.EquipmentModule;
USING Demo.Utils;

CONFIGURATION HMIConfig
    VAR_GLOBAL
        {S7.extern=ReadWrite}
        {OpcUa = ReadWrite}
        hmiStart:BOOL;

        {S7.extern=ReadWrite}
        {OpcUa = ReadWrite}
        hmiStop:BOOL;

        {S7.extern=ReadWrite}
        {OpcUa = ReadWrite}
        hmiReset:BOOL;

        {S7.extern=Read}
        {OpcUa = Read}
        hmiCount:DINT;

        {S7.extern=Read}
        {OpcUa = Read}
        hmiTwoAxisStateName:STRING;
    END_VAR
END_CONFIGURATION