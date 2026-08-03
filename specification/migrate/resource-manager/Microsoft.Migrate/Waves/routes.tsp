import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";
import "./ApiVersions.tsp";
import "./WebModels/Waves/GenerateWavePlan.tsp";
import "./WebModels/Waves/FetchSasUri.tsp";
import "./WebModels/Waves/ImportWavePlan.tsp";
import "./WebModels/Waves/GetWavePlans.tsp";
import "./WebModels/Waves/CreateWavesFromPlan.tsp";
import "./WebModels/Waves/MigrationWaves.tsp";
import "./WebModels/RefreshEntities/RefreshEntities.tsp";
import "./WebModels/MigrationEntity/MigrationEntity.tsp";
import "./WebModels/MigrationEntityGroup/MigrationEntityGroups.tsp";
import "./WebModels/Tasks/Tasks.tsp";
import "./WebModels/Tasks/TaskSummary.tsp";
import "./WebModels/Runbook/Runbook.tsp";
import "./WebModels/RunbookExecution/RunbookExecution.tsp";
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
  @doc("Mints a short-lived write-targeted SAS URL pointing into a server-managed CSV staging container. Callers PUT a wave-plan CSV to this URL and then reference the same URL on importWavePlan. Empty request body; synchronous (no LRO).")
  @summary("Fetch Upload SAS URI")
  @action("fetchSASUri")
  fetchSasUri is ArmResourceActionSync<
    MigrateProject,
    void,
    FetchSasUriResponse
  >;

  @added(ApiVersions.v2026_06_01_preview)
  @doc("Imports a customer-authored wave plan from a CSV upload as a new wave plan resource; supersedes any existing plan for the (assessmentArmId, migrationPath) tuple.")
  @summary("Import Wave Plan")
  importWavePlan is ArmResourceActionAsync<
    MigrateProject,
    ImportWavePlanRequest,
    ImportWavePlanResponse
  >;

  @added(ApiVersions.v2026_06_01_preview)
  @doc("Lists wave plans for an assessment. When migrationPath is supplied, restricts results to that (assessmentArmId, migrationPath) combination. Returns the entire result set in a single page; ordered by wavePlanVersion descending within each migration path.")
  @summary("Get Wave Plans")
  getWavePlans is ArmResourceActionSync<
    MigrateProject,
    GetWavePlansRequest,
    GetWavePlansResponse
  >;

  @added(ApiVersions.v2026_06_01_preview)
  @doc("Creates Wave resources from the latest Active wave plan for the supplied (assessmentArmId, migrationPath) tuple.")
  @summary("Create Waves From Plan")
  createWavesFromPlan is ArmResourceActionAsync<
    MigrateProject,
    CreateWavesFromPlanRequest,
    CreateWavesFromPlanResponse
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

@armResourceOperations
interface Runbooks {
  @added(ApiVersions.v2026_08_01_preview)
  create is ArmResourceCreateOrUpdateAsync<Runbook>;

  @added(ApiVersions.v2026_08_01_preview)
  get is ArmResourceRead<Runbook>;

  @added(ApiVersions.v2026_08_01_preview)
  listByParent is ArmResourceListByParent<Runbook>;

  @added(ApiVersions.v2026_08_01_preview)
  delete is ArmResourceDeleteWithoutOkAsync<Runbook>;

  @added(ApiVersions.v2026_08_01_preview)
  @action("execute")
  execute is ArmResourceActionAsync<Runbook, void, RunbookExecution>;

  @added(ApiVersions.v2026_08_01_preview)
  @action("regenerate")
  regenerate is ArmResourceActionAsync<Runbook, void, Runbook>;

  @added(ApiVersions.v2026_08_01_preview)
  @action("generateDownloadUrl")
  generateDownloadUrl is ArmResourceActionSync<
    Runbook,
    void,
    RunbookDownloadUrlResponse
  >;

  @added(ApiVersions.v2026_08_01_preview)
  @action("generateInputUploadUrl")
  generateInputUploadUrl is ArmResourceActionSync<
    Runbook,
    void,
    RunbookInputUploadUrlResponse
  >;

  @added(ApiVersions.v2026_08_01_preview)
  @action("generateInputDownloadUrl")
  generateInputDownloadUrl is ArmResourceActionSync<
    Runbook,
    void,
    RunbookInputDownloadUrlResponse
  >;

  @added(ApiVersions.v2026_08_01_preview)
  @action("validateInput")
  validateInput is ArmResourceActionAsync<Runbook, void, Runbook>;

  @added(ApiVersions.v2026_08_01_preview)
  @action("addStep")
  addStep is ArmResourceActionAsync<
    Runbook,
    RunbookStepAddRequest,
    Runbook
  >;

  @added(ApiVersions.v2026_08_01_preview)
  @action("updateStep")
  updateStep is ArmResourceActionAsync<
    Runbook,
    RunbookStepUpdateRequest,
    Runbook
  >;

  @added(ApiVersions.v2026_08_01_preview)
  @action("deleteStep")
  deleteStep is ArmResourceActionAsync<
    Runbook,
    RunbookStepDeleteRequest,
    Runbook
  >;

  @added(ApiVersions.v2026_08_01_preview)
  @action("mergeWorkstreams")
  mergeWorkstreams is ArmResourceActionAsync<
    Runbook,
    RunbookWorkstreamsMergeRequest,
    Runbook
  >;

  @added(ApiVersions.v2026_08_01_preview)
  @action("splitWorkstream")
  splitWorkstream is ArmResourceActionAsync<
    Runbook,
    RunbookWorkstreamSplitRequest,
    Runbook
  >;
}

@armResourceOperations
interface RunbookExecutions {
  @added(ApiVersions.v2026_08_01_preview)
  get is ArmResourceRead<RunbookExecution>;

  @added(ApiVersions.v2026_08_01_preview)
  listByParent is ArmResourceListByParent<RunbookExecution>;

  @added(ApiVersions.v2026_08_01_preview)
  update is ArmResourcePatchAsync<
    RunbookExecution,
    RunbookExecutionPatchProperties
  >;

  @added(ApiVersions.v2026_08_01_preview)
  @action("generateDownloadUrl")
  generateDownloadUrl is ArmResourceActionSync<
    RunbookExecution,
    void,
    RunbookExecutionDownloadUrlResponse
  >;

  @added(ApiVersions.v2026_08_01_preview)
  @action("performAction")
  performAction is ArmResourceActionAsync<
    RunbookExecution,
    RunbookExecutionActionRequest,
    RunbookExecution
  >;

  @added(ApiVersions.v2026_08_01_preview)
  @action("updateStepStatus")
  updateStepStatus is ArmResourceActionAsync<
    RunbookExecution,
    RunbookExecutionActionRequest,
    RunbookExecution
  >;

  @added(ApiVersions.v2026_08_01_preview)
  @action("provideApproval")
  provideApproval is ArmResourceActionAsync<
    RunbookExecution,
    RunbookExecutionActionRequest,
    RunbookExecution
  >;
}
