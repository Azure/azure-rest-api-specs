import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Monitoring Setting resource")
@singleton("default")
@parentResource(ServiceResource)
model MonitoringSettingResource is ProxyResource<MonitoringSettingProperties> {
  @key("default")
  @segment("monitoringSettings")
  name: string;
}

@armResourceOperations
interface MonitoringSettings {
  @doc("Get the Monitoring Setting and its properties.")
  get is ArmResourceRead<MonitoringSettingResource>;
  @doc("Update the Monitoring Setting.")
  updatePut is ArmResourceCreateOrUpdateAsync<MonitoringSettingResource>;
  @doc("Update the Monitoring Setting.")
  updatePatch is ArmCustomPatchAsync<
    MonitoringSettingResource,
    MonitoringSettingResource
  >;
}
