import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Dsms;

@added(Versions.v2025_08_01_preview)
@doc("Endpoint Resource")
@parentResource(TenantLocationResource)
model Endpoint is ProxyResource<EndpointProperties> {
  @doc("The name of the Endpoint")
  @key("endpointName")
  @segment("endpoints")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@armResourceOperations
@added(Versions.v2025_08_01_preview)
interface Endpoints {
  @summary("Retrieves the specified Endpoint resource.")
  get is ArmResourceRead<Endpoint>;

  @summary("Lists the specified Endpoint resources.")
  list is ArmResourceListByParent<Endpoint>;
}
