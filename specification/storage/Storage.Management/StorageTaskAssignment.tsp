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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(StorageAccount)
@Http.Private.includeInapplicableMetadataInPayload(false)
model StorageTaskAssignment extends Resource {
  ...ResourceNameParameter<
    Resource = StorageTaskAssignment,
    KeyName = "storageTaskAssignmentName",
    SegmentName = "storageTaskAssignments",
    NamePattern = "^[a-z][a-z0-9]{2,23}$"
  >;

  /**
   * Properties of the storage task assignment.
   */
  properties: StorageTaskAssignmentProperties;
}

@armResourceOperations
interface StorageTaskAssignments {
  /**
   * Get the storage task assignment properties
   */
  get is ArmResourceRead<StorageTaskAssignment, Error = ErrorResponse>;

  /**
   * Asynchronously creates a new storage task assignment sub-resource with the specified parameters. If a storage task assignment is already created and a subsequent create request is issued with different properties, the storage task assignment properties will be updated. If a storage task assignment is already created and a subsequent create or update request is issued with the exact same set of properties, the request will succeed.
   */
  @put
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    StorageTaskAssignment,
    Response = ArmResourceUpdatedResponse<StorageTaskAssignment> | ArmResourceCreatedResponse<StorageTaskAssignment> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = StorageTaskAssignment> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = ErrorResponse
  >;

  /**
   * Update storage task assignment properties
   */
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is ArmCustomPatchAsync<
    StorageTaskAssignment,
    StorageTaskAssignmentUpdateParameters,
    Response = ArmResponse<StorageTaskAssignment> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = StorageTaskAssignment> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = ErrorResponse
  >;

  /**
   * Delete the storage task assignment sub-resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @armResourceDelete(StorageTaskAssignment)
  @Azure.ResourceManager.Private.enforceConstraint(
    StorageTaskAssignment,
    Foundations.Resource
  )
  @delete
  delete is Azure.ResourceManager.ArmResourceDeleteAsyncBase<
    Resource = StorageTaskAssignment,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | NoContentResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<StorageTaskAssignment>,
    Error = ErrorResponse
  >;

  /**
   * List all the storage task assignments in an account
   */
  list is ArmResourceListByParent<
    StorageTaskAssignment,
    Parameters = {
      /**
       * Optional, specifies the maximum number of storage task assignment Ids to be included in the list response.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ArmResponse<StorageTaskAssignmentsList>,
    Error = ErrorResponse
  >;

  /**
   * Fetch the report summary of a single storage task assignment's instances
   */
  @get
  @list
  @action("reports")
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
       * Optional. When specified, it can be used to query using reporting properties. See [Constructing Filter Strings](https://learn.microsoft.com/rest/api/storageservices/querying-tables-and-entities#constructing-filter-strings) for details.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = ErrorResponse
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
@@visibility(StorageTaskAssignment.name, Lifecycle.Read);
