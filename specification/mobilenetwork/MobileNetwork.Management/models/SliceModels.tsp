import "../common/CommonModels.tsp";

namespace Microsoft.MobileNetwork;

@doc("Network slice properties.")
model SlicePropertiesFormat {
  @doc("The provisioning state of the network slice resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Single-network slice selection assistance information (S-NSSAI). Unique at the scope of a mobile network.")
  snssai: Snssai;

  @doc("An optional description for this network slice.")
  description?: string;
}
