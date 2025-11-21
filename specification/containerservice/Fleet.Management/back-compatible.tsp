import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

using Microsoft.ContainerService;

// Flatten properties for backward compatibility
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Fleet.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(FleetMember.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Gate.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UpdateRun.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(FleetUpdateStrategy.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AutoUpgradeProfile.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
