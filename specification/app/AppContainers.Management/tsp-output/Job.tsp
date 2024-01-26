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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(JobProperties)
model Job extends TrackedResourceBase {
  /**
   * Job Name
   */
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("jobName")
  @segment("jobs")
  @visibility("read")
  name: string;

  /**
   * Container Apps Job resource specific properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: JobProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Job,
    BaseParameters<Job>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patches a Container Apps Job using JSON Merge Patch
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<Job, JobPatchProperties>;

  /**
   * Delete a Container Apps Job.
   */
  delete is ArmResourceDeleteAsync<
    Job,
    BaseParameters<Job>,
    ArmLroLocationHeader
  >;

  /**
   * Get the Container Apps Jobs in a given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Jobs_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Job>;

  /**
   * Get the Container Apps Jobs in a given subscription.
   */
  listBySubscription is ArmListBySubscription<Job>;

  /**
   * Start a Container Apps Job
   */
  start is ArmResourceActionAsync<
    Job,
    JobExecutionTemplate,
    JobExecutionBase,
    BaseParameters<Job>,
    ArmLroLocationHeader
  >;

  /**
   * Terminates execution of a running container apps job
   */
  stopMultipleExecutions is ArmResourceActionAsync<
    Job,
    void,
    ResourceListResult<JobExecution>,
    BaseParameters<Job>,
    ArmLroLocationHeader
  >;

  /**
   * List secrets for a container apps job
   */
  listSecrets is ArmResourceActionSync<Job, void, JobSecretsCollection>;
}

@@projectedName(Jobs.createOrUpdate::parameters.resource,
  "json",
  "JobEnvelope"
);
@@extension(Jobs.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "JobEnvelope"
);
@@doc(Jobs.createOrUpdate::parameters.resource,
  "Properties used to create a container apps job"
);
@@projectedName(Jobs.update::parameters.properties, "json", "JobEnvelope");
@@extension(Jobs.update::parameters.properties,
  "x-ms-client-name",
  "JobEnvelope"
);
@@doc(Jobs.update::parameters.properties,
  "Properties used to create a container apps job"
);
@@projectedName(Jobs.start::parameters.body, "json", "template");
@@extension(Jobs.start::parameters.body, "x-ms-client-name", "template");
@@doc(Jobs.start::parameters.body, "Properties used to start a job execution.");
