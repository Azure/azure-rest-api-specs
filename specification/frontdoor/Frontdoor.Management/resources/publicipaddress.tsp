import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/commonmodelslib.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.Frontdoor management service" })
@versioned(Microsoft.Frontdoor.Versions)
namespace Microsoft.Frontdoor;

@parentResource(TenantLocationResource)
model PublicIpAddress
  is ProxyResource<Microsoft.Inventory.CommonTypes.PublicIpAddressPropertiesBase> {
  @doc("The public ip address")
  @pattern("[a-zA-Z0-9-]{3,32}")
  @segment("publicIpAddresses")
  @key("publicIpAddress")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@armResourceOperations
interface PublicIpAddresses {
  get is ArmResourceRead<PublicIpAddress>;
  list is ArmResourceListByParent<PublicIpAddress>;
}
