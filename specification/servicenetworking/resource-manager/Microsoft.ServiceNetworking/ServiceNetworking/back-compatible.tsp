import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

using Microsoft.ServiceNetworking;

// Flatten properties for backward compatibility
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Association.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Frontend.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SecurityPolicy.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(TrafficController.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
