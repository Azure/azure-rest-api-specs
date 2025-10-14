import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./rack.tsp";
import "./node.tsp";
import "./switch.tsp";

using Rest;
using Azure.ResourceManager;

namespace Microsoft.SupercomputerInfrastructure;

/** A logical port that resides on a device in the network. */
@parentResource(Supercomputer)
model DeviceLogicalPort is ProxyResource<DeviceLogicalPortProperties> {
  ...ResourceNameParameter<DeviceLogicalPort>;
}

/** The properties of a logical port. */
model DeviceLogicalPortProperties {
  /** The status of the last operation on this port. */
  @visibility(Lifecycle.Read)
  provisioningState?: TopologicalProvisioningState;

  /** The bus:device:function of the port. */
  @visibility(Lifecycle.Read)
  busDeviceFunction?: string;

  /** The Azure resource ID of the device (e.g., NIC or Switch) this port resides on. */
  @visibility(Lifecycle.Read)
  deviceId?: DeviceResourceId;

  /** The MAC address of the port. */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /** The port's name on the device (e.g., Ethernet 1/1). */
  @visibility(Lifecycle.Read)
  nameOnDevice?: string;

  /** The Azure resource ID of the link that the port is interfaced with. */
  @visibility(Lifecycle.Read)
  linkId?: LinkResourceId;

  /** The Azure resource ID of the cluster that the port is associated with, if any. */
  @visibility(Lifecycle.Read)
  clusterId?: ClusterResourceId;
}

@armResourceOperations
interface DeviceLogicalPorts {
  get is ArmResourceRead<DeviceLogicalPort>;
  listBySupercomputer is ArmResourceListByParent<DeviceLogicalPort>;
}
