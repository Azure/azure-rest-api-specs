import "../models/repository.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.CloudMine;

@tenantResource
@parentResource(Project)
model Repository is ProxyResource<RepositoryProperties> {
  @doc("Repository id")
  @segment("repositories")
  @key("repositoryId")
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  name: string;
}

@armResourceOperations
interface Repositories {
  get is ArmResourceRead<Repository>;
  list is ArmResourceListByParent<Repository>;
}
