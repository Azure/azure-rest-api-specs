import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

using Microsoft.ServiceNetworking;

// Flatten properties for backward compatibility
<<<<<<< HEAD
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
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Association.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Frontend.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SecurityPolicy.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(TrafficController.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
