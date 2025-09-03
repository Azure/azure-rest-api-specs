import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./supercomputer.tsp";

using Rest;
using Azure.ResourceManager;

namespace Microsoft.SupercomputerInfrastructure;

/** A logical cluster within a datacenter. */
@parentResource(Supercomputer)
model Cluster is ProxyResource<ClusterProperties> {
  ...ResourceNameParameter<Cluster>;
}

/** The properties of a cluster. */
model ClusterProperties {
  /** The status of the last operation on this rack. */
  @visibility(Lifecycle.Read)
  provisioningState?: TopologicalProvisioningState;
}

@armResourceOperations
interface Clusters {
  get is ArmResourceRead<Cluster>;
  listBySupercomputer is ArmResourceListByParent<Cluster>;
}
