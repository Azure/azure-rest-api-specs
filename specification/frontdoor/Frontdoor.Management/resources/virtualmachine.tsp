import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
/** import "@azure-tools/typespec-autorest"; */
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-providerhub";
import "../models/virtualmachine.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Microsoft Azure Frontdoor Inventory",
  version: "2024-01-01-preview",
})
@doc("Azure Frontdoor VM management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Frontdoor;

@doc("AFD VM resource")
@tenantResource
model VmResource is ProxyResource<VmProperties> {
  @pattern("[a-zA-Z0-9]+[-_]*")
  @key("virtualMachineName")
  @segment("genericVirtualMachines")
  @doc("VirtualMachines")
  @path
  name: string;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface VmResources {
  get is ArmLocResourceRead<VmResource>;
  list is ArmLocResourceListByParent<VmResource>;
}
