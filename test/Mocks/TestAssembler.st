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
END_NAMESPACE