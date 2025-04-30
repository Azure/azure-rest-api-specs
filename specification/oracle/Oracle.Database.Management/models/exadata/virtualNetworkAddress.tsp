import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Oracle.Database;

// https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/ApplicationVip/

@doc("VirtualNetworkAddressLifecycleState enum")
union VirtualNetworkAddressLifecycleState {
  @doc("Indicates that resource in Provisioning state")
  Provisioning: "Provisioning",

  @doc("Indicates that resource in Available state")
  Available: "Available",

  @doc("Indicates that resource in Terminating state")
  Terminating: "Terminating",

  @doc("Indicates that resource in Terminated state")
  Terminated: "Terminated",

  @doc("Indicates that resource in Failed state")
  Failed: "Failed",

  string,
}

@doc("Virtual IP resource belonging to a vm cluster resource.")
@parentResource(CloudVmCluster)
model VirtualNetworkAddress is ProxyResource<VirtualNetworkAddressProperties> {
  @doc("Virtual IP address hostname.")
  @key("virtualnetworkaddressname")
  @path
  @segment("virtualNetworkAddresses")
  @minLength(1)
  @maxLength(63)
  @pattern(".*")
  name: string;
}

@doc("virtualNetworkAddress resource properties")
model VirtualNetworkAddressProperties {
  @doc("Virtual network Address address.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  ipAddress?: string;

  @doc("Virtual Machine OCID.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  vmOcid?: Ocid;

  @doc("Application VIP OCID.")
  @visibility(Lifecycle.Read)
  ocid?: Ocid;

  @doc("Virtual network address fully qualified domain name.")
  @visibility(Lifecycle.Read)
  domain?: string;

  @doc("Additional information about the current lifecycle state of the application virtual IP (VIP) address.")
  @visibility(Lifecycle.Read)
  lifecycleDetails?: string;

  //Subnet should be retrieved from the VM Cluster
  // @doc("Client subnet")
  //@visibility(Lifecycle.Create, Lifecycle.Read)
  // subnetId?: SubnetId;

  @doc("Azure resource provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;

  @doc("virtual network address lifecycle state.")
  @visibility(Lifecycle.Read)
  lifecycleState?: VirtualNetworkAddressLifecycleState;

  @doc("The date and time when the create operation for the application virtual IP (VIP) address completed.")
  @visibility(Lifecycle.Read)
  timeAssigned?: utcDateTime;
}
