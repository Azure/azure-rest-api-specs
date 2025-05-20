import "../Common/DataModels/DownloadUrl.tsp";
import "../Common/ArmModels/AssessmentProjectV2.tsp";
import "./WebModels/WebAppAssessmentV3.tsp";
import "./WebModels/WebAppAssessmentV3Summary.tsp";
import "./WebModels/WebAppServicePlanV3.tsp";
import "./WebModels/AssessedWebAppsV3.tsp";
import "./WebModels/WebAppGraphAssessmentOptions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@armResourceOperations
interface WebAppAssessmentV3Operations {
  @added(WAApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<WebAppAssessmentV3>;

  @added(WAApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<WebAppAssessmentV3>;

  @added(WAApiVersions.v2024_03_03_preview)
  create is ArmResourceCreateOrUpdateAsync<WebAppAssessmentV3>;

  @added(WAApiVersions.v2024_03_03_preview)
  delete is ArmResourceDeleteSync<WebAppAssessmentV3>;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Download URL Post Action body is empty."
  @added(WAApiVersions.v2024_03_03_preview)
  downloadUrl is ArmResourceActionAsync<WebAppAssessmentV3, {}, DownloadUrl>;
}

@armResourceOperations
interface WebAppAssessmentV3SummaryOperations {
  @added(WAApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<WebAppAssessmentV3Summary>;

  @added(WAApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<WebAppAssessmentV3Summary>;
}

@armResourceOperations
interface WebAppServicePlansOperations {
  @added(WAApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<WebAppServicePlanV3>;

  @added(WAApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<WebAppServicePlanV3>;
}

@armResourceOperations
interface AssessedWebAppsV3Operations {
  @added(WAApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<AssessedWebAppV3>;

  @added(WAApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<AssessedWebAppV3>;
}
@armResourceOperations
interface WebAppGraphAssessmentOptionsOperations {
  @added(WAApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<WepAppGraphAssessmentOptions>;

  @added(WAApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<WepAppGraphAssessmentOptions>;
}
