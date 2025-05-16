import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Datadog;

@@clientName(DatadogMonitorResources.create::parameters.resource, "body");
@@clientName(DatadogMonitorResources.update::parameters.properties, "body");

@@clientName(TagRules.createOrUpdate::parameters.resource, "body");

@@clientName(DatadogSingleSignOnResources.createOrUpdate::parameters.resource,
  "body"
);

@@clientName(MonitoredSubscriptions.createorUpdate::parameters.resource,
  "body"
);
@@clientName(MonitoredSubscriptions.update::parameters.properties, "body");

@@clientName(BillingInfoResponse, "BillingInfoResult", "csharp");
@@clientName(CreateResourceSupportedResponse,
  "CreateResourceSupportedResult",
  "csharp"
);
