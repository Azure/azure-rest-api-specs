import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
/** import "@azure-tools/typespec-autorest"; */
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/datacenter.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Microsoft Inventory",
})
@versioned(Microsoft.Inventory.Versions)
namespace Microsoft.Inventory;

@tenantResource
model DatacenterResource is ProxyResource<DatacenterProperties> {
  @pattern("[a-zA-Z0-9]+[-_]*")
  @key("datacenterName")
  @segment("physicalDatacenters")
  @doc("Datacenter")
  @path
  name: string;
}

@armResourceOperations
interface Datacenters {
  getDatacenter is ArmLocResourceRead<DatacenterResource>;
  list is ArmLocResourceListByParent<DatacenterResource>;
}
