import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

@@visibility(Azure.Core.Page.nextLink, Lifecycle.Read);

using Microsoft.ScVmm;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AvailabilitySet.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Cloud.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GuestAgent.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineInstance.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineTemplate.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualNetwork.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VmInstanceHybridIdentityMetadata.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VmmServer.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
