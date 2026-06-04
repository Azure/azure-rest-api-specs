import "./Common/DataModels/DownloadUrl.tsp";
import "./Common/ArmModels/AssessmentProjectV2.tsp";
import "./WebModels/HeterogeneousAssessments.tsp";
import "./WebModels/HeterogeneousAssessmentsSummary.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@armResourceOperations
interface HeterogeneousAssessmentOperations {
  @added(HaApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<HeterogeneousAssessment>;

  @added(HaApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<HeterogeneousAssessment>;

  @added(HaApiVersions.v2024_03_03_preview)
  create is ArmResourceCreateOrUpdateAsync<HeterogeneousAssessment>;

  @added(HaApiVersions.v2024_03_03_preview)
  delete is ArmResourceDeleteSync<HeterogeneousAssessment>;
}

@armResourceOperations
interface HeterogeneousAssessmentSummaryOperations {
  @added(HaApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<HeterogeneousAssessmentSummary>;

  @added(HaApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<HeterogeneousAssessmentSummary>;
}
