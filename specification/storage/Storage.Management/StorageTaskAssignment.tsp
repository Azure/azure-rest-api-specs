import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Storage;
/**
 * The storage task assignment.
 */
@parentResource(StorageAccount)
model StorageTaskAssignment
  is Azure.ResourceManager.ProxyResource<
    StorageTaskAssignmentProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = StorageTaskAssignment,
    KeyName = "storageTaskAssignmentName",
    SegmentName = "storageTaskAssignments",
    NamePattern = "^[a-z0-9]{3,24}$"
  >;
}

@armResourceOperations
interface StorageTaskAssignments {
  /**
   * Get the storage task assignment properties
   */
  get is ArmResourceRead<StorageTaskAssignment>;

  /**
   * Asynchronously creates a new storage task assignment sub-resource with the specified parameters. If a storage task assignment is already created and a subsequent create request is issued with different properties, the storage task assignment properties will be updated. If a storage task assignment is already created and a subsequent create or update request is issued with the exact same set of properties, the request will succeed.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  create is ArmResourceCreateOrReplaceAsync<
    StorageTaskAssignment,
    Response = ArmResourceUpdatedResponse<StorageTaskAssignment> | ArmResourceCreatedResponse<
      StorageTaskAssignment,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Update storage task assignment properties
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<
    StorageTaskAssignment,
    PatchModel = StorageTaskAssignmentUpdateParameters
  >;

  /**
   * Delete the storage task assignment sub-resource
   */
  delete is ArmResourceDeleteWithoutOkAsync<StorageTaskAssignment>;

  /**
   * List all the storage task assignments in an account
   */
  list is ArmResourceListByParent<
    StorageTaskAssignment,
    Parameters = {
      /**
       * Optional, specifies the maximum number of storage task assignment Ids to be included in the list response.
       */
      @query("$maxpagesize")
      $maxpagesize?: int32;
    },
    Response = ArmResponse<StorageTaskAssignmentsList>
  >;

  /**
   * Fetch the report summary of a single storage task assignment's instances
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("reports")
  @operationId("StorageTaskAssignmentInstancesReport_List")
  storageTaskAssignmentInstancesReportList is ArmResourceActionSync<
    StorageTaskAssignment,
    void,
    ArmResponse<StorageTaskReportSummary>,
    Parameters = {
      /**
       * Optional, specifies the maximum number of storage task assignment instances to be included in the list response.
       */
      @query("$maxpagesize")
      $maxpagesize?: int32;

      /**
       * Optional. When specified, it can be used to query using reporting properties. See [Constructing Filter Strings](https://learn.microsoft.com/en-us/rest/api/storageservices/querying-tables-and-entities#constructing-filter-strings) for details.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@maxLength(StorageTaskAssignment.name, 24);
@@minLength(StorageTaskAssignment.name, 3);
@@doc(StorageTaskAssignment.name,
  "The name of the storage task assignment within the specified resource group. Storage task assignment names must be between 3 and 24 characters in length and use numbers and lower-case letters only."
);
@@doc(StorageTaskAssignment.properties,
  "Properties of the storage task assignment."
);
@@doc(StorageTaskAssignments.create::parameters.resource,
  "The parameters to create a Storage Task Assignment."
);
@@doc(StorageTaskAssignments.update::parameters.properties,
  "The parameters to update a Storage Task Assignment."
);
