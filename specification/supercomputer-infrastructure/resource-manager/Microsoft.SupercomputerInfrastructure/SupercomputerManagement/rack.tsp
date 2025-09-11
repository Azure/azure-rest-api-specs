import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./cluster.tsp";

using Rest;
using Azure.ResourceManager;

namespace Microsoft.SupercomputerInfrastructure;

/** A rack within a datacenter. */
@parentResource(Supercomputer)
model Rack is ProxyResource<RackProperties> {
  ...ResourceNameParameter<Rack>;
}

/** The properties of a rack. */
model RackProperties {
  /** The status of the last operation on this rack. */
  @visibility(Lifecycle.Read)
  provisioningState?: TopologicalProvisioningState;

  /** The Azure resource ID of the cluster that the rack is associated with, if any. */
  @visibility(Lifecycle.Read)
  clusterId?: ClusterResourceId;
}

@armResourceOperations
interface Racks {
  get is ArmResourceRead<Rack>;
  listBySupercomputer is ArmResourceListByParent<Rack>;
}
