import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ImportSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * Export machines job REST resource.
 */
@parentResource(ImportSite)
model ExportImportedMachinesJob
  is Azure.ResourceManager.ProxyResource<ExportImportedMachinesJobEntityProperties> {
  ...ResourceNameParameter<
    Resource = ExportImportedMachinesJob,
    KeyName = "jobName",
    SegmentName = "exportJobs"
  >;

  /**
   * Gets or sets the Job status.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  status?: string;

  /**
   * Gets or sets the Job start time.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  startTime?: string;

  /**
   * Gets or sets the Job end time.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endTime?: string;

  /**
   * Gets or sets the Display name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  displayName?: string;
}

@armResourceOperations(#{ omitTags: true })
interface ExportImportedMachinesJobs {
  /**
   * Gets the export imported machines job with the given job name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ImportJobsController")
  @operationId("ImportJobsController_GetExportjob")
  getExportjob is ArmResourceRead<ExportImportedMachinesJob>;

  /**
   * Method to get all export import machines job for the given site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ImportJobsController")
  @operationId("ImportJobsController_ListExportjobs")
  listExportjobs is ArmResourceListByParent<
    ExportImportedMachinesJob,
    Response = ArmResponse<PagedExportImportedMachinesJob>
  >;
}

@@doc(ExportImportedMachinesJob.name, "Job Arm Name.");
@@doc(ExportImportedMachinesJob.properties,
  "Gets or sets the export machines job properties."
);
