import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Catalog.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;

@doc("Represents a Task to be used in customizing a Dev Box.")
@parentResource(Catalog)
model CustomizationTask
  is Azure.ResourceManager.ProxyResource<CustomizationTaskProperties> {
  ...ResourceNameParameter<
    Resource = CustomizationTask,
    KeyName = "taskName",
    SegmentName = "tasks",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;
}

@armResourceOperations
interface CustomizationTaskOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        @doc("The name of the devcenter.")
        @path
        @segment("devcenters")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{2,25}$")
        @minLength(3)
        @maxLength(26)
        devCenterName: string,

        @doc("The name of the Catalog.")
        @path
        @segment("catalogs")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        catalogName: string,
      },
      {
        @doc("The name of the Customization Task.")
        @path
        @segment("tasks")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        taskName: string,
      }
    > {}

@armResourceOperations
interface CustomizationTasks {
  @doc("Gets a Task from the catalog.")
  get is CustomizationTaskOps.Read<CustomizationTask>;

  @doc("List Tasks in the catalog.")
  listByCatalog is CustomizationTaskOps.List<
    CustomizationTask,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = CustomizationTaskListResult
  >;

  @doc("Gets Customization Task error details.")
  getErrorDetails is CustomizationTaskOps.ActionSync<
    CustomizationTask,
    void,
    ArmResponse<CatalogResourceValidationErrorDetails>
  >;
}

@@maxLength(CustomizationTask.name, 63);
@@minLength(CustomizationTask.name, 3);
@@doc(CustomizationTask.name, "The name of the Task.");
@@doc(CustomizationTask.properties, "Task properties");
