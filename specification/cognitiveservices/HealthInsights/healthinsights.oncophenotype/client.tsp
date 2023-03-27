import "@azure-tools/typespec-client-generator-core";
import "./route.oncophenotype.tsp";

import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "../healthinsights.openapi/service.tsp";

using Azure.ClientGenerator.Core;

namespace ClientForAzureHealthInsights;

@client({
    name: "CancerProfilingClient",
    service: AzureHealthInsights
})
  interface CancerProfilingClient {
  InferCancerProfile is AzureHealthInsights.OncoPhenotype.CreateJob;
}
