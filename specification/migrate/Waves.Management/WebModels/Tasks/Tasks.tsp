import "../../Common/ArmModels/AzureResourceProperties.tsp";
import "../Enums/Enums.tsp";
import "../../Common/ArmModels/MigrateProject.tsp";
import "../../ApiVersions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@added(ApiVersions.v2025_03_30_preview)
@doc("Tasks resource.")
@parentResource(MigrateProject)
model Task is ProxyResource<TaskProperties> {
  @doc("Task ARM name")
  @key("taskName")
  @segment("tasks")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;

  ...EntityTagProperty;
}

@doc("Task Properties class.")
model TaskProperties is AzureResourceProperties {
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

  @doc("Task Type")
  @visibility(Lifecycle.Read)
  @madeOptional(ApiVersions.v2026_06_01_preview)
  taskType?: TaskType;

  @doc("Task Dislay Name ")
  displayName: string;

  @doc("Indicates whether the task is editable.")
  @visibility(Lifecycle.Read)
  @madeOptional(ApiVersions.v2026_06_01_preview)
  isEditable?: boolean;

  @doc("Task Status")
  status: string;

  @doc("Task Scope")
  scope: TaskScope;

  @doc("Task Description")
  description?: string;

  @doc("Task completion Date")
  @visibility(Lifecycle.Read)
  completionDate?: utcDateTime;
}
