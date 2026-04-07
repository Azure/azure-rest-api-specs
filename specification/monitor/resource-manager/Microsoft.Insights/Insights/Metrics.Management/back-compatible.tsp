import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Insights;

@@clientLocation(MetricDefinitionsOperationGroup.listAtSubscriptionScope,
  "MetricDefinitions"
);
@@clientLocation(MetricDefinitionsOperationGroup.list, "MetricDefinitions");

@@clientLocation(MetricNamespacesOperationGroup.list, "MetricNamespaces");

@@clientLocation(MetricsOperationGroup.listAtSubscriptionScope, "Metrics");
@@clientLocation(MetricsOperationGroup.listAtSubscriptionScopePost, "Metrics");
@@clientLocation(MetricsOperationGroup.list, "Metrics");
