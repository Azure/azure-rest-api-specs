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

@armResourceOperations(#{ omitTags: true })
interface ImportJobs {
  /**
   * Returns an import job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("importJobs_Get")
  @tag("importJobs")
  get is ArmResourceRead<ImportJob, Error = CloudError>;

  /**
   * Create or update an import job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("importJobs_CreateOrUpdate")
  @tag("importJobs")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ImportJob,
    Error = CloudError
  >;

  /**
   * Update an import job instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("importJobs_Update")
  @tag("importJobs")
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is ArmCustomPatchAsync<
    ImportJob,
    PatchModel = ImportJobUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ImportJob> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Schedules an import job for deletion.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("importJobs_Delete")
  @tag("importJobs")
  delete is ArmResourceDeleteWithoutOkAsync<
    ImportJob,
    Response = ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Returns all import jobs the user has access to under an AML File System.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("importJobs_ListByAmlFilesystem")
  @tag("importJobs")
  listByAmlFilesystem is ArmResourceListByParent<
    ImportJob,
    Response = ArmResponse<ImportJobsListResult>,
    Error = CloudError
  >;
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
