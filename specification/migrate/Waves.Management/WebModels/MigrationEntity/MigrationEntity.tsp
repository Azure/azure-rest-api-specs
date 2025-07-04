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
  associatedInventoryResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.OffAzure/VMwareSites";
    },
    {
      type: "Microsoft.OffAzure/HyperVSites";
    },
    {
      type: "Microsoft.OffAzure/serversites";
    },
    {
      type: "Microsoft.OffAzure/MasterSites";
    }
  ]>;

  @doc("Display Name of the Workload.")
  inventoryDisplayName: string;

  @doc("Associated Assessment Id")
  associatedAssessmentIds?: Array<armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/assessmentProjects";
    }
  ]>>;

  @doc("associated Wave Id")
  associatedWaveIds?: Array<armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/waves";
    }
  ]>>;

  @doc("associated Migration Entity Group Id")
  migrationEntityGroupIds?: Array<armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/migrationEntityGroups";
    }
  ]>>;

  @doc("Planning completion time for Migration Entity.")
  planningCompletionTime?: utcDateTime;

  @doc("Migration Entity Type.")
  resourceType: string;

  @doc("Readiness of the Migration Entity.")
  readiness: MigrationEntityReadiness;

  @doc("Target of the Migration Entity.")
  target: MigrationEntityTarget;

  @doc("Strategy of Migration Entity.")
  migrationStrategy: Strategy;

  @doc("Stage of Migration Entity.")
  migrationStage: MigrationEntityStage;

  @doc("Status of Migration Entity.")
  migrationStatus: MigrationEntityStatus;

  @doc("Planning Status of Migration Entity.")
  planningStatus: MigrationEntityPlanningStatus;

  @doc("Migration specific properties for the entity.")
  migrationSpecificProperties?: MigrationSpecificPropertiesBase;
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
    }
  ]>;
  serverMigrationPath: ServerMigrationPath;
}
