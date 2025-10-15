import "./Common/DataModels/DownloadUrl.tsp";
import "./WebModels/WebAppCompoundAssessments.tsp";
import "./WebModels/WacaSummary.tsp";
import "./WebModels/AssessedWebApps.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

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

@armResourceOperations
interface AssessedWebAppOperations {
  @added(WACAApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<AssessedWebApps>;

  @added(WACAApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<AssessedWebApps>;
}
