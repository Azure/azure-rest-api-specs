import "@azure-tools/typespec-client-generator-core";
import "./route.oncophenotype.tsp";

import "@typespec/rest";
import "@typespec/http";
import "../service.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(
  AzureHealthInsights.ApiVersion.v2023_09_01_Preview
)
namespace ClientForAzureHealthInsights;

@client({
  name: "CancerProfilingClient",
  service: AzureHealthInsights,
})
interface CancerProfilingClient {
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling through operation-location"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "https://github.com/microsoft/typespec/issues/2037"
  inferCancerProfile is AzureHealthInsights.OncoPhenotype.createJob;
}
