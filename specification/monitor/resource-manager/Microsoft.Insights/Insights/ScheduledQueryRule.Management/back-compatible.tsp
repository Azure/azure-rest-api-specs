import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Insights;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ScheduledQueryRuleResourcePatch.properties);

@@clientLocation(ScheduledQueryRuleResources.get, "ScheduledQueryRules");
@@clientLocation(ScheduledQueryRuleResources.createOrUpdate,
  "ScheduledQueryRules"
);
@@clientName(ScheduledQueryRuleResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ScheduledQueryRuleResources.update, "ScheduledQueryRules");
@@clientName(ScheduledQueryRuleResources.update::parameters.properties,
  "parameters"
);
@@clientLocation(ScheduledQueryRuleResources.delete, "ScheduledQueryRules");
@@clientLocation(ScheduledQueryRuleResources.listByResourceGroup,
  "ScheduledQueryRules"
);
@@clientLocation(ScheduledQueryRuleResources.listBySubscription,
  "ScheduledQueryRules"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ScheduledQueryRuleResource.properties);
