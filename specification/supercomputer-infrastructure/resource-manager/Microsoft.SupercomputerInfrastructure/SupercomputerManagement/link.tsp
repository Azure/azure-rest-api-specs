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

  /** The ARM resource ID of the first device connected via this network link. */
  deviceOneId: string;

  /** The ARM resource ID of the port that this network link is connected to the first device. */
  portOneId: string;

  /** The ARM resource ID of the second device connected via this network link. */
  deviceTwoId: string;

  /** The ARM resource ID of the port that this network link is connected to the second device. */
  portTwoId: string;

  /** The ID of the plane that this link is associated with. */
  planeId: string;

  /** The cluster that the link is associated with, if any. */
  clusterId?: string;
}

@armResourceOperations
interface Links {
  get is ArmResourceRead<Link>;
  listBySupercomputer is ArmResourceListByParent<Link>;
}
