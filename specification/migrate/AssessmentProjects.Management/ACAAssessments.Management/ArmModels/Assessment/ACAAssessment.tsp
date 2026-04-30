import "../../Common/StandardizedContracts/CommonEnums.tsp";
import "../../Common/StandardizedContracts/Scope.tsp";
import "../../Common/StandardizedContracts/CommonModels.tsp";
import "../../Common/StandardizedContracts/AssessmentProperties.tsp";
import "../../DataModels/Assessment/ACAAssessmentSettings.tsp";
import "../../Common/ArmModels/AssessmentProjectV2.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("ARM model of Azure Container Apps Assessment.")
@parentResource(AssessmentProject)
model ContainerAppsAssessment
  is ProxyResource<ContainerAppsAssessmentProperties> {
  @doc("Azure Container Apps Assessment Name.")
  @segment("containerAppsAssessments")
  @key("assessmentName")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  @visibility(Lifecycle.Read)
  name: string;
}

@doc("Azure Container Apps Assessment Properties.")
model ContainerAppsAssessmentProperties
  is AssessmentProperties<
    Scope,
    ContainerAppsAssessmentSettings,
    AssessmentDetails
  >;
