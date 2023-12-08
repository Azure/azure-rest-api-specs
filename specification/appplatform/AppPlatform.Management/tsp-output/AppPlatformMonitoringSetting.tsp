import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Monitoring Setting resource")
@parentResource(AppPlatformService)
@singleton("default")
model AppPlatformMonitoringSetting
  is ProxyResource<MonitoringSettingProperties> {
  @key("default")
  @segment("monitoringSettings")
  name: string;
}

@armResourceOperations
interface AppPlatformMonitoringSettings {
  @doc("Get the Monitoring Setting and its properties.")
  get is ArmResourceRead<AppPlatformMonitoringSetting>;
  @doc("Update the Monitoring Setting.")
  updatePut is ArmResourceCreateOrUpdateAsync<AppPlatformMonitoringSetting>;
  @doc("Update the Monitoring Setting.")
  updatePatch is ArmResourcePatchAsync<
    AppPlatformMonitoringSetting,
    MonitoringSettingProperties
  >;
}
