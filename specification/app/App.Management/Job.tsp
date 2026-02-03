import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Container App Job
 */
model Job is Azure.ResourceManager.TrackedResource<JobProperties> {
  ...ResourceNameParameter<
    Resource = Job,
    KeyName = "jobName",
    SegmentName = "jobs",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;

  /**
   * The complex type of the extended location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface Jobs {
  /**
   * Get the properties of a Container Apps Job.
   */
  @summary("Get the properties of a Container Apps Job.")
  get is ArmResourceRead<Job, Error = DefaultErrorResponse>;

  /**
   * Create or Update a Container Apps Job.
   */
  @summary("Create or Update a Container Apps Job.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Job,
    Error = DefaultErrorResponse
  >;

  /**
   * Patches a Container Apps Job using JSON Merge Patch
   */
  @patch(#{ implicitOptionality: false })
  @summary("Update properties of a Container Apps Job")
  update is ArmCustomPatchAsync<Job, PatchModel = JobPatchProperties>;

  /**
   * Delete a Container Apps Job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @summary("Delete a Container Apps Job.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Job,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Get the Container Apps Jobs in a given resource group.
   */
  @summary("Get the Container Apps Jobs in a given resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Job,
    Response = ArmResponse<JobsCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Get the Container Apps Jobs in a given subscription.
   */
  @summary("Get the Container Apps Jobs in a given subscription.")
  listBySubscription is ArmListBySubscription<
    Job,
    Response = ArmResponse<JobsCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Start a Container Apps Job
   */
  @summary("Start a Container Apps Job")
  start is ArmResourceActionAsyncBase<
    Job,
    JobExecutionTemplate,
    ArmResponse<JobExecutionBase>,
    DefaultBaseParameters<Job>,
    OptionalRequestBody = true,
    Error = DefaultErrorResponse
  >;

  /**
   * Terminates execution of a running container apps job
   */
  @action("stop")
  @summary("Terminates execution of a running container apps job")
  stopMultipleExecutions is ArmResourceActionAsyncBase<
    Job,
    void,
    ArmResponse<ContainerAppJobExecutions>,
    DefaultBaseParameters<Job>,
    Error = DefaultErrorResponse
  >;

  /**
   * List secrets for a container apps job
   */
  @list
  @summary("List secrets for a container apps job")
  listSecrets is ArmResourceActionSync<
    Job,
    void,
    ArmResponse<JobSecretsCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Resumes a suspended job
   */
  @summary("Resumes a suspended job")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  resume is ArmResourceActionAsyncBase<
    Job,
    void,
    ArmResponse<Job> | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = Job> &
      ArmLroLocationHeader<FinalResult = Job> &
      Azure.Core.Foundations.RetryAfterHeader>,
    DefaultBaseParameters<Job>
  >;

  /**
   * Suspends a job
   */
  @summary("Suspends a job")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  suspend is ArmResourceActionAsyncBase<
    Job,
    void,
    ArmResponse<Job> | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = Job> &
      ArmLroLocationHeader<FinalResult = Job> &
      Azure.Core.Foundations.RetryAfterHeader>,
    DefaultBaseParameters<Job>
  >;

  /**
   * Get details of a single job execution
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("JobExecution")
  @summary("Get details of a single job execution")
  jobExecution is ArmResourceRead<JobExecution, Error = DefaultErrorResponse>;

  /**
   * Get a Container Apps Job's executions
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("JobsExecutions_List")
  @summary("Get a Container Apps Job's executions")
  list is ArmResourceListByParent<
    JobExecution,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<ContainerAppJobExecutions>,
    Error = DefaultErrorResponse
  >;

  /**
   * Terminates execution of a running container apps job
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Jobs_StopExecution")
  @action("stop")
  @summary("Terminates execution of a running container apps job")
  stopExecution is ArmResourceActionAsyncBase<
    JobExecution,
    void,
    OkResponse,
    DefaultBaseParameters<Job>,
    Error = DefaultErrorResponse
  >;
}

@@doc(Job.name, "Job Name");
@@doc(Job.properties, "Container Apps Job resource specific properties.");
@@doc(Jobs.createOrUpdate::parameters.resource,
  "Properties used to create a container apps job"
);
@@doc(Jobs.update::parameters.properties,
  "Properties used to create a container apps job"
);
@@doc(Jobs.start::parameters.body, "Properties used to start a job execution.");
