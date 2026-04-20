import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Devices;

@@clientName(Microsoft.Devices, "IotHubClient", "javascript");
@@clientName(IotHubDescriptions.getEndpointHealth,
  "listEndpointHealth",
  "javascript"
);
@@clientName(IotHubDescriptions.getQuotaMetrics,
  "listQuotaMetrics",
  "javascript"
);
@@clientName(IotHubDescriptions.getValidSkus, "listValidSkus", "javascript");
