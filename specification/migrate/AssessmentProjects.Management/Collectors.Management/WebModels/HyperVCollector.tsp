import "./CollectorProperties.tsp";
import "../Common/ArmModels/AssessmentProjectV2.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Hyper-V collector resource.")
@parentResource(AssessmentProject)
model HypervCollector is ProxyResource<CollectorPropertiesBaseWithAgent> {
  @doc("Hyper-V collector ARM name")
  @key("hypervCollectorName")
  @segment("hypervcollectors")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}
