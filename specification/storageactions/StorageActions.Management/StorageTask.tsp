import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageActions;
@doc("Represents Storage Task.")
model StorageTask is TrackedResource<StorageTaskProperties> {
  @doc("The name of the storage task within the specified resource group. Storage task names must be between 3 and 18 characters in length and use numbers and lower-case letters only.")
  @maxLength(18)
  @minLength(3)
  @pattern("^[a-z0-9]{3,18}$")
  @path
  @key("storageTaskName")
  @segment("storageTasks")
  name: string;

  @doc("The managed service identity of the resource.")
  identity?: ManagedIdentityProperties;
}

@armResourceOperations
interface StorageTasks {
  @doc("Get the storage task properties")
  get is ArmResourceRead<StorageTask>;

  @doc("Asynchronously creates a new storage task resource with the specified parameters. If a storage task is already created and a subsequent create request is issued with different properties, the storage task properties will be updated. If a storage task is already created and a subsequent create or update request is issued with the exact same set of properties, the request will succeed.")
  @autoRoute
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @armResourceCreateOrUpdate(StorageTask)
  @put
  create(
    ...ResourceInstanceParameters<StorageTask, BaseParameters<StorageTask>>,

    @doc("Resource create parameters.")
    @body
    resource: StorageTask,
  ):
    | ArmResourceUpdatedResponse<StorageTask>
    | ArmResourceCreatedResponse<StorageTask, {}>
    | ArmAcceptedLroResponse<"Accepted -- Create or update request accepted; operation will complete asynchronously.">
    | ErrorResponse;

  @doc("Update storage task properties")
  update is ArmCustomPatchAsync<
    StorageTask,
    StorageTaskUpdateParameters,
    BaseParameters<StorageTask>,
    ArmLroLocationHeader
  >;

  @doc("Delete the storage task resource.")
  delete is ArmResourceDeleteWithoutOkAsync<
    StorageTask,
    BaseParameters<StorageTask>,
    ArmLroLocationHeader
  >;

  @doc("Lists all the storage tasks available under the given resource group.")
  listByResourceGroup is ArmResourceListByParent<StorageTask>;

  @doc("Lists all the storage tasks available under the subscription.")
  listBySubscription is ArmListBySubscription<StorageTask>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StorageTaskAssignment_List")
  @doc("Lists all the storage tasks available under the given resource group.")
  @get
  @segment("storageTaskAssignments")
  list(
    ...ResourceInstanceParameters<StorageTask, BaseParameters<StorageTask>>,

    @doc("Optional, specifies the maximum number of storage task assignment Ids to be included in the list response.")
    @query("$maxpagesize")
    $maxpagesize?: string,
  ): ArmResponse<StorageTaskAssignmentsListResult> | ErrorResponse;
}

@@projectedName(StorageTasks.create::parameters.resource, "json", "parameters");
@@extension(StorageTasks.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(StorageTasks.create::parameters.resource,
  "The parameters to create a Storage Task."
);
@@projectedName(StorageTasks.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(StorageTasks.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(StorageTasks.update::parameters.properties,
  "The parameters to provide to update the storage task resource."
);
