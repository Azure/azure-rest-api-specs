import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.ContainerService,
  "ContainerServiceFleetManagementClient",
  "java"
);

@@clientName(Microsoft.ContainerService.APIServerAccessProfile,
  "ApiServerAccessProfile",
  "java"
);
@@clientName(Azure.ResourceManager.EntityTagProperty.eTag, "etag", "java");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Existing usage of legacy type"
@@clientName(Azure.ResourceManager.Legacy.ManagedServiceIdentityV4,
  "ManagedServiceIdentity"
);

#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.TrackedResource.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.ProxyResource.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.Foundations.ProxyResourceUpdateModel.properties
);
@@clientName(Microsoft.ContainerService,
  "ContainerServiceFleetClient",
  "javascript"
);
