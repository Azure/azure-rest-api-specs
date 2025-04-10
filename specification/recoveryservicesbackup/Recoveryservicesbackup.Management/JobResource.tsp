import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Defines workload agnostic properties for a job.
 */
model JobResource is Azure.ResourceManager.TrackedResource<Job> {
  ...ResourceNameParameter<
    Resource = JobResource,
    KeyName = "jobName",
    SegmentName = "backupJobs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface JobResources {
  /**
   * Gets extended information associated with the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("JobDetails_Get")
  get is ArmResourceRead<JobResource>;

  /**
   * Provides a pageable list of jobs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupJobs_List")
  list is ArmResourceListByParent<
    JobResource,
    Parameters = {
      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;

      /**
       * skipToken Filter.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<JobResourceList>
  >;

  /**
   * Cancels a job. This is an asynchronous operation. To know the status of the cancellation, call
   * GetCancelOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("cancel")
  @operationId("JobCancellations_Trigger")
  trigger is ArmResourceActionSync<JobResource, void, AcceptedResponse>;

  /**
   * Fetches the result of any operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{operationId}")
  @operationId("JobOperationResults_Get")
  jobOperationResultsGet is ArmResourceActionSync<
    JobResource,
    void,
    OkResponse | AcceptedResponse | NoContentResponse,
    Parameters = {
      /**
       * OperationID which represents the operation whose result has to be fetched.
       */
      @path
      operationId: string;
    }
  >;
}

@@doc(JobResource.name, "Name of the job whose details are to be fetched.");
@@doc(JobResource.properties, "JobResource properties");
