import "../Common/ArmModels/AzureResourceProperties.tsp";
import "@azure-tools/typespec-autorest";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Private link resource.")
@parentResource(AssessmentProject)
model PrivateLinkResource
  is ProxyResource<Azure.ResourceManager.PrivateLinkResourceProperties> {
  @doc("Private link resource ARM name")
  @key("privateLinkResourceName")
  @segment("privateLinkResources")
  @path
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}
