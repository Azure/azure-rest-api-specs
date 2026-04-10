import "@azure-tools/typespec-client-generator-core";
import "../Common/main.tsp";

using Azure.ClientGenerator.Core;
using GovernanceAPI;
using Common;

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



