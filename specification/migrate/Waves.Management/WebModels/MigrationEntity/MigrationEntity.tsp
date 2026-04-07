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
