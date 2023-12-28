import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Represents a software data")
model Software is ProxyResource<SoftwareProperties> {
  @doc("Name of the installed software.")
  @key("softwareName")
  @segment("softwareInventories")
  name: string;
}

@armResourceOperations
interface SoftwareInventories {
  @doc("Gets a single software data of the virtual machine.")
  get is ArmResourceRead<Software>;
  @doc("Gets the software inventory of the virtual machine.")
  listByExtendedResource is ArmResourceListByParent<Software>;
  @doc("Gets the software inventory of all virtual machines in the subscriptions.")
  listBySubscription is ArmListBySubscription<Software>;
}
