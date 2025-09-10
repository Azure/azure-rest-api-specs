import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.NetworkServiceManager;

@added(Versions.v2025_05_21_preview)
@parentResource(TenantLocationResource)
model PublicIpAddress is ProxyResource<PublicIpAddressProperties> {
  @doc("The public IP address")
  @pattern("^[a-zA-Z0-9-.]{3,32}$")
  @segment("publicIpAddresses")
  @key("publicIpAddress")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@added(Versions.v2025_05_21_preview)
@parentResource(TenantLocationResource)
@doc("Extended properties for NSM public IP address")
model PublicIpAddressProperties
  is Microsoft.Inventory.CommonTypes.PublicIpAddressPropertiesBase {
  @doc("Cloud where the IP address exists")
  cloud: string;
}

@added(Versions.v2025_05_21_preview)
@armResourceOperations
interface PublicIpAddresses {
  get is ArmResourceRead<PublicIpAddress>;
  list is ArmResourceListByParent<PublicIpAddress>;
}
