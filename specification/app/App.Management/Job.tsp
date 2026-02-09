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

@armResourceOperations(#{ omitTags: true })
interface Jobs {
  /**
   * Get the properties of a Container Apps Job.
   */
  @tag("Jobs")
  @summary("Get the properties of a Container Apps Job.")
  get is ArmResourceRead<Job, Error = DefaultErrorResponse>;

  /**
   * Create or Update a Container Apps Job.
   */
  @tag("Jobs")
  @summary("Create or Update a Container Apps Job.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Job,
    Error = DefaultErrorResponse
  >;

  /**
   * Patches a Container Apps Job using JSON Merge Patch
   */
  @tag("Jobs")
  @patch(#{ implicitOptionality: false })
  @summary("Update properties of a Container Apps Job")
  update is ArmCustomPatchAsync<
    Job,
    PatchModel = JobPatchProperties,
    Error = DefaultErrorResponse
  >;

  /**
   * Delete a Container Apps Job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @tag("Jobs")
  @summary("Delete a Container Apps Job.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Job,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Get the Container Apps Jobs in a given resource group.
   */
  @tag("Jobs")
  @summary("Get the Container Apps Jobs in a given resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Job,
    Response = ArmResponse<JobsCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Get the Container Apps Jobs in a given subscription.
   */
  @tag("Jobs")
  @summary("Get the Container Apps Jobs in a given subscription.")
  listBySubscription is ArmListBySubscription<
    Job,
    Response = ArmResponse<JobsCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Start a Container Apps Job
   */
  @tag("Jobs")
  @summary("Start a Container Apps Job")
  start is ArmResourceActionAsyncBase<
    Job,
    JobExecutionTemplate,
    ArmResponse<JobExecutionBase> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = JobExecutionBase> &
      Azure.Core.Foundations.RetryAfterHeader>,
    DefaultBaseParameters<Job>,
    OptionalRequestBody = true,
    Error = DefaultErrorResponse
  >;

  /**
   * Terminates execution of a running container apps job
   */
  @tag("Jobs")
  @action("stop")
  @summary("Terminates execution of a running container apps job")
  stopMultipleExecutions is ArmResourceActionAsyncBase<
    Job,
    void,
    ArmResponse<ContainerAppJobExecutions> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ContainerAppJobExecutions> &
      Azure.Core.Foundations.RetryAfterHeader>,
    DefaultBaseParameters<Job>,
    Error = DefaultErrorResponse
  >;

  /**
   * List secrets for a container apps job
   */
  @tag("Jobs")
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
  @tag("Jobs")
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
  @tag("Jobs")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" ""
  @operationId("JobExecution")
  @tag("Jobs")
  @summary("Get details of a single job execution")
  jobExecution is ArmResourceRead<JobExecution, Error = DefaultErrorResponse>;

  /**
   * Get a Container Apps Job's executions
   */
  @tag("Jobs")
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
  @tag("Jobs")
  @action("stop")
  @summary("Terminates execution of a running container apps job")
  stopExecution is ArmResourceActionAsyncBase<
    JobExecution,
    void,
    OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    DefaultBaseParameters<Job>,
    Error = DefaultErrorResponse
  >;

  /**
   * Get the properties of a Container App Job.
   */
  @tag("Jobs")
  @tag("Diagnostics")
  @summary("Get the properties for a given Container App Job.")
  proxyGet is ArmResourceRead<
    Job,
    Parameters = {
      /** Proxy API Name for Container App Job. */
      @path
      @segment("detectorProperties")
      @key
      @pattern("^[-\\w\\._]+$")
      apiName: string;
    },
    Error = DefaultErrorResponse
  >;

  /**
   * Get the list of diagnostics for a Container App Job.
   */
  @tag("Jobs")
  @tag("Diagnostics")
  @summary("Get the list of diagnostics for a given Container App Job.")
  listDetectors is JobsDiagnosticsDetectorOps.List<
    Diagnostics,
    Response = ArmResponse<DiagnosticsCollection>
  >;

  /**
   * Get the diagnostics data for a Container App Job.
   */
  @tag("Jobs")
  @tag("Diagnostics")
  @summary("Get the diagnostics data for a given Container App Job.")
  getDetector is JobsDiagnosticsDetectorOps.Read<
    Diagnostics,
    Response = ArmResponse<Diagnostics>
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
