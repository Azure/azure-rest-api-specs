import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CloudError.error);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SecuritySolutionsReferenceData.properties);

@@clientLocation(AllowedConnectionsResources.get, "AllowedConnections");
@@clientLocation(AllowedConnectionsResources.listByHomeRegion,
  "AllowedConnections"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AllowedConnectionsResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DiscoveredSecuritySolution.properties);

@@clientName(JitNetworkAccessPolicies.createOrUpdate::parameters.resource,
  "body"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(JitNetworkAccessPolicy.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServerVulnerabilityAssessment.properties);

@@clientLocation(TopologyResources.get, "Topology");
@@clientLocation(TopologyResources.listByHomeRegion, "Topology");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
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
  "securitySolutionsReferenceData"
);
@@clientLocation(SecuritySolutionsReferenceDataOperationGroup.listByHomeRegion,
  "SecuritySolutionsReferenceData"
);

@@clientLocation(TopologyOperationGroup.list, "Topology");
