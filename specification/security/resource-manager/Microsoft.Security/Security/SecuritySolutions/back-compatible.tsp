import "@azure-tools/typespec-client-generator-core";
import "../Common/main.tsp";

using Azure.ClientGenerator.Core;
using SecuritySolutionsAPI;
using Common;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CloudError.error);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(securitySolutionsReferenceData.properties);

@@clientLocation(AllowedConnectionsResources.get, "AllowedConnections");
@@clientLocation(AllowedConnectionsResources.listByHomeRegion,
  "AllowedConnections"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AllowedConnectionsResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DiscoveredSecuritySolution.properties);

@@clientName(JitNetworkAccessPolicies.createOrUpdate::parameters.resource,
  "body"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(JitNetworkAccessPolicy.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecuritySolution.properties);

@@clientLocation(ServerVulnerabilityAssessments.get,
  "ServerVulnerabilityAssessment"
);
@@clientLocation(ServerVulnerabilityAssessments.createOrUpdate,
  "ServerVulnerabilityAssessment"
);
@@clientLocation(ServerVulnerabilityAssessments.delete,
  "ServerVulnerabilityAssessment"
);
@@clientLocation(ServerVulnerabilityAssessments.listByExtendedResource,
  "ServerVulnerabilityAssessment"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerVulnerabilityAssessment.properties);

@@clientLocation(TopologyResources.get, "Topology");
@@clientLocation(TopologyResources.listByHomeRegion, "Topology");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TopologyResource.properties);

@@clientLocation(AllowedConnectionsOperationGroup.list, "AllowedConnections");

@@clientLocation(DiscoveredSecuritySolutionsOperationGroup.list,
  DiscoveredSecuritySolutions
);

@@clientLocation(ExternalSecuritySolutionsOperationGroup.list,
  ExternalSecuritySolutions
);

@@clientLocation(JitNetworkAccessPoliciesOperationGroup.list,
  JitNetworkAccessPolicies
);
@@clientLocation(JitNetworkAccessPoliciesOperationGroup.listByResourceGroup,
  JitNetworkAccessPolicies
);

@@clientLocation(SecuritySolutionsOperationGroup.list, SecuritySolutions);

@@clientLocation(SecuritySolutionsReferenceDataOperationGroup.list,
  "SecuritySolutionsReferenceData"
);
@@clientLocation(SecuritySolutionsReferenceDataOperationGroup.listByHomeRegion,
  "SecuritySolutionsReferenceData"
);

@@clientLocation(TopologyOperationGroup.list, "Topology");
@@visibility(AllowedConnectionsResource.properties, Lifecycle.Read);
@@visibility(TopologyResource.properties, Lifecycle.Read);
