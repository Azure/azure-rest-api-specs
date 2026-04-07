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
 * An auto import job instance. Follows Azure Resource Manager standards: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md
 */
@parentResource(AmlFilesystem)
model AutoImportJob
  is Azure.ResourceManager.TrackedResource<AutoImportJobProperties> {
  ...ResourceNameParameter<
    Resource = AutoImportJob,
    KeyName = "autoImportJobName",
    SegmentName = "autoImportJobs",
    NamePattern = "^[0-9a-zA-Z][-0-9a-zA-Z_]{0,78}[0-9a-zA-Z]$"
  >;
}

@armResourceOperations
interface AutoImportJobs {
  /**
   * Returns an auto import job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("autoImportJobs_Get")
  get is ArmResourceRead<AutoImportJob>;

  /**
   * Create or update an auto import job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("autoImportJobs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AutoImportJob>;

  /**
   * Update an auto import job instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("autoImportJobs_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AutoImportJob,
    PatchModel = AutoImportJobUpdate,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = AutoImportJob> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Schedules an auto import job for deletion.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("autoImportJobs_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<AutoImportJob>;

  /**
   * Returns all the auto import jobs the user has access to under an AML File System.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("autoImportJobs_ListByAmlFilesystem")
  listByAmlFilesystem is ArmResourceListByParent<AutoImportJob>;
}

@@maxLength(AutoImportJob.name, 80);
@@minLength(AutoImportJob.name, 2);
@@doc(AutoImportJob.name,
  "Name for the auto import job. Allows alphanumerics, underscores, and hyphens. Start and end with alphanumeric."
);
@@doc(AutoImportJob.properties, "Properties of the auto import job.");
@@doc(AutoImportJobs.createOrUpdate::parameters.resource,
  "Object containing the user-selectable properties of the auto import job. If read-only properties are included, they must match the existing values of those properties."
);
@@doc(AutoImportJobs.update::parameters.properties,
  "Object containing the user-selectable properties of the auto import job. If read-only properties are included, they must match the existing values of those properties."
);
