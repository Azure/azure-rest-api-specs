import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using Microsoft.Migrate;

// JavaScript SDK visibility workaround:
// For write operations whose body models contain server-side read-only properties,
// provide write-specific models that omit those fields so SDK users see a clean API.
// Pattern: https://github.com/Azure/azure-rest-api-specs/pull/42784

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is defined in a separate spec for Microsoft.Migrate namespace"
namespace Microsoft.Migrate {
  // ===== Task create-specific models =====
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Write-specific model intentionally omits server-side read-only fields including provisioningState"
  @doc("Task properties for create operations, omitting server-side read-only fields (taskType, isEditable, completionDate, provisioningState).")
  model TaskPropertiesCreate {
    @doc("associated Wave Id")
    scopeId: armResourceIdentifier<[
      {
        type: "Microsoft.Migrate/migrateProjects/waves";
      },
      {
        type: "Microsoft.Migrate/migrateProjects/migrationEntities";
      },
      {
        type: "Microsoft.Migrate/migrateProjects/migrationEntityGroups";
      }
    ]>;

    @doc("Task Stage")
    stage?: string;

    @doc("Task Display Name")
    displayName: string;

    @doc("Task Status")
    status: string;

    @doc("Task Scope")
    scope: TaskScope;

    @doc("Task Description")
    description?: string;
  }

  @parentResource(MigrateProject)
  @doc("Task resource for create operations.")
  model TaskCreate is ProxyResource<TaskPropertiesCreate> {
    @doc("Task ARM name")
    @key("taskName")
    @segment("tasks")
    @path
    @pattern("^[^<>&:\\?/#]{1,260}$")
    name: string;

    ...EntityTagProperty;
  }
}

@@alternateType(Tasks.create::parameters.resource, TaskCreate, "javascript");

// ===== C# client customizations =====

// Resolve CS0102 collision caused by safe-flattening TaskStatusCounts.statusCounts onto TaskSummaryItem.
@@clientName(TaskSummaryItem.statusCounts, "StatusCountsInternal", "csharp");

// Fix typo in TaskProperties.displayName doc comment.
@@doc(TaskProperties.displayName, "Task Display Name");

// Rename single-word generic resource trios and associated models to include RP/domain context.
@@clientName(Wave, "MigrateWave", "csharp");
@@clientName(WaveProperties, "MigrateWaveProperties", "csharp");
@@clientName(WavePlanListItem, "MigrateWavePlanListItem", "csharp");
@@clientName(WavePlanSummary, "MigrateWavePlanSummary", "csharp");
@@clientName(WaveSelectionItem, "MigrateWaveSelectionItem", "csharp");
@@clientName(PlanSource, "MigrateWavePlanSource", "csharp");
@@clientName(ArtifactProperties, "MigrateWavePlanArtifactProperties", "csharp");

@@clientName(Task, "MigrateTask", "csharp");
@@clientName(TaskProperties, "MigrateTaskProperties", "csharp");
@@clientName(TaskScope, "MigrateTaskScope", "csharp");
@@clientName(TaskType, "MigrateTaskType", "csharp");
@@clientName(TaskSummaryItem, "MigrateTaskSummaryItem", "csharp");
@@clientName(TaskStatusCountMap, "MigrateTaskStatusCount", "csharp");

@@clientName(ProvisioningState, "MigrateProvisioningState", "csharp");
@@clientName(Strategy, "MigrationStrategy", "csharp");
@@clientName(
  MigrationSpecificPropertiesBase,
  "MigrationSpecificProperties",
  "csharp"
);

// Replace discouraged *Request/*Response suffixes with *Content/*Result and add domain context.
@@clientName(
  CreateWavesFromPlanRequest,
  "CreateWavesFromPlanContent",
  "csharp"
);
@@clientName(
  CreateWavesFromPlanResponse,
  "CreateWavesFromPlanResult",
  "csharp"
);
@@clientName(FetchSasUriRequest, "MigrateWavePlanSasUriContent", "csharp");
@@clientName(FetchSasUriResponse, "MigrateWavePlanSasUriResult", "csharp");
@@clientName(GenerateWavePlanRequest, "GenerateWavePlanContent", "csharp");
@@clientName(GenerateWavePlanResponse, "GenerateWavePlanResult", "csharp");
@@clientName(GetWavePlansRequest, "GetWavePlansContent", "csharp");
@@clientName(GetWavePlansResponse, "GetWavePlansResult", "csharp");
@@clientName(ImportWavePlanRequest, "ImportWavePlanContent", "csharp");
@@clientName(ImportWavePlanResponse, "ImportWavePlanResult", "csharp");
@@clientName(
  RefreshEntitiesRequest,
  "RefreshMigrationEntitiesContent",
  "csharp"
);
@@clientName(
  RefreshEntitiesResponse,
  "RefreshMigrationEntitiesResult",
  "csharp"
);
@@clientName(TaskSummaryRequest, "MigrateTaskSummaryContent", "csharp");
@@clientName(TaskSummaryResponse, "MigrateTaskSummaryResult", "csharp");

// Scope generic ResourceGroupResource extension operations.
@@clientName(Tasks.getSummary, "getMigrateTaskSummary", "csharp");
@@clientName(MigrateProjects.fetchSasUri, "getMigrateWavePlanSasUri", "csharp");
@@clientName(
  MigrateProjects.refreshEntities,
  "refreshMigrationEntities",
  "csharp"
);

// Use Azure.ETag for resource eTag properties.
@@alternateType(Wave.eTag, Azure.Core.eTag, "csharp");
@@alternateType(Task.eTag, Azure.Core.eTag, "csharp");
@@alternateType(MigrationEntity.eTag, Azure.Core.eTag, "csharp");
@@alternateType(MigrationEntityGroup.eTag, Azure.Core.eTag, "csharp");

// Use Azure.Core.ResourceIdentifier for ARM resource ID properties.
@@alternateType(
  MigrationEntityProperties.partnerResourceArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  MigrationEntityProperties.targetAzureResourceArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  MigrationEntityProperties.associatedInventoryResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  MigrationEntityProperties.assessedEntityArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ArtifactProperties.artifactId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  CreateWavesFromPlanRequest.assessmentArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  FetchSasUriRequest.assessmentArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  GenerateWavePlanRequest.assessmentArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  GenerateWavePlanResponse.assessmentArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  GetWavePlansRequest.assessmentArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ImportWavePlanRequest.assessmentArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ImportWavePlanResponse.assessmentArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  WavePlanListItem.assessmentArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Use System.Uri for SAS URI properties.
@@alternateType(FetchSasUriResponse.sasUri, url, "csharp");
@@alternateType(CreateWavesFromPlanResponse.sasUri, url, "csharp");

