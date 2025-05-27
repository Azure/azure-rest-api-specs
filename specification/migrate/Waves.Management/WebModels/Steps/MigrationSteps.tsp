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
@doc("Steps resource.")
@parentResource(MigrateProject)
model MigrationStep is ProxyResource<MigrationStepProperties> {
  @doc("Migration Step ARM name")
  @key("stepName")
  @segment("steps")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;

  ...EntityTagProperty;
}

@doc("Migration Step Properties class.")
model MigrationStepProperties is AzureResourceProperties {

  @doc("associated Wave Id")
  associatedWaveId?: armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/waves";
    }
  ]>;

  @doc("Migration Entity Id")
  associatedMigrationEntityId?: armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/migrationEntities";
    }
  ]>;

  @doc("MIgration Entity Group Id")
  associatedMigrationEntityGroupId?: armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/migrationEntityGroups";
    }
  ]>; 

  @doc("Step Stage")
  stage: StepStage;

  @doc("Task Type")
  taskType: TaskType;

  @doc("Category")
  category: Category; 

  @doc("Task Status")
  status: TaskStatus;
}
