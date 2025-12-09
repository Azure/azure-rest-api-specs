import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AlertsManagement;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrometheusRuleGroupResourcePatchParameters.properties);

@@clientLocation(PrometheusRuleGroupResources.get, "PrometheusRuleGroups");
@@clientLocation(PrometheusRuleGroupResources.createOrUpdate,
  "PrometheusRuleGroups"
);
@@clientName(PrometheusRuleGroupResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(PrometheusRuleGroupResources.update, "PrometheusRuleGroups");
@@clientName(PrometheusRuleGroupResources.update::parameters.properties,
  "parameters"
);
@@clientLocation(PrometheusRuleGroupResources.delete, "PrometheusRuleGroups");
@@clientLocation(PrometheusRuleGroupResources.listByResourceGroup,
  "PrometheusRuleGroups"
);
@@clientLocation(PrometheusRuleGroupResources.listBySubscription,
  "PrometheusRuleGroups"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrometheusRuleGroupResource.properties);
