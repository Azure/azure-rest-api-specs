import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/virtualmachine.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Microsoft Azure Frontdoor Inventory",
})
@versioned(Microsoft.Frontdoor.Versions)
@doc("Azure Frontdoor VM management API.")
namespace Microsoft.Frontdoor;

@doc("AFD VM resource")
@tenantResource
model VmResource is ProxyResource<VmProperties> {
  @pattern("[a-zA-Z0-9]+[-_]*")
  @key("virtualMachineName")
  @segment("virtualMachines")
  @doc("VirtualMachines")
  @path
  name: string;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface VmResources {
  get is ArmLocResourceRead<VmResource>;
  listByTenant is ArmLocResourceListByParent<VmResource>;
}
