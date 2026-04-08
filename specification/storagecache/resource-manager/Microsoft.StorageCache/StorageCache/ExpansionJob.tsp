import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AmlFilesystem.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageCache;
/**
 * An expansion job instance. Follows Azure Resource Manager standards: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md
 */
@parentResource(AmlFilesystem)
model ExpansionJob
  is Azure.ResourceManager.TrackedResource<ExpansionJobProperties> {
  ...ResourceNameParameter<
    Resource = ExpansionJob,
    KeyName = "expansionJobName",
    SegmentName = "expansionJobs",
    NamePattern = "^[0-9a-zA-Z][-0-9a-zA-Z_]{0,78}[0-9a-zA-Z]$"
  >;
}

@armResourceOperations
interface ExpansionJobs {
  /**
   * Returns an expansion job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("expansionJobs_Get")
  get is ArmResourceRead<ExpansionJob, Error = CloudError>;

  /**
   * Create or update an expansion job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("expansionJobs_CreateOrUpdate")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExpansionJob,
    Response = ArmResourceUpdatedResponse<ExpansionJob> | ArmResourceCreatedResponse<
      ExpansionJob,
      ArmCombinedLroHeaders<FinalResult = ExpansionJob> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    Error = CloudError
  >;

  /**
   * Update an expansion job instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @operationId("expansionJobs_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ExpansionJob,
    PatchModel = ExpansionJobUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ExpansionJob> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Schedules an expansion job for deletion.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("expansionJobs_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ExpansionJob,
    Response = ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Returns all the expansion jobs the user has access to under an AML File System.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("expansionJobs_ListByAmlFilesystem")
  listByAmlFilesystem is ArmResourceListByParent<
    ExpansionJob,
    Response = ArmResponse<ExpansionJobsListResult>,
    Error = CloudError
  >;
}

@@maxLength(ExpansionJob.name, 80);
@@minLength(ExpansionJob.name, 2);
@@doc(ExpansionJob.name,
  "Name for the expansion job. Allows alphanumerics, underscores, and hyphens. Start and end with alphanumeric."
);
@@doc(ExpansionJob.properties, "Properties of the expansion job.");
@@doc(ExpansionJobs.createOrUpdate::parameters.resource,
  "Object containing the user-selectable properties of the expansion job. If read-only properties are included, they must match the existing values of those properties."
);
@@doc(ExpansionJobs.update::parameters.properties,
  "Object containing the user-selectable properties of the expansion job. If read-only properties are included, they must match the existing values of those properties."
);
