import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.StorageMover;
@doc("The Job Definition resource.")
@parentResource(Project)
model JobDefinition is ProxyResource<JobDefinitionProperties> {
  @doc("The name of the Job Definition resource.")
  @key("jobDefinitionName")
  @segment("jobDefinitions")
  name: string;
}

@armResourceOperations
interface JobDefinitions {
  @doc("Gets a Job Definition resource.")
  get is ArmResourceRead<JobDefinition>;

  @doc("Creates or updates a Job Definition resource, which contains configuration for a single unit of managed data transfer.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<JobDefinition>;

  @doc("Updates properties for a Job Definition resource. Properties not specified in the request body will be unchanged.")
  update is ArmCustomPatchSync<JobDefinition, JobDefinitionUpdateParameters>;

  @doc("Deletes a Job Definition resource.")
  delete is ArmResourceDeleteAsync<JobDefinition>;

  @doc("Lists all Job Definitions in a Project.")
  list is ArmResourceListByParent<JobDefinition>;

  @doc("Requests an Agent to start a new instance of this Job Definition, generating a new Job Run resource.")
  startJob is ArmResourceActionSync<JobDefinition, void, JobRunResourceId>;

  @doc("Requests the Agent of any active instance of this Job Definition to stop.")
  stopJob is ArmResourceActionSync<JobDefinition, void, JobRunResourceId>;
}
