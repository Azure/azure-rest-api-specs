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
@parentResource(Vault)
model Job is Azure.ResourceManager.ProxyResource<JobProperties> {
  ...ResourceNameParameter<
    Resource = Job,
    KeyName = "jobName",
    SegmentName = "replicationJobs",
    NamePattern = ""
  >;

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

alias JobAcceptedLroResponse = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Job> &
  Azure.Core.Foundations.RetryAfterHeader>;

@armResourceOperations
interface Jobs {
  /**
   * Get the details of an Azure Site Recovery job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the job details.")
  get is ArmResourceRead<Job, Error = never>;

  /**
   * Gets the list of Azure Site Recovery Jobs for the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the list of jobs.")
  list is ArmResourceListByParent<
    Job,
    Parameters = {
      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<JobCollection>,
    Error = never
  >;

  /**
   * The operation to cancel an Azure Site Recovery job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Cancels the specified job.")
  cancel is ArmResourceActionAsyncBase<
    Job,
    void,
    ArmResponse<Job> | JobAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Job>,
    Error = never
  >;

  /**
   * The operation to restart an Azure Site Recovery job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Restarts the specified job.")
  restart is ArmResourceActionAsyncBase<
    Job,
    void,
    ArmResponse<Job> | JobAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Job>,
    Error = never
  >;

  /**
   * The operation to resume an Azure Site Recovery job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Resumes the specified job.")
  resume is ArmResourceActionAsyncBase<
    Job,
    ResumeJobParams,
    ArmResponse<Job> | JobAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Job>,
    Error = never
  >;
}

@@doc(Job.name, "Job identifier.");
@@doc(Job.properties, "The custom data.");
@@doc(Jobs.resume::parameters.body, "Resume rob comments.");
