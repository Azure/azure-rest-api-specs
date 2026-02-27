import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/privatenetworkaddress.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.Frontdoor management service" })
@versioned(Microsoft.Frontdoor.Versions)
namespace Microsoft.Frontdoor;

@added(Versions.v2025_08_01_preview)
@doc("Azure Frontdoor PrivateNetworkAddress resource")
@parentResource(TenantLocationResource)
model PrivateNetworkAddress is ProxyResource<PrivateNetworkAddressProperties> {
  @pattern("[a-zA-Z0-9.:]+-[a-zA-Z0-9]")
  @key("ipAddress")
  @segment("privateNetworkAddresses")
  @doc("Ip Address")
  @path
  name: string;
}

@added(Versions.v2025_08_01_preview)
@armResourceOperations
interface PrivateNetworkAddresses {
  get is ArmResourceRead<PrivateNetworkAddress>;
  listByTenant is ArmResourceListByParent<PrivateNetworkAddress>;
}
