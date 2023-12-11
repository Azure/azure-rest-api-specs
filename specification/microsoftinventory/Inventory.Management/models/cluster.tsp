import "./common.tsp";

@doc("Cluster Properties")
model ClusterProperties {
  @doc("friendly Name")
  friendlyName: string;

  @doc("Is cluster in buildout")
  isClusterInBuildout: boolean;

  @doc("Datacenter Resource Id")
  datacenterId: DatacenterResourceId;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
