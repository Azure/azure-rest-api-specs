import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppContainers;
@doc("Container App Job")
model ContainerAppJob is TrackedResource<JobProperties> {
  @doc("Job Name")
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("jobName")
  @segment("jobs")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface ContainerAppJobs {
  @doc("Get the properties of a Container Apps Job.")
  get is ArmResourceRead<ContainerAppJob>;
  @doc("Create or Update a Container Apps Job.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ContainerAppJob>;
  @doc("Patches a Container Apps Job using JSON Merge Patch")
  update is ArmResourcePatchAsync<ContainerAppJob, JobProperties>;
  @doc("Delete a Container Apps Job.")
  delete is ArmResourceDeleteAsync<ContainerAppJob>;
  @doc("Get the Container Apps Jobs in a given resource group.")
  listByResourceGroup is ArmResourceListByParent<ContainerAppJob>;
  @doc("Get the Container Apps Jobs in a given subscription.")
  listBySubscription is ArmListBySubscription<ContainerAppJob>;
  @doc("Start a Container Apps Job")
  start is ArmResourceActionAsync<
    ContainerAppJob,
    JobExecutionTemplate,
    JobExecutionBase
  >;
  @doc("Terminates execution of a running container apps job")
  stopMultipleExecutions is ArmResourceActionAsync<
    ContainerAppJob,
    void,
    ResourceListResult<ContainerAppJobExecution>
  >;
  @doc("List secrets for a container apps job")
  listSecrets is ArmResourceActionSync<
    ContainerAppJob,
    void,
    JobSecretsCollection
  >;
}
