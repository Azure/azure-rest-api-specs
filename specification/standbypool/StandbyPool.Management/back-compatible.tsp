import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./standbyVMPool.tsp";
import "./standbyVM.tsp";
import "./standbyVirtualMachinePoolRuntimeView.tsp";
import "./standbyContainerGroupPool.tsp";
import "./standbyContainerGroupPoolRuntimeView.tsp";

using Microsoft.StandbyPool;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StandbyContainerGroupPoolResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StandbyContainerGroupPoolRuntimeViewResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StandbyVirtualMachinePoolResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StandbyVirtualMachinePoolRuntimeViewResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StandbyVirtualMachineResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
