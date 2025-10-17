import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/publicnetworkaddress.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.Frontdoor management service" })
@versioned(Microsoft.Frontdoor.Versions)
namespace Microsoft.Frontdoor;

@doc("Azure Frontdoor PublicNetworkAddress resource")
@added(Versions.v2025_08_01_preview)
@parentResource(TenantLocationResource)
model PublicNetworkAddress is ProxyResource<PublicNetworkAddressProperties> {
  @pattern("[a-zA-Z0-9.:]+-[a-zA-Z0-9]")
  @key("ipAddress")
  @segment("publicNetworkAddresses")
  @doc("Ip Address")
  @path
  name: string;
}

@added(Versions.v2025_08_01_preview)
@armResourceOperations
interface PublicNetworkAddresses {
  get is ArmResourceRead<PublicNetworkAddress>;
  listByTenant is ArmResourceListByParent<PublicNetworkAddress>;
}
