import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.StandbyPool {
    @@access(Operations.list, Access.internal, "csharp");

    @@clientName(StandbyVirtualMachinePoolResource,
        "StandbyVirtualMachinePool",
        "csharp"
    );
    @@clientName(ContainerGroupProperties,
        "StandbyContainerGroupProperties",
        "csharp"
    );
    @@clientName(ProvisioningState, "StandbyPoolProvisioningState", "csharp");
    @@clientName(RefillPolicy, "StandbyPoolRefillPolicy", "csharp");
    @@clientName(StandbyVirtualMachinePoolElasticityProfile,
        "StandbyVirtualMachinePoolElasticityPatchProfile",
        "csharp"
    );
    @@clientName(StandbyContainerGroupPoolElasticityProfile,
        "StandbyContainerGroupPoolElasticityPatchProfile",
        "csharp"
    );
    @@clientName(VirtualMachineState, "StandbyVirtualMachineState", "csharp");
    @@clientName(StandbyContainerGroupPoolResource,
        "StandbyContainerGroupPool",
        "csharp"
    );
    @@clientName(StandbyVirtualMachineResource,
        "StandbyVirtualMachine",
        "csharp"
    );
    @@clientName(ContainerGroupProfile,
        "StandbyContainerGroupProfile",
        "csharp"
    );
}
