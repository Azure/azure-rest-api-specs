import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

using Microsoft.LoadTestService;

// Flatten properties for backward compatibility
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LoadTestMappingResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LoadTestProfileMappingResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LoadTestResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MaxMonthlyVirtualUserHoursResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(QuotaResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
