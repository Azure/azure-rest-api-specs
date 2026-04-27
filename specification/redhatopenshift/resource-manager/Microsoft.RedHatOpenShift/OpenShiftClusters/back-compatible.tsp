import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.RedHatOpenShift;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OpenShiftClusterUpdate.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OpenShiftVersion.properties
);

@@clientLocation(PlatformWorkloadIdentityRoleSets.get,
  "PlatformWorkloadIdentityRoleSet"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PlatformWorkloadIdentityRoleSet.properties
);

@@clientName(OpenShiftClusters.createOrUpdate::parameters.resource,
  "parameters"
);

@@clientName(OpenShiftClusters.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OpenShiftCluster.properties
);
