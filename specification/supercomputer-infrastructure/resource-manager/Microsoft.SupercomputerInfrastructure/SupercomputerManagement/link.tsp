import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./supercomputer.tsp";

using Rest;
using Azure.ResourceManager;

namespace Microsoft.SupercomputerInfrastructure;

/** A network link between two devices within a datacenter. */
@parentResource(Supercomputer)
model Link is ProxyResource<LinkProperties> {
  ...ResourceNameParameter<Link>;
}

/** The properties of a link. */
model LinkProperties {
  /** The status of the last operation on this link */
  @visibility(Lifecycle.Read)
  provisioningState?: TopologicalProvisioningState;

  /** The Azure resource ID of the first device connected via this network link. */
  @visibility(Lifecycle.Read)
  deviceOneId: DeviceResourceId;

  /** The Azure resource ID of the port that this network link is connected to the first device. */
  @visibility(Lifecycle.Read)
  deviceLogicalPortOneId?: DeviceLogicalPortResourceId;

  /** The Azure resource ID of the second device connected via this network link. */
  @visibility(Lifecycle.Read)
  deviceTwoId?: DeviceResourceId;

  /** The Azure resource ID of the port that this network link is connected to the second device. */
  @visibility(Lifecycle.Read)
  deviceLogicalPortTwoId?: DeviceLogicalPortResourceId;

  /** The ID of the plane that this link is associated with. */
  @visibility(Lifecycle.Read)
  planeId?: string;

  /** The Azure resource ID of the cluster that the rack is associated with, if any. */
  @visibility(Lifecycle.Read)
  clusterId?: ClusterResourceId;
}

@armResourceOperations
interface Links {
  get is ArmResourceRead<Link>;
  listBySupercomputer is ArmResourceListByParent<Link>;
}
