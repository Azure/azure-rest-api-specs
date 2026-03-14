import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CloudError.error);

@@clientName(DefenderForContainersAwsOffering.mdcContainersAgentlessDiscoveryK8s,
  "mdcContainersAgentlessDiscoveryK8S"
);

@@clientName(DefenderForContainersGcpOffering.mdcContainersAgentlessDiscoveryK8s,
  "mdcContainersAgentlessDiscoveryK8S"
);

@@clientName(DefenderCspmAwsOffering.mdcContainersAgentlessDiscoveryK8s,
  "mdcContainersAgentlessDiscoveryK8S"
);

@@clientName(DefenderCspmGcpOffering.mdcContainersAgentlessDiscoveryK8s,
  "mdcContainersAgentlessDiscoveryK8S"
);

@@clientName(SecurityConnectors.createOrUpdate::parameters.resource,
  "securityConnector"
);
@@clientName(SecurityConnectors.update::parameters.properties,
  "securityConnector"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SecurityConnector.properties);
