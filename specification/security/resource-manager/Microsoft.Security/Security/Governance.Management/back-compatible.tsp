import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CloudError.error);

@@clientName(GovernanceAssignments.createOrUpdate::parameters.resource,
  "governanceAssignment"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GovernanceAssignment.properties);

@@clientName(GovernanceRules.createOrUpdate::parameters.resource,
  "governanceRule"
);
@@clientName(GovernanceRules.execute::parameters.body,
  "ExecuteGovernanceRuleParams"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GovernanceRule.properties);
