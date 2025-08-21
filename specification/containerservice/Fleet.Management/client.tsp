import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.ContainerService,
  "ContainerServiceFleetManagementClient",
  "java"
);

@@clientName(Microsoft.ContainerService,
  "ContainerServiceFleetMgmtClient",
  "python"
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Existing usage of legacy type"
@@clientName(Azure.ResourceManager.Legacy.ManagedServiceIdentityType.SystemAndUserAssigned,
  "SYSTEM_ASSIGNED_USER_ASSIGNED",
  "python"
);
@@clientName(Microsoft.ContainerService.FleetMembers.updateAsync,
  "begin_update",
  "python"
);
@@clientName(Microsoft.ContainerService.Fleets.create,
  "begin_create_or_update",
  "python"
);
@@clientName(Microsoft.ContainerService.Fleets.updateAsync,
  "begin_update",
  "python"
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
