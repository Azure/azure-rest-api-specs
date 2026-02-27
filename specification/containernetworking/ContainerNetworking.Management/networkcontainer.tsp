import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ContainerNetworking;

/**
 * Network Container properties.
 */
model NetworkContainerProperties {
  @doc("The ID of the network container.")
  networkContainerId: string;

  @doc("Version of the network container schema or definition.")
  version: string;

  @doc("Resource ID of the network.")
  networkId: string;

  @doc("Name of the base subnet associated with the NC.")
  baseSubnetName: string;

  @doc("ID of the associated node.")
  associatedNodeId: string;

  @doc("ID of the associated interface.")
  associatedInterfaceId: string;

  @doc("Type of the container.")
  containerType: string;

  @doc("OrchestratorContext represents the DNC orchestrator context which is passed to the NCRequestV1 as a serialized json message.")
  orchestratorContext?: OrchContext;

  @doc("Resource ID of the infrastructure network.")
  infraNetworkId?: string;

  @doc("Allocated IPv4 subnet for the NC.")
  allocatedIpSubnet?: string;

  @doc("List of secondary IP addresses associated with the NC.")
  secondaryIps?: string[];

  @doc("Base subnet information.")
  baseSubnet?: string;

  @doc("ID of the node interface.")
  nodeInterfaceId?: string;

  @doc("VLAN identifier associated with the NC.")
  vlanId?: int64;

  @doc("Version of the virtual network.")
  vnetVersion?: string;

  @doc("Local IP address associated with the NC.")
  localIp?: string;

  @doc("GRE key for tunneling associated with the NC.")
  greKey?: int64;

  @doc("Type of orchestrator managing the NC.")
  orchestratorType?: string;

  @doc("Routing domain identifier.")
  routingDomainId?: string;

  @doc("IPv6 address of the node interface.")
  nodeInterfaceIpv6?: string;

  @doc("Type of subnet associated with the NC.")
  subnetType?: SubnetType;

  @doc("Type of NIC associated with the NC.")
  nicType?: NICType;

  @doc("Resource ID of the network interface.")
  networkInterfaceId?: string;

  @doc("Resource ID of the subnet.")
  subnetId?: string;

  @doc("MAC address associated with the NC.")
  macAddress?: string;

  @doc("Authentication strategy for the subnet.")
  subnetAuthStrategy?: SubnetAuthStrategy;

  @doc("Whether Availability Zone Redundancy (AZR) is enabled for the NC.")
  azrEnabled?: boolean;

  @doc("Home Availability Zone ID for AZR.")
  azrHomeAzId?: int64;

  @doc("Indicates if SNAT (Source Network Address Translation) is disabled.")
  disableSnat?: boolean;

  @visibility(Lifecycle.Read)
  @doc("Current provisioning state of the NCs Managed by Azure.")
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;
}

/**
 * Orchestrator context for the network container.
 */
model OrchContext {
  @doc("The name of the pod.")
  podName?: string;

  @doc("The namespace of the pod.")
  podNamespace?: string;
}

/**
 * Represents the type of subnet associated with the network container.
 * This is an open enum allowing additional string values.
 */
union SubnetType {
  @doc("Azure Virtual Network")
  SubnetTypeVnet: "AzVnet",

  @doc("Azure Overlay Network")
  SubnetTypeOverlay: "AzOverlay",

  @doc("Azure Virtual Network Block")
  SubnetTypeVnetBlock: "AzVnetBlock",

  string,
}

/**
 * Represents the type of NIC associated with the network container.
 * This is an open enum allowing additional string values.
 */
union NICType {
  @doc("Default NIC type.")
  NICTypeDefault: "Default",

  @doc("SwiftV2 NIC type.")
  NICTypeSwiftV2: "SwiftV2",

  string,
}

/**
 * Represents the authentication strategy for the subnet.
 * This is an open enum allowing additional string values.
 */
union SubnetAuthStrategy {
  @doc("TokenMatching strategy: DNC will match the provided auth token with the token in pubsub to ensure this orchestrator can use the customer subnet.")
  SubnetAuthStrategyTokenMatching: "token matching",

  @doc("ServiceMatching strategy: DNC will match the infra vnet's service name with the subnet's delegation to authenticate that the infra vnet can use this subnet.")
  SubnetAuthStrategyServiceMatching: "service matching",

  string,
}
/**
 * A network container resource.
 */
@parentResource(TenantLocationResource)
model NetworkContainer
  is Azure.ResourceManager.ProxyResource<NetworkContainerProperties> {
  @doc("The ID of the network container.")
  @segment("networkContainers")
  @key("networkContainerId")
  @visibility(Lifecycle.Read)
  @pattern("^[A-Za-z0-9\\-]+$")
  @path
  name: string;
}

/**
 * Network container operations
 */
@armResourceOperations
interface NetworkContainers {
  /** Get the specified network container */
  get is ArmResourceRead<NetworkContainer>;

  /** List all network containers in the location */
  list is ArmResourceListByParent<NetworkContainer>;
}
