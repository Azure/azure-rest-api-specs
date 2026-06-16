import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AlertRulesIncidents;

@@clientLocation(AlertRuleIncidentsOperationGroup.get, "AlertRuleIncidents");
@@clientLocation(AlertRuleIncidentsOperationGroup.listByAlertRule,
  "AlertRuleIncidents"
);
@@TypeSpec.Rest.segment(Azure.ResourceManager.ResourceGroupParameter.resourceGroupName,
  "resourcegroups"
);
