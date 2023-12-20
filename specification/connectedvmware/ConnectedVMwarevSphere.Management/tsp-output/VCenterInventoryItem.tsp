import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VMwareVCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ConnectedVMwarevSphere;
@doc("Defines the inventory item.")
@parentResource(VMwareVCenter)
model VCenterInventoryItem is ProxyResource<InventoryItemProperties> {
  @doc("Name of the inventoryItem.")
  @path
  @key("inventoryItemName")
  @segment("inventoryItems")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface VCenterInventoryItems {
  @doc("Implements InventoryItem GET method.")
  get is ArmResourceRead<VCenterInventoryItem>;
  @doc("Create Or Update InventoryItem.")
  create is ArmResourceCreateOrReplaceSync<VCenterInventoryItem>;
  @doc("Implements inventoryItem DELETE method.")
  delete is ArmResourceDeleteSync<VCenterInventoryItem>;
  @doc("Returns the list of inventoryItems of the given vCenter.")
  listByVCenter is ArmResourceListByParent<VCenterInventoryItem>;
}
