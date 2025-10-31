import "../Common/StandardizedContracts/CommonEnums.tsp";
import "../Common/StandardizedContracts/CommonModels.tsp";
import "../Common/StandardizedContracts/AssessedWorkloadProperties.tsp";
import "./WebAppCompoundAssessments.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Assessed web app resource.")
@added(WACAApiVersions.v2025_09_09_preview)
@parentResource(CompoundAssessment)
model AssessedWebApps is ProxyResource<AssessedWebAppsProperties> {
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
@added(WACAApiVersions.v2025_09_09_preview)
model AssessedWebAppsProperties
  is AssessedWorkloadProperties<Linkages, CompoundAssessmentRecommendations> {
  @doc("Timestamp of the assessment creation.")
  createdTimestamp: string;

  @doc("Timestamp of the assessment last updated.")
  updatedTimestamp: string;

  @doc("Type of assessed webapp.")
  webAppType: WebServerType;
}

@added(WACAApiVersions.v2025_09_09_preview)
model CompoundAssessmentRecommendations
  is Recommendations<
    MigrationIssues,
    MigrationSuitability,
    Skus<MigrationSuitability>
  > {
  @doc("Arm id of the assessed resource. to get extended details.")
  extendedDetailsAssessedResourceArmId: string;
}
