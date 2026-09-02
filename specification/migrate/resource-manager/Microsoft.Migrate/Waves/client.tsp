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

    @doc("Task Dislay Name ")
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
