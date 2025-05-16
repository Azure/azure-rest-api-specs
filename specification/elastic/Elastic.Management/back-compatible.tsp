import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Elastic;

@@clientName(ElasticMonitorResources.create::parameters.resource, "body");
@@clientName(ElasticMonitorResources.update::parameters.properties, "body");

@@clientName(MonitoredSubscriptions.createorUpdate::parameters.resource,
  "body"
);
@@clientName(MonitoredSubscriptions.update::parameters.properties, "body");

@@clientName(OpenAIIntegrationRPModels.createOrUpdate::parameters.resource,
  "body"
);

@@clientName(TagRules.createOrUpdate::parameters.resource, "body");

@@OpenAPI.extension(ElasticVersionsListResponse.value,
  "x-ms-identifiers",
  #["properties/version"]
);
