import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.NetworkFunction;

@@clientName(AzureTrafficCollectors.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(AzureTrafficCollectors.updateTags::parameters.properties,
  "parameters"
);
@@clientLocation(AzureTrafficCollectors.list,
  "AzureTrafficCollectorsByResourceGroup"
);
@@clientLocation(AzureTrafficCollectors.azureTrafficCollectorsBySubscriptionList,
  "AzureTrafficCollectorsBySubscription"
);
@@clientName(AzureTrafficCollectors.azureTrafficCollectorsBySubscriptionList,
  "List"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AzureTrafficCollector.properties);

@@clientName(CollectorPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CollectorPolicy.properties);

@@clientLocation(Operations.list, "NetworkFunction");
@@clientName(Operations.list, "ListOperations");
