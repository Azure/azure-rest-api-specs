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
@parentResource(VaultResource)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  trigger is ArmResourceActionSync<JobResource, void, AcceptedResponse>;
}

@armResourceOperations
interface JobOperationResultsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** vaults */
        @path @segment("vaults") vaultName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = JobResource,
          KeyName = "jobName",
          SegmentName = "backupJobs",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = JobResource,
        KeyName = "operationId",
        SegmentName = "operationResults",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface JobOperationResults {
  /**
   * Fetches the result of any operation.
   */
  @get
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  get is JobOperationResultsOps.Read<
    JobResource,
    Response = OkResponse | AcceptedResponse | ArmNoContentResponse
  >;
}

@armResourceOperations
interface ExportJobsOperationResultsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** vaults */
        @path @segment("vaults") vaultName: string,

        /** backupJobs */
        @path backupJobs: "backupJobs",
      },
      KeysOf<ResourceNameParameter<
        Resource = JobResource,
        KeyName = "operationId",
        SegmentName = "operationResults",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ExportJobsOperationResults {
  /**
   * Gets the operation result of operation triggered by Export Jobs API. If the operation is successful, then it also
   * contains URL of a Blob and a SAS key to access the same. The blob contains exported jobs in JSON serialized format.
   */
  @get
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  get is ExportJobsOperationResultsOps.Read<
    JobResource,
    Response = ArmResponse<OperationResultInfoBaseResource> | {
      ...AcceptedResponse;
      @body body: OperationResultInfoBaseResource;
    }
  >;
}

@@doc(JobResource.name, "Name of the job whose details are to be fetched.");
@@doc(JobResource.properties, "JobResource properties");
