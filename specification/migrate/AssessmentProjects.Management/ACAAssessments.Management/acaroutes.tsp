import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./ArmModels/Assessed/AssessedWebApplication.tsp";
import "./ArmModels/Assessment/ACAAssessment.tsp";
import "./ArmModels/ContainerApps/ACAContainerAppEnvironment.tsp";
import "./ArmModels/CostDetails/ACACostDetails.tsp";
import "./ArmModels/Options/ACAAssessmentOptions.tsp";
import "./ArmModels/Summary/ACASummary.tsp";
import "./Common/DataModels/DownloadUrl.tsp";

import "./ACAApiVersions.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@armResourceOperations
interface ACAAssessmentOperations {
  @added(ACAApiVersions.v2025_09_09_preview)
  create is ArmResourceCreateOrUpdateAsync<ACAAssessment>;

  @added(ACAApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<ACAAssessment>;

  @added(ACAApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<ACAAssessment>;

  @added(ACAApiVersions.v2025_09_09_preview)
  delete is ArmResourceDeleteSync<ACAAssessment>;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Download URL Post Action body is empty."
  @added(ACAApiVersions.v2025_09_09_preview)
  @doc("Get URL for downloading ACA Assessment Report.")
  downloadUrl is ArmResourceActionAsync<ACAAssessment, {}, DownloadUrl>;
}

@armResourceOperations
interface AssessedWebApplicationOperations {
  @added(ACAApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<AssessedWebApplication>;

  @added(ACAApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<AssessedWebApplication>;
}

@armResourceOperations
interface ACAOptionsOperations {
  @added(ACAApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<ACAAssessmentOptions>;

  @added(ACAApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<ACAAssessmentOptions>;
}

@armResourceOperations
interface ACASummaryOperations {
  @added(ACAApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<ACASummary>;

  @added(ACAApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<ACASummary>;
}

@armResourceOperations
interface ACAManagedEnvironmentOperations {
  @added(ACAApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<ACAManagedEnvironment>;

  @added(ACAApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<ACAManagedEnvironment>;
}

@armResourceOperations
interface ACACostDetailOperations {
  @added(ACAApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<ACACostDetail>;
}
