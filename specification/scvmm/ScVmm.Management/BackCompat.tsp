import "@azure-tools/typespec-azure-core";

using Microsoft.ScVmm;

@@visibility(Azure.Core.Page.nextLink, Lifecycle.Read);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatible"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AvailabilitySet.properties,
  "autorest"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatible"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Cloud.properties,
  "autorest"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatible"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GuestAgent.properties,
  "autorest"
);

// Discriminated type
// #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatible"
// @@Azure.ClientGenerator.Core.Legacy.flattenProperty(InventoryItem.properties,
//   "autorest");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatible"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineInstance.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatible"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineTemplate.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatible"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualNetwork.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatible"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VmInstanceHybridIdentityMetadata.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatible"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VmmServer.properties,
  "autorest"
);
