using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Private endpoint connection resource.")
@parentResource(AssessmentProject)
model PrivateEndpointConnection
  is ProxyResource<Azure.ResourceManager.PrivateEndpointConnectionProperties> {
  @doc("Private endpoint connection ARM name")
  @segment("privateEndpointConnections")
  @key("privateEndpointConnectionName")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}
