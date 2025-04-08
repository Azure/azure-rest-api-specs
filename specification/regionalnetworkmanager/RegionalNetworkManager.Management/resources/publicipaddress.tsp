import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../../../microsoftinventory/commonmodelslib/common.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.RegionalNetworkManager management service" })
@versioned(Versions)
namespace Microsoft.RegionalNetworkManager;

@parentResource(TenantLocationResource)
model PublicIpAddress is ProxyResource<PublicIpAddressProperties> {
  @doc("The public ip address")
  @pattern("^[a-zA-Z0-9-.]{3,32}$")
  @segment("publicIpAddresses")
  @key("publicIpAddress")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@parentResource(TenantLocationResource)
@doc("Extended properties for rnm public ip address")
model PublicIpAddressProperties
  is Microsoft.Inventory.CommonTypes.PublicIpAddressPropertiesBase {
  @doc("Public IP Address FirstPartyUsageTag")
  firstpartyusagetag?: string;

  @doc("VirtualNetworkGuid")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  vnetguid: string;
}

@armResourceOperations
interface PublicIpAddresses {
  get is ArmResourceRead<PublicIpAddress>;
  list is ArmResourceListByParent<PublicIpAddress>;
}
