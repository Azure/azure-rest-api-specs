import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageActions;
/**
 * Represents Storage Task.
 */
model StorageTask
  is Azure.ResourceManager.TrackedResource<StorageTaskProperties, false> {
  ...ResourceNameParameter<
    Resource = StorageTask,
    KeyName = "storageTaskName",
    SegmentName = "storageTasks",
    NamePattern = "^[a-z0-9]{3,18}$"
  >;

  /**
   * The managed service identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity: ManagedServiceIdentity;
}

@armResourceOperations
interface StorageTasks {
  /**
   * Get the storage task properties
   */
  get is ArmResourceRead<StorageTask>;

  /**
   * Asynchronously creates a new storage task resource with the specified parameters. If a storage task is already created and a subsequent create request is issued with different properties, the storage task properties will be updated. If a storage task is already created and a subsequent create or update request is issued with the exact same set of properties, the request will succeed.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceAsync<
    StorageTask,
    Response = ArmResourceUpdatedResponse<StorageTask> | ArmResourceCreatedResponse<
      StorageTask,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Update storage task properties
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    StorageTask,
    PatchModel = StorageTaskUpdateParameters
  >;

  /**
   * Delete the storage task resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<StorageTask>;

  /**
   * Lists all the storage tasks available under the given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<StorageTask>;

  /**
   * Lists all the storage tasks available under the subscription.
   */
  listBySubscription is ArmListBySubscription<StorageTask>;

  /**
   * Lists Resource IDs of the Storage Task Assignments associated with this Storage Task.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("storageTaskAssignments")
  @operationId("StorageTaskAssignment_List")
  list is ArmResourceActionSync<
    StorageTask,
    void,
    ArmResponse<StorageTaskAssignmentsListResult>,
    Parameters = {
      /**
       * Optional, specifies the maximum number of Storage Task Assignment Resource IDs to be included in the list response.
       */
      @query("$maxpagesize")
      $maxpagesize?: int32;
    }
  >;

  /**
   * Fetch the storage tasks run report summary for each assignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("reports")
  @operationId("StorageTasksReport_List")
  storageTasksReportList is ArmResourceActionSync<
    StorageTask,
    void,
    ArmResponse<StorageTaskReportSummary>,
    Parameters = {
      /**
       * Optional, specifies the maximum number of Storage Task Assignment Resource IDs to be included in the list response.
       */
      @query("$maxpagesize")
      $maxpagesize?: int32;

      /**
       * Optional. When specified, it can be used to query using reporting properties.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@maxLength(StorageTask.name, 18);
@@minLength(StorageTask.name, 3);
@@doc(StorageTask.name,
  "The name of the storage task within the specified resource group. Storage task names must be between 3 and 18 characters in length and use numbers and lower-case letters only."
);
@@doc(StorageTask.properties, "Properties of the storage task.");
@@doc(StorageTasks.create::parameters.resource,
  "The parameters to create a Storage Task."
);
@@doc(StorageTasks.update::parameters.properties,
  "The parameters to provide to update the storage task resource."
);
