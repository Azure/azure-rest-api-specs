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
 * An auto export job instance. Follows Azure Resource Manager standards: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md
 */
@parentResource(AmlFilesystem)
model AutoExportJob
  is Azure.ResourceManager.TrackedResource<AutoExportJobProperties> {
  ...ResourceNameParameter<
    Resource = AutoExportJob,
    KeyName = "autoExportJobName",
    SegmentName = "autoExportJobs",
    NamePattern = "^[0-9a-zA-Z][-0-9a-zA-Z_]{0,78}[0-9a-zA-Z]$"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface AutoExportJobs {
  /**
   * Returns an auto export job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("autoExportJobs_Get")
  @tag("autoExportJobs")
  get is ArmResourceRead<AutoExportJob, Error = CloudError>;

  /**
   * Create or update an auto export job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("autoExportJobs_CreateOrUpdate")
  @tag("autoExportJob")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AutoExportJob,
    Error = CloudError
  >;

  /**
   * Update an auto export job instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("autoExportJobs_Update")
  @tag("autoExportJob")
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is ArmCustomPatchAsync<
    AutoExportJob,
    PatchModel = AutoExportJobUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = AutoExportJob> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Schedules an auto export job for deletion.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("autoExportJobs_Delete")
  @tag("autoExportJobs")
  delete is ArmResourceDeleteWithoutOkAsync<
    AutoExportJob,
    Response = ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Returns all the auto export jobs the user has access to under an AML File System.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("autoExportJobs_ListByAmlFilesystem")
  @tag("autoExportJob")
  listByAmlFilesystem is ArmResourceListByParent<
    AutoExportJob,
    Response = ArmResponse<AutoExportJobsListResult>,
    Error = CloudError
  >;
}

@@maxLength(AutoExportJob.name, 80);
@@minLength(AutoExportJob.name, 2);
@@doc(AutoExportJob.name,
  "Name for the auto export job. Allows alphanumerics, underscores, and hyphens. Start and end with alphanumeric."
);
@@doc(AutoExportJob.properties, "Properties of the auto export job.");
@@doc(AutoExportJobs.createOrUpdate::parameters.resource,
  "Object containing the user-selectable properties of the auto export job. If read-only properties are included, they must match the existing values of those properties."
);
@@doc(AutoExportJobs.update::parameters.properties,
  "Object containing the user-selectable properties of the auto export job. If read-only properties are included, they must match the existing values of those properties."
);
