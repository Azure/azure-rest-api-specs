import "@typespec/versioning";

import "../common/CommonModels.tsp";

using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

@removed(Versions.v2024_06_01)
@doc("Wi-Fi Vendor for the SSID.")
union WifiVendor {
  @doc("Wifi vendor RuckusCommscope.")
  RuckusCommscope: "RuckusCommscope",

  string,
}

@removed(Versions.v2024_06_01)
@doc("Wi-Fi SSID properties.")
model WifiSsidPropertiesFormat {
  @doc("The provisioning state of the Wi-Fi SSID resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("An optional description for this Wi-Fi SSID.")
  description?: string;

  @doc("Third party vendor of the Wi-Fi SSID.")
  wifiVendor?: WifiVendor;
}
