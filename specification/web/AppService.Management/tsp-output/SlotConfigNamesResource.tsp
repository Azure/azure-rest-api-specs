import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("Slot Config names azure resource.")
@singleton("slotConfigNames")
@parentResource(Site)
model SlotConfigNamesResource is ProxyResource<SlotConfigNames> {
  @key("config")
  @segment("config")
  name: string;
}

@armResourceOperations
@projectedName("client", "WebApps")
interface SlotConfigNamesResources_WebApps {
  @doc("Description for Gets the names of app settings and connection strings that stick to the slot (not swapped).")
  listSlotConfigurationNames is ArmResourceRead<SlotConfigNamesResource>;

  @doc("Description for Updates the names of application settings and connection string that remain with the slot during swap operation.")
  updateSlotConfigurationNames is ArmResourceCreateOrReplaceSync<SlotConfigNamesResource>;

  @doc("Description for List the configurations of an app")
  listConfigurations is ArmResourceListByParent<SlotConfigNamesResource>;
}
