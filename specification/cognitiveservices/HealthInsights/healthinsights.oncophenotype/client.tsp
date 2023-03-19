import "@azure-tools/typespec-client-generator-core";
import "../healthinsights.openapi/service.tsp";
import "./route.oncophenotype.tsp";

using Azure.ClientGenerator.Core;

namespace ClientForAzureHealthInsights;

@client({
    name: "CancerProfilingClient",
    service: AzureHealthInsights
})
  interface CancerProfilingClient {
  InferCancerProfile is AzureHealthInsights.OncoPhenotype.CreateJob;
}
