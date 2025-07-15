import "../models/release.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.CloudMine;

@tenantResource
@parentResource(Project)
model Release is ProxyResource<ReleaseProperties> {
  ...ResourceNameParameter<
    Resource = Release,
    KeyName = "releaseId",
    NamePattern = "^[0-9]+$"
  >;
}

@armResourceOperations
interface Releases {
  get is ArmResourceRead<Release>;
  list is ArmResourceListByParent<Release>;
}
