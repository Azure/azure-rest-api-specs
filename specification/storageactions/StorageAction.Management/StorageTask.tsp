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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Private.armResourceInternal(StorageTaskProperties)
@Http.Private.includeInapplicableMetadataInPayload(false)
model StorageTask extends Foundations.TrackedResource {
  ...ResourceNameParameter<
    Resource = StorageTask,
    KeyName = "storageTaskName",
    SegmentName = "storageTasks",
    NamePattern = "^[a-z0-9]{3,18}$"
  >;

  /**
   * The managed service identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity: Azure.ResourceManager.Foundations.ManagedServiceIdentity;

  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("The resource-specific properties for this resource.")
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(false)
  properties?: StorageTaskProperties;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    StorageTask,
    Response = ArmResourceUpdatedResponse<StorageTask> | ArmResourceCreatedResponse<
      StorageTask,
      ArmLroLocationHeader<FinalResult = StorageTask> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Update storage task properties
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    StorageTask,
    PatchModel = StorageTaskUpdateParameters,
    Response = ArmResourceUpdatedResponse<StorageTask> | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = StorageTask> &
      ArmLroLocationHeader<FinalResult = StorageTask> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Delete the storage task resource.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    StorageTask,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the storage tasks available under the given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    StorageTask,
    Response = StorageTasksListResult
  >;

  /**
   * Lists all the storage tasks available under the subscription.
   */
  listBySubscription is ArmListBySubscription<
    StorageTask,
    Response = StorageTasksListResult
  >;

  /**
   * Fetch the storage tasks run report summary for each assignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("reports")
  list is ArmResourceActionSync<
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

  /**
   * Lists Resource IDs of the Storage Task Assignments associated with this Storage Task.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("storageTaskAssignments")
  storageTaskAssignmentList is ArmResourceActionSync<
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
