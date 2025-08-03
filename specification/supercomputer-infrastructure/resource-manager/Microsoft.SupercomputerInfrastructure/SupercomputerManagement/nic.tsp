import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./rack.tsp";

using Rest;
using Azure.ResourceManager;

namespace Microsoft.SupercomputerInfrastructure;

/** A NIC (Network Interface Card) within a rack. */
@parentResource(Rack)
model Nic is ProxyResource<NicProperties> {
  ...ResourceNameParameter<Nic>;
}

/** The properties of a NIC. */
model NicProperties {
  /** The status of the last operation on this NIC. */
  @visibility(Lifecycle.Read)
  provisioningState?: TopologicalProvisioningState;

  /** The ID of the device that the NIC resides within. */
  parentDeviceId: string;
}

@armResourceOperations
interface Nics {
  get is ArmResourceRead<Nic>;
  listByRack is ArmResourceListByParent<Nic>;
}
