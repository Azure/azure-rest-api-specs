import "../models/releasedefinitionrevision.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.CloudMine;

@tenantResource
@parentResource(ReleaseDefinition)
model ReleaseDefinitionRevision
  is ProxyResource<ReleaseDefinitionRevisionProperties> {
  @doc("Revision of the release definition")
  @segment("revisions")
  @key("revision")
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[0-9]+$")
  name: string;
}

@armResourceOperations
interface ReleaseDefinitionRevisions {
  get is ArmResourceRead<ReleaseDefinitionRevision>;
  list is ArmResourceListByParent<ReleaseDefinitionRevision>;
}
