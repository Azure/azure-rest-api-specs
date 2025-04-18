import "../Common/DataModels/DownloadUrl.tsp";
import "./WebModels/WebAppCompoundAssessments.tsp";
import "./WebModels/WacaSummary.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@armResourceOperations
interface CompoundAssessmentOperations {
  @added(WACAApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<CompoundAssessment>;

  @added(WACAApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<CompoundAssessment>;

  @added(WACAApiVersions.v2024_03_03_preview)
  create is ArmResourceCreateOrUpdateAsync<CompoundAssessment>;

  @added(WACAApiVersions.v2024_03_03_preview)
  delete is ArmResourceDeleteSync<CompoundAssessment>;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Download URL Post body is empty."
  @added(WACAApiVersions.v2024_03_03_preview)
  downloadUrl is ArmResourceActionAsync<CompoundAssessment, {}, DownloadUrl>;
}

@armResourceOperations
interface CompoundAssessmentSummaryOperations {
  @added(WACAApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<WebAppCompoundAssessmentSummary>;

  @added(WACAApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<WebAppCompoundAssessmentSummary>;
}
