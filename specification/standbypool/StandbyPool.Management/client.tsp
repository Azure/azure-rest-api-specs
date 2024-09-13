import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager.CommonTypes;
using Microsoft.StandbyPool;

@@access(Operations.list, Access.internal, "csharp");

@@clientName(StandbyContainerGroupPoolResource,
  "StandbyContainerGroupPool",
  "csharp"
);
@@clientName(StandbyContainerGroupPoolResourceProperties,
  "StandbyContainerGroupPoolProperties",
  "csharp"
);
@@clientName(StandbyVirtualMachinePoolResource,
  "StandbyVirtualMachinePool",
  "csharp"
);
@@clientName(StandbyVirtualMachinePoolResourceProperties,
  "StandbyVirtualMachinePoolProperties",
  "csharp"
);
@@clientName(StandbyVirtualMachineResource, "StandbyVirtualMachine", "csharp");
@@clientName(StandbyVirtualMachineResourceProperties,
  "StandbyVirtualMachineProperties",
  "csharp"
);
@@clientName(VirtualMachineState, "StandbyVirtualMachineState", "csharp");
@@clientName(ContainerGroupProfile, "StandbyContainerGroupProfile", "csharp");
@@clientName(ContainerGroupProperties,
  "StandbyContainerGroupProperties",
  "csharp"
);
@@clientName(StandbyContainerGroupPoolRuntimeViewResource,
  "StandbyContainerGroupPoolRuntimeView",
  "csharp"
);
@@clientName(StandbyContainerGroupPoolRuntimeViewResourceProperties,
  "StandbyContainerGroupPoolRuntimeViewProperties",
  "csharp"
);
@@clientName(StandbyVirtualMachinePoolRuntimeViewResource,
  "StandbyVirtualMachinePoolRuntimeView",
  "csharp"
);
@@clientName(StandbyVirtualMachinePoolRuntimeViewResourceProperties,
  "StandbyVirtualMachinePoolRuntimeViewProperties",
  "csharp"
);
@@clientName(VirtualMachineInstanceCountSummary,
  "StandbyVirtualMachineInstanceCountSummary",
  "csharp"
);
@@clientName(ProvisioningState, "StandbyProvisioningState", "csharp");
@@clientName(RefillPolicy, "StandbyRefillPolicy", "csharp");
@@clientName(Microsoft.StandbyPool,
  "StandbyPoolManagementClient",
  "javascript"
);
@@clientName(Microsoft.StandbyPool, "StandbyPoolMgmtClient", "python");
