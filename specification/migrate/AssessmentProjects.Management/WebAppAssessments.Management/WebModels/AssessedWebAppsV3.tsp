import "../../Common/StandardizedContracts/CommonEnums.tsp";
import "../../Common/StandardizedContracts/Scope.tsp";
import "../../Common/StandardizedContracts/CommonModels.tsp";
import "../../Common/StandardizedContracts/AssessedWorkloadProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Assessed web app resource.")
@parentResource(WebAppAssessmentV3)
model AssessedWebAppV3 is ProxyResource<AssessedWebAppV3Properties> {
  @doc("Assessed web app ARM name")
  @key("assessedWebAppName")
  @segment("assessedWebApps")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Properties of an assessed web app.")
model AssessedWebAppV3Properties
  is AssessedWorkloadProperties<
    Linkages,
    Recommendations<
      MigrationIssues,
      MigrationSuitability,
      Skus<MigrationSuitability>
    >
  > {
  @doc("Timestamp of the assessment creation.")
  createdTimestamp: string;

  @doc("Timestamp of the assessment last updated.")
  updatedTimestamp: string;

  @doc("Type of assessed webapp.")
  webAppType: WebServerType;
}
