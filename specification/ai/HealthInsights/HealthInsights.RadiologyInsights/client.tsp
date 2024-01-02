import "@azure-tools/typespec-client-generator-core";
import "./route.radiologyinsights.tsp";

import "@typespec/rest";
import "@typespec/http";
import "../HealthInsights.OpenAPI/service.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_1)
@TypeSpec.Versioning.useDependency(AzureHealthInsights.ApiVersion.v2023_09_01_Preview)
namespace ClientForAzureHealthInsights;

@client({
  name: "RadiologyInsightsClient",
  service: AzureHealthInsights,
})
interface RadiologyInsightsClient {
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling through operation-location"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "https://github.com/microsoft/typespec/issues/2037"
  InferRadiologyInsights is AzureHealthInsights.RadiologyInsights.createJob;
}
