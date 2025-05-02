import "../models/releasedefinition.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.CloudMine;

@tenantResource
@parentResource(Project)
model ReleaseDefinition is ProxyResource<ReleaseDefinitionProperties> {
  @doc("Release definition id")
  @segment("releaseDefinitions")
  @key("releaseDefinitionId")
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[0-9]+$")
  name: string;
}

@armResourceOperations
interface ReleaseDefinitions {
  get is ArmResourceRead<ReleaseDefinition>;
  list is ArmResourceListByParent<ReleaseDefinition>;
}
