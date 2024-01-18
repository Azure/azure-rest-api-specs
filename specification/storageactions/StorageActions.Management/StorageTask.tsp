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

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface StorageTasks {
  @doc("Get the storage task properties")
  get is ArmResourceRead<StorageTask>;

  @doc("Asynchronously creates a new storage task resource with the specified parameters. If a storage task is already created and a subsequent create request is issued with different properties, the storage task properties will be updated. If a storage task is already created and a subsequent create or update request is issued with the exact same set of properties, the request will succeed.")
  create is ArmResourceCreateOrUpdateAsync<
    StorageTask,
    BaseParameters<StorageTask>,
    ArmLroLocationHeader
  >;

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
  // FIXME: StorageTaskAssignment_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageActions/storageTasks/{storageTaskName}/storageTaskAssignments")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the storage task within the specified resource group. Storage task names must be between 3 and 18 characters in length and use numbers and lower-case letters only.")
      @maxLength(18)
      @minLength(3)
      @pattern("^[a-z0-9]{3,18}$")
      @path
      storageTaskName: string;

      @doc("Optional, specifies the maximum number of storage task assignment Ids to be included in the list response.")
      @query("$maxpagesize")
      $maxpagesize?: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;
    },
    StorageTaskAssignmentsListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StorageTasksReport_List")
  @doc("Fetch the storage tasks run report summary for each assignment.")
  // FIXME: StorageTasksReport_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageActions/storageTasks/{storageTaskName}/reports")
  @get
  reports is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the storage task within the specified resource group. Storage task names must be between 3 and 18 characters in length and use numbers and lower-case letters only.")
      @maxLength(18)
      @minLength(3)
      @pattern("^[a-z0-9]{3,18}$")
      @path
      storageTaskName: string;

      @doc("Optional, specifies the maximum number of storage task assignment Ids to be included in the list response.")
      @query("$maxpagesize")
      $maxpagesize?: string;

      @doc("Optional. When specified, it can be used to query using reporting properties.")
      @query("$filter")
      $filter?: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;
    },
    StorageTaskReportSummary
  >;
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
