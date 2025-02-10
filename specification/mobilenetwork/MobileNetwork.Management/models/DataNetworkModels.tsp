import "../common/CommonModels.tsp";

namespace Microsoft.MobileNetwork;

@doc("Data network properties.")
model DataNetworkPropertiesFormat {
  @doc("The provisioning state of the data network resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("An optional description for this data network.")
  description?: string;
}
