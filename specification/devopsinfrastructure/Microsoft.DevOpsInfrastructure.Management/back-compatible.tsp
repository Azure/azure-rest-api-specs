import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Microsoft.DevOpsInfrastructure;

// Flatten properties for backward compatibility
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ImageVersion.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Pool.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceDetailsObject.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Microsoft.DevOpsInfrastructure.ResourceSku.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
