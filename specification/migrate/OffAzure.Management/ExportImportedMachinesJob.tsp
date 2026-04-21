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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@parentResource(ImportSite)
model ExportImportedMachinesJob extends BaseResource {
  ...ResourceNameParameter<
    Resource = ExportImportedMachinesJob,
    KeyName = "jobName",
    SegmentName = "exportJobs"
  >;
  properties?: ExportImportedMachinesJobEntityProperties;

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
  @tag("ImportJobsController")
  getExportjob is ArmResourceRead<ExportImportedMachinesJob>;

  /**
   * Method to get all export import machines job for the given site.
   */
  @tag("ImportJobsController")
  listExportjobs is ArmResourceListByParent<
    ExportImportedMachinesJob,
    Response = ArmResponse<PagedExportImportedMachinesJob>
  >;
}

@@doc(ExportImportedMachinesJob.name, "Job Arm Name.");
@@doc(ExportImportedMachinesJob.properties,
  "Gets or sets the export machines job properties."
);
