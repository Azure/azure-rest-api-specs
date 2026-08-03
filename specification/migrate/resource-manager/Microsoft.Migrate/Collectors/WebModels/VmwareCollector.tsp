import "./CollectorProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("VMware collector resource.")
@parentResource(AssessmentProject)
model VmwareCollector is ProxyResource<CollectorPropertiesBaseWithAgent> {
  @doc("VMware collector ARM name")
  @key("vmWareCollectorName")
  @segment("vmwarecollectors")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}
