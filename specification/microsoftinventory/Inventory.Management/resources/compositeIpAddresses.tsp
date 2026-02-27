import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/compositeIpAddresses.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Inventory;

@added(Versions.v2025_03_01_preview)
@tenantResource
@parentResource(TenantLocationResource)
model CompositeIpAddressesResource
  is ProxyResource<CompositeIpAddressesProperties> {
  @pattern("[a-zA-Z0-9]+-[a-zA-Z0-9.:]+-[a-zA-Z0-9]")
  @key("ipAddressKey")
  @segment("compositeIpAddresses")
  @doc("Ip Address")
  @path
  name: string;
}

@added(Versions.v2025_03_01_preview)
@armResourceOperations
interface CompositeIpAddresses {
  get is ArmResourceRead<CompositeIpAddressesResource>;
  list is ArmResourceListByParent<CompositeIpAddressesResource>;
}
