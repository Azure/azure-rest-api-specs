import "../models/project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.CloudMine;

@tenantResource
@parentResource(Organization)
model Project is ProxyResource<ProjectProperties> {
  @doc("Project id")
  @segment("projects")
  @key("projectId")
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  name: string;
}

@armResourceOperations
interface Projects {
  get is ArmResourceRead<Project>;
  list is ArmResourceListByParent<Project>;
}
