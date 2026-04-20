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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  status?: string;

  /**
   * Gets or sets the Job start time.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  startTime?: string;

  /**
   * Gets or sets the Job end time.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  endTime?: string;

  /**
   * Gets or sets the Display name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  displayName?: string;
}

@armResourceOperations
interface ImportMachinesJobs {
  /**
   * Gets the import job with the given job name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ImportJobsController_GetImportjob")
  getImportjob is ArmResourceRead<ImportMachinesJob>;

  /**
   * Method to get all import machines job for the given site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ImportJobsController_ListImportjobs")
  listImportjobs is ArmResourceListByParent<
    ImportMachinesJob,
    Response = ArmResponse<PagedImportMachinesJob>
  >;
}

@@doc(ImportMachinesJob.name, "Job Arm Name.");
@@doc(ImportMachinesJob.properties, "Gets or sets the import job properties.");
