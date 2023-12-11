import "./common.tsp";

@doc("Azure Host Properties")
model AzureHostProperties {
  @doc("Node Id")
  nodeId: string;

  @doc("Cluster Id")
  clusterId: ClusterResourceId;

  @doc("Physical server Id")
  serverId: ServerResourceId;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
