import "@typespec/openapi";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

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
