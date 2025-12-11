import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Legacy;
using TypeSpec.Http;

namespace Microsoft.RecoveryServices;
/**
 * Defines workload agnostic properties for a job.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy TrackedResourceWithOptionalLocation for back compatibility"
@parentResource(VaultResource)
model JobResource is TrackedResourceWithOptionalLocation<Job> {
  ...ResourceNameParameter<
    Resource = JobResource,
    KeyName = "jobName",
    SegmentName = "backupJobs",
    NamePattern = ""
  >;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: string;
}

@armResourceOperations
interface JobDetails {
  /**
   * Gets extended information associated with the job.
   */
  get is ArmResourceRead<JobResource>;
}

@armResourceOperations
interface BackupJobs {
  /**
   * Provides a pageable list of jobs.
   */
  @list
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
}

@armResourceOperations
interface JobCancellations {
  /**
   * Cancels a job. This is an asynchronous operation. To know the status of the cancellation, call
   * GetCancelOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("cancel")
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
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
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
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
