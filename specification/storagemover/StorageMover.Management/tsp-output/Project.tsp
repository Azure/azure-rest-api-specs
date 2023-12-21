import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StorageMover.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.StorageMover;
@doc("The Project resource.")
@parentResource(StorageMover)
model Project is ProxyResource<ProjectProperties> {
  @doc("The name of the Project resource.")
  @path
  @key("projectName")
  @segment("projects")
  name: string;
}

@armResourceOperations
interface Projects {
  @doc("Gets a Project resource.")
  get is ArmResourceRead<Project>;
  @doc("Creates or updates a Project resource, which is a logical grouping of related jobs.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Project>;
  @doc("Updates properties for a Project resource. Properties not specified in the request body will be unchanged.")
  update is ArmResourcePatchSync<Project, ProjectProperties>;
  @doc("Deletes a Project resource.")
  delete is ArmResourceDeleteAsync<Project>;
  @doc("Lists all Projects in a Storage Mover.")
  list is ArmResourceListByParent<Project>;
}
