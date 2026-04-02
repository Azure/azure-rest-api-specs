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
interface ContainerAppsAssessmentOperations {
  @added(ContainerAppsApiVersions.v2025_09_09_preview)
  create is ArmResourceCreateOrUpdateAsync<ContainerAppsAssessment>;

  @added(ContainerAppsApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<ContainerAppsAssessment>;

  @added(ContainerAppsApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<ContainerAppsAssessment>;

  @added(ContainerAppsApiVersions.v2025_09_09_preview)
  delete is ArmResourceDeleteSync<ContainerAppsAssessment>;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Download URL Post Action body is empty."
  @added(ContainerAppsApiVersions.v2025_09_09_preview)
  @doc("Get URL for downloading Azure Container Apps Assessment Report.")
  downloadUrl is ArmResourceActionAsync<
    ContainerAppsAssessment,
    {},
    DownloadUrl
  >;
}

@armResourceOperations
interface AssessedWebApplicationOperations {
  @added(ContainerAppsApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<AssessedWebApplication>;

  @added(ContainerAppsApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<AssessedWebApplication>;
}

@armResourceOperations
interface ContainerAppsOptionsOperations {
  @added(ContainerAppsApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<ContainerAppsAssessmentOptions>;

  @added(ContainerAppsApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<ContainerAppsAssessmentOptions>;
}

@armResourceOperations
interface ContainerAppsSummaryOperations {
  @added(ContainerAppsApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<ContainerAppsSummary>;

  @added(ContainerAppsApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<ContainerAppsSummary>;
}

@armResourceOperations
interface ContainerAppsManagedEnvironmentOperations {
  @added(ContainerAppsApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<ContainerAppsManagedEnvironment>;

  @added(ContainerAppsApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<ContainerAppsManagedEnvironment>;
}

@armResourceOperations
interface ContainerAppsCostDetailOperations {
  @added(ContainerAppsApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<ContainerAppsCostDetail>;
}
