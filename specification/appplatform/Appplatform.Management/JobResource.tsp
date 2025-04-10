import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Job resource payload
 */
@parentResource(ServiceResource)
model JobResource
  is Azure.ResourceManager.ProxyResource<JobResourceProperties> {
  ...ResourceNameParameter<
    Resource = JobResource,
    KeyName = "jobName",
    SegmentName = "jobs",
    NamePattern = "^[a-z][a-z0-9-]*[a-z0-9]$"
  >;
}

@armResourceOperations
interface JobResources {
  /**
   * Get a Job and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Job_Get")
  get is ArmResourceRead<JobResource>;

  /**
   * Create a new Job or update an exiting Job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Job_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    JobResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Operation to delete a Job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Job_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<JobResource>;

  /**
   * Get the Azure Spring Apps Jobs in a given service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Jobs_List")
  list is ArmResourceListByParent<
    JobResource,
    Response = ArmResponse<JobResourceCollection>
  >;

  /**
   * Start an Azure Spring Apps Job
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Job_Start")
  start is ArmResourceActionAsync<
    JobResource,
    {
      /**
       * Template used to start a Job execution.
       */
      @bodyRoot
      template?: JobExecutionTemplate;
    },
    ArmResponse<JobExecution>
  >;

  /**
   * List sensitive environment variables of the Job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Job_ListEnvSecrets")
  listEnvSecrets is ArmResourceActionSync<
    JobResource,
    void,
    ArmResponse<EnvSecretsCollection>
  >;

  /**
   * Terminate execution of a running Azure Spring Apps Job
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("JobExecution_Cancel")
  cancel is ArmResourceActionAsyncBase<
    JobResource,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<JobResource>,
    Parameters = {
      /**
       * The name of the Job execution.
       */
      @pattern("^[a-z][a-z0-9-]*[a-z0-9]$")
      @path
      jobExecutionName: string;
    }
  >;

  /**
   * Get details of an execution of an Azure Spring Apps Job
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{jobExecutionName}")
  @operationId("JobExecution_Get")
  jobExecutionGet is ArmResourceActionSync<
    JobResource,
    void,
    ArmResponse<JobExecution>,
    Parameters = {
      /**
       * The name of the Job execution.
       */
      @pattern("^[a-z][a-z0-9-]*[a-z0-9]$")
      @path
      jobExecutionName: string;
    }
  >;

  /**
   * List sensitive environment variables of Job execution.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listEnvSecrets")
  @operationId("JobExecution_ListEnvSecrets")
  jobExecutionListEnvSecrets is ArmResourceActionSync<
    JobResource,
    void,
    ArmResponse<EnvSecretsCollection>,
    Parameters = {
      /**
       * The name of the Job execution.
       */
      @pattern("^[a-z][a-z0-9-]*[a-z0-9]$")
      @path
      jobExecutionName: string;
    }
  >;

  /**
   * Get executions of a Azure Spring Apps Job
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("executions")
  @operationId("JobExecutions_List")
  jobExecutionsList is ArmResourceActionSync<
    JobResource,
    void,
    ArmResponse<JobExecutionCollection>
  >;
}

@@doc(JobResource.name, "The name of the Job resource.");
@@doc(JobResource.properties, "Properties of the Job resource");
@@doc(JobResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
