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

/** A port that resides on a device in the network. */
@parentResource(Supercomputer)
model Port is ProxyResource<PortProperties> {
  ...ResourceNameParameter<Port>;
}

/** The properties of a port. */
model PortProperties {
  /** The status of the last operation on this port. */
  @visibility(Lifecycle.Read)
  provisioningState?: TopologicalProvisioningState;

  /** The device this port resides on. */
  device: string;

  /** The port's name on the device. */
  nameOnDevice: string;

  /** The link that the port is interfaced with. */
  link?: string;

  /** The cluster that the port is associated with, if any. */
  clusterId?: string;
}

@armResourceOperations
interface Ports {
  get is ArmResourceRead<Port>;
  listBySupercomputer is ArmResourceListByParent<Port>;
}
