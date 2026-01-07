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
  /** The SKU of the physical NIC hardware. */
  @visibility(Lifecycle.Read)
  hardwareSku?: string;

  /** The MAC address of the NIC. */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /** The Azure resource ID of the device that the NIC resides within. */
  @visibility(Lifecycle.Read)
  parentDeviceId?: NodeResourceId;

  /** The bus:device:function of the NIC. */
  @visibility(Lifecycle.Read)
  busDeviceFunction?: string;

  /** The status of the last operation on this NIC. */
  @visibility(Lifecycle.Read)
  provisioningState?: TopologicalProvisioningState;
}

@armResourceOperations
interface Nics {
  get is ArmResourceRead<Nic>;
  listByRack is ArmResourceListByParent<Nic>;
}
