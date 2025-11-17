import "../../Common/ArmModels/AzureResourceProperties.tsp";
import "../Enums/Enums.tsp";
import "../../Common/ArmModels/MigrateProject.tsp";
import "./Tasks.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Migrate;

@added(ApiVersions.v2025_03_30_preview)
@doc("Task Summary Request model.")
model TaskSummaryRequest {
  @doc("Task Scope ARM Id")
  scopeId: armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/MigrateProjects/waves";
    },
    {
      type: "Microsoft.Migrate/MigrationProjects/migrationEntityGroups";
    },
    {
      type: "Microsoft.Migrate/MigrateProjects/migrationEntities";
    }
  ]>;
}

@added(ApiVersions.v2025_03_30_preview)
@doc("Task Summary Response model.")
model TaskSummaryResponse {
  @doc("List of Task Summary Items")
  @identifiers(#[])
  items: Array<TaskSummaryItem>;
}

@added(ApiVersions.v2025_03_30_preview)
@doc("Task Summary Item model.")
model TaskSummaryItem {
  @doc("Task Stage")
  stage: string;

  @doc("Aggregated status of tasks in this stage.")
  aggregatedStatus: string;

  @doc("Counts of tasks in this stage by status.")
  statusCounts: TaskStatusCounts;

  @doc("List of tasks in this stage.")
  @identifiers(#[])
  tasks: Array<Task>;
}

@added(ApiVersions.v2025_03_30_preview)
@doc("Task Status Counts model.")
model TaskStatusCounts {
  @doc("Status counts dictionary mapping TaskStatus to the count of tasks with that status.")
  @identifiers(#["status"])
  statusCounts: TaskStatusCountMap[];
}

@added(ApiVersions.v2025_03_30_preview)
@doc("Task status count mapping.")
model TaskStatusCountMap {
  @doc("The task status.")
  status: string;

  @doc("The count of tasks with this status.")
  count: int32;
}
