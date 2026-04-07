import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.insights;

@@clientLocation(AlertRuleIncidentsOperationGroup.get, "AlertRuleIncidents");
@@clientLocation(AlertRuleIncidentsOperationGroup.listByAlertRule,
  "AlertRuleIncidents"
);
