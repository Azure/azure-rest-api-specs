import "@azure-tools/typespec-client-generator-core";
import "./route.trialmatcher.tsp";

import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "../HealthInsights.OpenAPI/service.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_1)
@TypeSpec.Versioning.useDependency(
  AzureHealthInsights.ApiVersion.v2023_03_01_preview
)
namespace ClientForAzureHealthInsights;

@client({
  name: "ClinicalMatchingClient",
  service: AzureHealthInsights,
})
interface ClinicalMatchingClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "https://github.com/microsoft/typespec/issues/2037"
  matchTrials is AzureHealthInsights.TrialMatcher.createJob;
}
