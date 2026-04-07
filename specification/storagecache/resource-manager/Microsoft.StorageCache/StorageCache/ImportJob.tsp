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
 * An import job instance. Follows Azure Resource Manager standards: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md
 */
@parentResource(AmlFilesystem)
model ImportJob is Azure.ResourceManager.TrackedResource<ImportJobProperties> {
  ...ResourceNameParameter<
    Resource = ImportJob,
    KeyName = "importJobName",
    SegmentName = "importJobs",
    NamePattern = "^[0-9a-zA-Z][-0-9a-zA-Z_]{0,78}[0-9a-zA-Z]$"
  >;
}

@armResourceOperations
interface ImportJobs {
  /**
   * Returns an import job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("importJobs_Get")
  get is ArmResourceRead<ImportJob>;

  /**
   * Create or update an import job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("importJobs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ImportJob>;

  /**
   * Update an import job instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("importJobs_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ImportJob,
    PatchModel = ImportJobUpdate,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ImportJob> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Schedules an import job for deletion.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("importJobs_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ImportJob>;

  /**
   * Returns all import jobs the user has access to under an AML File System.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("importJobs_ListByAmlFilesystem")
  listByAmlFilesystem is ArmResourceListByParent<ImportJob>;
}

@@maxLength(ImportJob.name, 80);
@@minLength(ImportJob.name, 2);
@@doc(ImportJob.name,
  "Name for the import job. Allows alphanumerics, underscores, and hyphens. Start and end with alphanumeric."
);
@@doc(ImportJob.properties, "Properties of the import job.");
@@doc(ImportJobs.createOrUpdate::parameters.resource,
  "Object containing the user-selectable properties of the import job. If read-only properties are included, they must match the existing values of those properties."
);
@@doc(ImportJobs.update::parameters.properties,
  "Object containing the user-selectable properties of the import job. If read-only properties are included, they must match the existing values of those properties."
);
