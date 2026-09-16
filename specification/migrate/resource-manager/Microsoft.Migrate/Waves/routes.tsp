import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";
import "./ApiVersions.tsp";
import "./WebModels/WavePlans/GenerateWavePlan.tsp";
import "./WebModels/WavePlans/CreateWavesFromPlan.tsp";
import "./WebModels/WavePlans/GetWavePlans.tsp";
import "./WebModels/WavePlans/FetchSasUri.tsp";
import "./WebModels/WavePlans/ImportWavePlan.tsp";
import "./WebModels/WavePlans/ImportWavePlanConfig.tsp";
import "./WebModels/WavePlans/ValidateWavePlan.tsp";
import "./WebModels/WavePlans/RefreshWavePlanStatus.tsp";
import "./WebModels/WorkloadConfiguration/WorkloadConfiguration.tsp";
import "./WebModels/Waves/MigrationWaves.tsp";
import "./WebModels/RefreshEntities/RefreshEntities.tsp";
import "./WebModels/MigrationEntity/MigrationEntity.tsp";
import "./WebModels/MigrationEntityGroup/MigrationEntityGroups.tsp";
import "./WebModels/Tasks/Tasks.tsp";
import "./WebModels/Tasks/TaskSummary.tsp";
import "./Common/ArmModels/MigrateProject.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@armResourceOperations
interface MigrateProjects {
  @doc("A long-running resource action.")
  @added(ApiVersions.v2025_12_01_preview)
  generateWavePlan is ArmResourceActionAsync<
    MigrateProject,
    GenerateWavePlanRequest,
    GenerateWavePlanResponse
  >;

  @added(ApiVersions.v2026_02_01_preview)
  @doc("Refresh execution status for migration entities and groups within a migrate project. This operation triggers status updates from partner migration services.")
  @summary("Refresh Migration Entities")
  refreshEntities is ArmResourceActionAsync<
    MigrateProject,
    RefreshEntitiesRequest,
    RefreshEntitiesResponse
  >;

  @added(ApiVersions.v2026_06_01_preview)
  @doc("Create waves from a previously generated wave plan based on assessment data and selected wave names.")
  createWavesFromPlan is ArmResourceActionAsync<
    MigrateProject,
    CreateWavesFromPlanRequest,
    CreateWavesFromPlanResponse
  >;

  @added(ApiVersions.v2026_06_01_preview)
  @doc("List wave plans previously generated for a given assessment, optionally scoped to a migration path.")
  @action("getWavePlans")
  getWavePlans is ArmResourceActionSync<
    MigrateProject,
    GetWavePlansRequest,
    GetWavePlansResponse
  >;

  @added(ApiVersions.v2026_06_01_preview)
  @doc("Mint a write-only SAS URI for customer CSV uploads, later consumed by importWavePlan.")
  @action("fetchSASUri")
  fetchSasUri is ArmResourceActionSync<
    MigrateProject,
    FetchSasUriRequest,
    FetchSasUriResponse
  >;

  @added(ApiVersions.v2026_06_01_preview)
  @doc("Ingest a customer-uploaded wave-plan CSV and produce the updated wave-plan artifacts. Long-running operation.")
  @action("importWavePlan")
  importWavePlan is ArmResourceActionAsync<
    MigrateProject,
    ImportWavePlanRequest,
    ImportWavePlanResponse
  >;

  @added(ApiVersions.v2026_09_01_preview)
  @doc("Ingest a staged wave-plan configuration document and produce the refreshed wave-plan artifacts. Long-running operation.")
  @action("importWavePlanConfig")
  importWavePlanConfig is ArmResourceActionAsync<
    MigrateProject,
    ImportWavePlanConfigRequest,
    ImportWavePlanConfigResponse
  >;

  @added(ApiVersions.v2026_09_01_preview)
  @doc("Validate a customer-uploaded wave-plan CSV without applying it, and report the row and wave counts together with any findings. Long-running operation.")
  @action("validateWavePlan")
  validateWavePlan is ArmResourceActionAsync<
    MigrateProject,
    ValidateWavePlanRequest,
    ValidateWavePlanResponse
  >;

  @added(ApiVersions.v2026_09_01_preview)
  @doc("Re-evaluate whether the materialized wave plan for an assessment and migration path is still current, and persist the refreshed outdated status. Long-running operation.")
  @action("refreshWavePlanStatus")
  refreshWavePlanStatus is ArmResourceActionAsync<
    MigrateProject,
    RefreshWavePlanStatusRequest,
    RefreshWavePlanStatusResponse
  >;
}

@armResourceOperations
interface Waves {
  @added(ApiVersions.v2025_03_30_preview)
  create is ArmResourceCreateOrUpdateAsync<Wave>;

  @added(ApiVersions.v2025_03_30_preview)
  get is ArmResourceRead<Wave>;

  @added(ApiVersions.v2025_03_30_preview)
  listByParent is ArmResourceListByParent<Wave>;

  @added(ApiVersions.v2025_03_30_preview)
  delete is ArmResourceDeleteWithoutOkAsync<Wave>;

  @added(ApiVersions.v2025_03_30_preview)
  @doc("Refresh operation to update wave")
  @Azure.ClientGenerator.Core.clientName("triggerRefresh", "java")
  @Azure.ClientGenerator.Core.clientName("triggerRefresh", "csharp")
  refresh is ArmResourceActionSync<Wave, void, WaveProperties>;

  @added(ApiVersions.v2026_09_01_preview)
  @doc("Export the workload configuration of a wave as a CSV and return a read-only download SAS URI. Long-running operation.")
  @action("exportWorkloadConfiguration")
  exportWorkloadConfiguration is ArmResourceActionAsync<
    Wave,
    void,
    ExportWorkloadConfigurationResponse
  >;

  @added(ApiVersions.v2026_09_01_preview)
  @doc("Validate the workload configuration CSV staged for a wave without applying it. Long-running operation.")
  @action("validateWorkloadConfiguration")
  validateWorkloadConfiguration is ArmResourceActionAsync<
    Wave,
    void,
    ValidateWorkloadConfigurationResponse
  >;

  @added(ApiVersions.v2026_09_01_preview)
  @doc("Apply the validated workload configuration staged for a wave. Long-running operation.")
  @action("importWorkloadConfiguration")
  importWorkloadConfiguration is ArmResourceActionNoResponseContentAsync<
    Wave,
    void
  >;
}

@armResourceOperations
interface MigrationEntities {
  @added(ApiVersions.v2025_03_30_preview)
  create is ArmResourceCreateOrUpdateAsync<MigrationEntity>;

  @added(ApiVersions.v2025_03_30_preview)
  get is ArmResourceRead<MigrationEntity>;

  @added(ApiVersions.v2025_03_30_preview)
  listByParent is ArmResourceListByParent<MigrationEntity>;

  @added(ApiVersions.v2025_03_30_preview)
  delete is ArmResourceDeleteWithoutOkAsync<MigrationEntity>;
}

@armResourceOperations
interface MigrationEntityGroups {
  @added(ApiVersions.v2025_03_30_preview)
  create is ArmResourceCreateOrUpdateAsync<MigrationEntityGroup>;

  @added(ApiVersions.v2025_03_30_preview)
  get is ArmResourceRead<MigrationEntityGroup>;

  @added(ApiVersions.v2025_03_30_preview)
  listByParent is ArmResourceListByParent<MigrationEntityGroup>;

  @added(ApiVersions.v2025_03_30_preview)
  delete is ArmResourceDeleteWithoutOkAsync<MigrationEntityGroup>;
}

@armResourceOperations
interface Tasks {
  @added(ApiVersions.v2025_03_30_preview)
  create is ArmResourceCreateOrUpdateAsync<Task>;

  @added(ApiVersions.v2025_03_30_preview)
  get is ArmResourceRead<Task>;

  @added(ApiVersions.v2025_03_30_preview)
  listByParent is ArmResourceListByParent<Task>;

  @added(ApiVersions.v2025_03_30_preview)
  delete is ArmResourceDeleteWithoutOkAsync<Task>;

  @added(ApiVersions.v2025_03_30_preview)
  @doc("Retrieves task summary across all tasks in the project.")
  @action("taskSummary")
  getSummary is ArmResourceActionSync<
    MigrateProject,
    TaskSummaryRequest,
    TaskSummaryResponse
  >;
}
