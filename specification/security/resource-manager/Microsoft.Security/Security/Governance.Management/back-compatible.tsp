import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CloudError.error);

@@clientName(GovernanceAssignments.createOrUpdate::parameters.resource,
  "governanceAssignment"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(GovernanceAssignment.properties);

@@clientName(GovernanceRules.createOrUpdate::parameters.resource,
  "governanceRule"
);
@@clientName(GovernanceRules.execute::parameters.body,
  "ExecuteGovernanceRuleParams"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(GovernanceRule.properties);
