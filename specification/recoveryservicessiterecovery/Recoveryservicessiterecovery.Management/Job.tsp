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
 * Job details.
 */
model Job is Azure.ResourceManager.ProxyResource<JobProperties> {
  ...ResourceNameParameter<
    Resource = Job,
    KeyName = "jobName",
    SegmentName = "replicationJobs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Jobs {
  /**
   * Get the details of an Azure Site Recovery job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationJobs_Get")
  get is ArmResourceRead<Job>;

  /**
   * Gets the list of Azure Site Recovery Jobs for the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationJobs_List")
  list is ArmResourceListByParent<
    Job,
    Parameters = {
      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<JobCollection>
  >;

  /**
   * The operation to cancel an Azure Site Recovery job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationJobs_Cancel")
  cancel is ArmResourceActionAsync<Job, void, ArmResponse<Job>>;

  /**
   * The operation to restart an Azure Site Recovery job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationJobs_Restart")
  restart is ArmResourceActionAsync<Job, void, ArmResponse<Job>>;

  /**
   * The operation to resume an Azure Site Recovery job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationJobs_Resume")
  resume is ArmResourceActionAsync<Job, ResumeJobParams, ArmResponse<Job>>;
}

@@doc(Job.name, "Job identifier.");
@@doc(Job.properties, "The custom data.");
@@doc(Jobs.resume::parameters.body, "Resume rob comments.");
