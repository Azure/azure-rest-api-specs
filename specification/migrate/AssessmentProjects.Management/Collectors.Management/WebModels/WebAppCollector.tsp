import "./CollectorProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("The web app collector REST object.")
@parentResource(AssessmentProject)
model WebAppCollector is ProxyResource<CollectorPropertiesBaseWithAgent> {
  @doc("Web app collector ARM name.")
  @key("collectorName")
  @segment("webAppCollectors")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}
