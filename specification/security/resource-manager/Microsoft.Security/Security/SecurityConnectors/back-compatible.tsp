import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CloudError.error);

@@clientName(defenderForContainersAwsOffering.mdcContainersAgentlessDiscoveryK8s,
  "mdcContainersAgentlessDiscoveryK8S"
);

@@clientName(defenderForContainersGcpOffering.mdcContainersAgentlessDiscoveryK8s,
  "mdcContainersAgentlessDiscoveryK8S"
);

@@clientName(defenderCspmAwsOffering.mdcContainersAgentlessDiscoveryK8s,
  "mdcContainersAgentlessDiscoveryK8S"
);

@@clientName(defenderCspmGcpOffering.mdcContainersAgentlessDiscoveryK8s,
  "mdcContainersAgentlessDiscoveryK8S"
);

@@clientName(SecurityConnectors.createOrUpdate::parameters.resource,
  "securityConnector"
);
@@clientName(SecurityConnectors.update::parameters.properties,
  "securityConnector"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecurityConnector.properties);
