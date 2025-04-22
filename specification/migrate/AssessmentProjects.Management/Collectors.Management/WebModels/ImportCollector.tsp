import "./CollectorProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Import collector resource.")
@parentResource(AssessmentProject)
model ImportCollector is ProxyResource<CollectorPropertiesBase> {
  @doc("Import collector ARM name")
  @key("importCollectorName")
  @segment("importcollectors")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}
