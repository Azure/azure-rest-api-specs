import "@typespec/openapi";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility. The resource Ues is for retrieving the information of the resources only."
@doc("Basic UE Information Properties.")
model UeInfoPropertiesFormat {
  @doc("RAT Type")
  ratType: RatType;

  @doc("State of the UE.")
  ueState: UeState;

  @doc("List of DNN and UE IP addresses.")
  @minItems(1)
  @extension("x-ms-identifiers", [])
  ueIpAddresses?: DnnIpPair[];

  @doc("The timestamp of last list UEs call to the packet core (UTC).")
  lastReadAt?: utcDateTime;
}

@doc("DNN and UE IP address")
model DnnIpPair {
  @doc("Data network name")
  dnn?: Dnn;

  @doc("UE IP address")
  ueIpAddress?: UeIpAddress;
}
