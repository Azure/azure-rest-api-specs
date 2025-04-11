import "../../../Common/StandardizedContracts/CommonEnums.tsp";
import "../../../Common/StandardizedContracts/Scope.tsp";
import "../../../Common/StandardizedContracts/CommonModels.tsp";
import "../../../Common/StandardizedContracts/AssessedWorkloadProperties.tsp";
import "../../DataModels/Recommendation/RecommendationResult.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("ARM model of Assessed Web Application.")
@parentResource(AKSAssessment)
model AssessedWebApplication
  is ProxyResource<AssessedWebApplicationProperties> {
  @doc("Assessed Web Application Name.")
  @segment("assessedWebApps")
  @key("assessedWorkload")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  @visibility(Lifecycle.Read)
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Assessed Web Application Properties.")
model AssessedWebApplicationProperties
  is AssessedWorkloadProperties<
    Linkages,
    Recommendations<
      MigrationIssues,
      MigrationSuitability,
      Skus<MigrationSuitability>
    >
  > {
  @doc("Recommendation Result of assessed webapp.")
  recommendationResult: RecommendationResult;

  @doc("Type of assessed webapp.")
  webAppType: WebServerType;
}
