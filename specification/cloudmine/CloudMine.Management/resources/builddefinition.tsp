import "../models/builddefinition.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.CloudMine;

@tenantResource
@parentResource(Project)
model BuildDefinition is ProxyResource<BuildDefinitionProperties> {
  @doc("Build definition id")
  @segment("buildDefinitions")
  @key("buildDefinitionId")
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[0-9]+$")
  name: string;
}

@armResourceOperations
interface BuildDefinitions {
  get is ArmResourceRead<BuildDefinition>;
  list is ArmResourceListByParent<BuildDefinition>;
}
