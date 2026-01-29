import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
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
  get is ArmResourceRead<Job>;

  /**
   * Create or Update a Container Apps Job.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Job>;

  /**
   * Patches a Container Apps Job using JSON Merge Patch
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Job, PatchModel = JobPatchProperties>;

  /**
   * Delete a Container Apps Job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Job,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get the Container Apps Jobs in a given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Job,
    Response = ArmResponse<JobsCollection>
  >;

  /**
   * Get the Container Apps Jobs in a given subscription.
   */
  listBySubscription is ArmListBySubscription<
    Job,
    Response = ArmResponse<JobsCollection>
  >;

  /**
   * Start a Container Apps Job
   */
  start is ArmResourceActionAsync<
    Job,
    JobExecutionTemplate,
    ArmResponse<JobExecutionBase>,
    OptionalRequestBody = true
  >;

  /**
   * Terminates execution of a running container apps job
   */
  @list
  @action("stop")
  stopMultipleExecutions is ArmResourceActionAsync<
    Job,
    void,
    ArmResponse<ContainerAppJobExecutions>
  >;

  /**
   * List secrets for a container apps job
   */
  @list
  listSecrets is ArmResourceActionSync<
    Job,
    void,
    ArmResponse<JobSecretsCollection>
  >;

  /**
   * Resumes a suspended job
   */
  resume is ArmResourceActionAsync<
    Job,
    void,
    ArmResponse<Job>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Job> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Suspends a job
   */
  suspend is ArmResourceActionAsync<
    Job,
    void,
    ArmResponse<Job>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Job> &
      Azure.Core.Foundations.RetryAfterHeader
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
