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
model Job is TrackedResource<JobProperties> {
  @doc("Job Name")
  @pattern("^[-\\w\\._\\(\\)]+$")
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
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Job>;
  @doc("Patches a Container Apps Job using JSON Merge Patch")
  update is ArmCustomPatchAsync<Job, JobPatchProperties>;
  @doc("Delete a Container Apps Job.")
  delete is ArmResourceDeleteAsync<Job>;
  @doc("Get the Container Apps Jobs in a given resource group.")
  listByResourceGroup is ArmResourceListByParent<Job>;
  @doc("Get the Container Apps Jobs in a given subscription.")
  listBySubscription is ArmListBySubscription<Job>;
  @doc("Start a Container Apps Job")
  start is ArmResourceActionAsync<Job, JobExecutionTemplate, JobExecutionBase>;
  @doc("Terminates execution of a running container apps job")
  stopMultipleExecutions is ArmResourceActionAsync<
    Job,
    void,
    ResourceListResult<JobExecution>
  >;
  @doc("List secrets for a container apps job")
  listSecrets is ArmResourceActionSync<Job, void, JobSecretsCollection>;
}
