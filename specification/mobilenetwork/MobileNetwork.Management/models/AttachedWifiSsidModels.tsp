import "@typespec/openapi";
import "@typespec/versioning";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

@removed(Versions.v2024_06_01)
@doc("Wi-Fi Attached SSID properties.")
model AttachedWifiSsidPropertiesFormat {
  @doc("The provisioning state of the Wi-Fi Attached SSID resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The interface on the access side which receives traffic for this SSID.")
  accessInterface?: EdgeNetworkInterface;

  @doc("The address pool used by the Wi-Fi Access Point for this SSID when allocating an IP address to a UE.")
  @minItems(1)
  @extension("x-ms-identifiers", [])
  wifiUserEquipmentAddressPoolSubnet?: UserEquipmentAddressPool[];
}
