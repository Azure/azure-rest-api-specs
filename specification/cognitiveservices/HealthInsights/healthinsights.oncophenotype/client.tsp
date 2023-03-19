import "../healthinsights.openapi/main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace ClientForAzureHealthInsights;


@client({
  name: "CancerProfilingClient",
  service: AzureHealthInsights
  })
  interface CancerProfilingClient {
    InferCancerProfile is AzureHealthInsights.OncoPhenotype.CreateJob;
  }
