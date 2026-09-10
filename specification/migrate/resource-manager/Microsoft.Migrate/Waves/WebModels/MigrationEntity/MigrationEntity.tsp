import "../../Common/ArmModels/AzureResourceProperties.tsp";
import "../Enums/Enums.tsp";
import "../../Common/ArmModels/MigrateProject.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@added(ApiVersions.v2025_03_30_preview)
@doc("Migration Entity resource.")
@parentResource(MigrateProject)
model MigrationEntity is ProxyResource<MigrationEntityProperties> {
  @doc("Migration Entity ARM name")
  @key("migrationEntityName")
  @segment("migrationEntities")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;

  ...EntityTagProperty;
}

@doc("Migration Entity Properties class.")
model MigrationEntityProperties is AzureResourceProperties {
  @doc("ARM Resource Identifier for the partner resource.")
  partnerResourceArmId?: string;

  @doc("target Azure Resource ARM Id.")
  targetAzureResourceArmId?: string;

  @doc("inventory resource id ")
  associatedInventoryResourceId: string;

  @doc("Display Name of the Workload.")
  inventoryDisplayName: string;

  @doc("Associated Assessment Id")
  associatedAssessmentId?: armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/assessmentProjects/assessments";
    }
  ]>;

  @doc("associated Wave Id")
  associatedWaveId?: armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/waves";
    }
  ]>;

  @doc("associated Migration Entity Group Id")
  associatedMigrationEntityGroupIds?: Array<armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/migrationEntityGroups";
    }
  ]>>;

  @doc("Execution start date for Migration Entity.")
  @visibility(Lifecycle.Read)
  executionStartDate?: utcDateTime;

  @doc("Target of the Migration Entity.")
  target?: string;

  @doc("Strategy of Migration Entity.")
  @visibility(Lifecycle.Read)
  migrationStrategy?: Strategy;

  @doc("Execution Stage of Migration Entity.")
  @visibility(Lifecycle.Read)
  executionStage?: string;

  @doc("Execution Status of Migration Entity.")
  @visibility(Lifecycle.Read)
  executionStatus?: string;

  @doc("Migration status reported by the migration tool.")
  @added(ApiVersions.v2026_08_01_preview)
  @visibility(Lifecycle.Read)
  toolReportedMigrationStatus?: string;

  @doc("Error details reported for the migration entity.")
  @added(ApiVersions.v2026_08_01_preview)
  @visibility(Lifecycle.Read)
  error?: MigrationEntityError;

  @doc("Execution Readiness of Migration Entity.")
  @visibility(Lifecycle.Read)
  executionReadiness?: string;

  @doc("Migration specific properties for the entity.")
  migrationSpecificProperties?: MigrationSpecificPropertiesBase;

  @doc("Migration Tool of the Migration Entity.")
  migrationTool?: string;

  @doc("Migration path")
  migrationPath?: string;

  @doc("Assessed Entity ARM Id")
  assessedEntityArmId?: string;

  @doc("Identifier of the migration tool used for the migration entity.")
  @added(ApiVersions.v2026_08_01_preview)
  migrationToolId?: string;

  @doc("Execution mode for the migration process.")
  @added(ApiVersions.v2026_08_01_preview)
  @visibility(Lifecycle.Read)
  executionMode?: ExecutionMode;
}

@doc("Error details for a migration entity.")
@added(ApiVersions.v2026_08_01_preview)
model MigrationEntityError {
  @doc("Error code reported for the migration entity.")
  @added(ApiVersions.v2026_08_01_preview)
  code?: string;

  @doc("Error message reported for the migration entity.")
  @added(ApiVersions.v2026_08_01_preview)
  message?: string;
}

@doc("Properties that can be updated on a migration entity.")
@added(ApiVersions.v2026_08_01_preview)
model MigrationEntityPatchProperties {
  @doc("Execution stage of the migration entity.")
  executionStage?: string;

  @doc("Execution status of the migration entity.")
  executionStatus?: string;

  @doc("Migration status reported by the migration tool.")
  toolReportedMigrationStatus?: string;

  @doc("Error details reported for the migration entity.")
  error?: MigrationEntityError;
}

@doc("Patch request for a migration entity.")
@added(ApiVersions.v2026_08_01_preview)
model MigrationEntityPatch {
  @doc("Properties to update on the migration entity.")
  properties?: MigrationEntityPatchProperties;
}

@doc("The base Migration Specific Properties model.")
@discriminator("instanceType")
model MigrationSpecificPropertiesBase {
  @doc("Discriminator for migration specific properties.")
  instanceType: MigrationSpecificPropertiesInstanceType;
}

@doc("Represents a Server Migration Specific properties base model.")
model ServerMigrationSpecificProperties
  extends MigrationSpecificPropertiesBase {
  @doc("Discriminator for migration specific properties.")
  instanceType: MigrationSpecificPropertiesInstanceType.ServerMigration;

  drApplianceInventoryId?: armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectableItems";
    },
    {
      type: "Microsoft.OffAzure/VMwareSites/machines";
    },
    {
      type: "Microsoft.OffAzure/ServerSites/machines";
    }
  ]>;
  currentJobId?: armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults/replicationJobs";
    }
  ]>;
}
