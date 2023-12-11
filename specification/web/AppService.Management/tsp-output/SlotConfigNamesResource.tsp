import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Slot Config names azure resource.")
@parentResource(WebSite)
@singleton("slotConfigNames")
model SlotConfigNamesResource is ProxyResource<SlotConfigNames> {
  @key("slotConfigNames")
  @segment("config")
  name: string;
}

@armResourceOperations
interface SlotConfigNamesResources {
  @doc("Description for Gets the names of app settings and connection strings that stick to the slot (not swapped).")
  listSlotConfigurationNames is ArmResourceRead<SlotConfigNamesResource>;
  @doc("Description for Updates the names of application settings and connection string that remain with the slot during swap operation.")
  updateSlotConfigurationNames is ArmResourceCreateOrReplaceSync<SlotConfigNamesResource>;
  @doc("Description for List the configurations of an app")
  listByWebSite is ArmResourceListByParent<SlotConfigNamesResource>;
}
