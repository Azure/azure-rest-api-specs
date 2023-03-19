import "../healthinsights.openapi/main.tsp";

using Azure.ClientGenerator.Core;

namespace ClientForAzureHealthInsights;


@client({
  name: "CancerProfilingClient",
  service: AzureHealthInsights
  })
  interface CancerProfilingClient {
    InferCancerProfile is AzureHealthInsights.OncoPhenotype.CreateJob;
  }
