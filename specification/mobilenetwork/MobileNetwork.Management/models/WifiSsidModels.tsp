import "../common/CommonModels.tsp";

namespace Microsoft.MobileNetwork;

@doc("Wi-Fi Vendor for the SSID.")
union WifiVendor {
  @doc("Wifi vendor RuckusCommscope.")
  RuckusCommscope: "RuckusCommscope",

  string,
}

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
