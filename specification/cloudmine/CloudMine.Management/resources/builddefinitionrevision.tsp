import "../models/builddefinitionrevision.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.CloudMine;

@tenantResource
@parentResource(BuildDefinition)
model BuildDefinitionRevision
  is ProxyResource<BuildDefinitionRevisionProperties> {
  @doc("Revision of the build definition")
  @segment("revisions")
  @key("revision")
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[0-9]+$")
  name: string;
}

@armResourceOperations
interface BuildDefinitionRevisions {
  get is ArmResourceRead<BuildDefinitionRevision>;
  list is ArmResourceListByParent<BuildDefinitionRevision>;
}
