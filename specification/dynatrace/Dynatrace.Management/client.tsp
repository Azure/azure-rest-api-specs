import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Dynatrace.Observability;

@@clientName(MonitorResources.update::parameters.properties, "resource");
@@clientName(MonitorResources.listLinkableEnvironments::parameters.body,
  "request"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MonitorResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TagRule.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DynatraceSingleSignOnResource.properties);
