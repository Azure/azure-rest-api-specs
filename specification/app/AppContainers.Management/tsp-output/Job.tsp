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
@doc("Container App Job")
model Job is TrackedResource<JobProperties> {
  @doc("Job Name")
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("jobName")
  @segment("jobs")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Jobs {
  @doc("Get the properties of a Container Apps Job.")
  get is ArmResourceRead<Job>;

  @doc("Create or Update a Container Apps Job.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Job,
    BaseParameters<Job>,
    ArmAsyncOperationHeader
  >;

  @doc("Patches a Container Apps Job using JSON Merge Patch")
  update is ArmCustomPatchAsync<Job, JobPatchProperties>;

  @doc("Delete a Container Apps Job.")
  delete is ArmResourceDeleteAsync<
    Job,
    BaseParameters<Job>,
    ArmLroLocationHeader
  >;

  @doc("Get the Container Apps Jobs in a given resource group.")
  listByResourceGroup is ArmResourceListByParent<Job>;

  @doc("Get the Container Apps Jobs in a given subscription.")
  listBySubscription is ArmListBySubscription<Job>;

  @doc("Start a Container Apps Job")
  start is ArmResourceActionAsync<
    Job,
    JobExecutionTemplate,
    JobExecutionBase,
    BaseParameters<Job>,
    ArmLroLocationHeader
  >;

  @doc("Terminates execution of a running container apps job")
  stopMultipleExecutions is ArmResourceActionAsync<
    Job,
    void,
    ResourceListResult<JobExecution>,
    BaseParameters<Job>,
    ArmLroLocationHeader
  >;

  @doc("List secrets for a container apps job")
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
