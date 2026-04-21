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
 * Import machines Job REST Resource.
 */
@parentResource(ImportSite)
model ImportMachinesJob
  is Azure.ResourceManager.ProxyResource<ImportMachinesJobProperties> {
  ...ResourceNameParameter<
    Resource = ImportMachinesJob,
    KeyName = "jobName",
    SegmentName = "importJobs"
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
interface ImportMachinesJobs {
  /**
   * Gets the import job with the given job name.
   */
  @tag("ImportJobsController")
  getImportjob is ArmResourceRead<ImportMachinesJob>;

  /**
   * Method to get all import machines job for the given site.
   */
  @tag("ImportJobsController")
  listImportjobs is ArmResourceListByParent<
    ImportMachinesJob,
    Response = ArmResponse<PagedImportMachinesJob>
  >;
}

@@doc(ImportMachinesJob.name, "Job Arm Name.");
@@doc(ImportMachinesJob.properties, "Gets or sets the import job properties.");
