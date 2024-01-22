import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ManagedNetwork;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Provisioning state of the ManagedNetwork resource.
 */
enum ProvisioningState {
  Updating,
  Deleting,
  Failed,
  Succeeded,
}

/**
 * Responsibility role under which this Managed Network Group will be created
 */
enum Kind {
  Connectivity,
}

/**
 * Gets or sets the connectivity type of a network structure policy
 */
enum ConnectivityType {
  HubAndSpokeTopology,
  MeshTopology,
}

/**
 * Properties of Managed Network
 */
model ManagedNetworkProperties extends ResourceProperties {
  /**
   * The collection of management groups, subscriptions, virtual networks, and subnets by the Managed Network. This is a read-only property that is reflective of all ScopeAssignments for this Managed Network
   */
  scope?: Scope;

  /**
   * The collection of groups and policies concerned with connectivity
   */
  @visibility("read")
  connectivity?: ConnectivityCollection;
}

/**
 * Scope of a Managed Network
 */
model Scope {
  /**
   * The collection of management groups covered by the Managed Network
   */
  managementGroups?: ResourceId[];

  /**
   * The collection of subscriptions covered by the Managed Network
   */
  subscriptions?: ResourceId[];

  /**
   * The collection of virtual nets covered by the Managed Network
   */
  virtualNetworks?: ResourceId[];

  /**
   * The collection of  subnets covered by the Managed Network
   */
  subnets?: ResourceId[];
}

/**
 * Generic pointer to a resource
 */
model ResourceId {
  /**
   * Resource Id
   */
  id?: string;
}

/**
 * The collection of Connectivity related groups and policies within the Managed Network
 */
model ConnectivityCollection {
  /**
   * The collection of connectivity related Managed Network Groups within the Managed Network
   */
  @visibility("read")
  groups?: ManagedNetworkGroup[];

  /**
   * The collection of Managed Network Peering Policies within the Managed Network
   */
  @visibility("read")
  peerings?: ManagedNetworkPeeringPolicy[];
}

/**
 * Properties of a Managed Network Group
 */
model ManagedNetworkGroupProperties extends ResourceProperties {
  /**
   * The collection of management groups covered by the Managed Network
   */
  managementGroups?: ResourceId[];

  /**
   * The collection of subscriptions covered by the Managed Network
   */
  subscriptions?: ResourceId[];

  /**
   * The collection of virtual nets covered by the Managed Network
   */
  virtualNetworks?: ResourceId[];

  /**
   * The collection of  subnets covered by the Managed Network
   */
  subnets?: ResourceId[];
}

/**
 * Base for resource properties.
 */
model ResourceProperties {
  /**
   * Provisioning state of the ManagedNetwork resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility("read")
  etag?: string;
}

/**
 * The general resource model definition
 */
model Resource {
  /**
   * Fully qualified resource Id for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. Ex- Microsoft.Compute/virtualMachines or Microsoft.Storage/storageAccounts.
   */
  @visibility("read")
  type?: string;

  /**
   * The geo-location where the resource lives
   */
  @visibility("read", "create")
  location?: string;
}

/**
 * Properties of a Managed Network Peering Policy
 */
model ManagedNetworkPeeringPolicyProperties extends ResourceProperties {
  /**
   * Gets or sets the connectivity type of a network structure policy
   */
  @projectedName("json", "type")
  connectivityType: ConnectivityType;

  /**
   * Gets or sets the hub virtual network ID
   */
  hub?: ResourceId;

  /**
   * Gets or sets the spokes group IDs
   */
  spokes?: ResourceId[];

  /**
   * Gets or sets the mesh group IDs
   */
  mesh?: ResourceId[];
}

/**
 * Update Tags of Managed Network
 */
model ManagedNetworkUpdate {
  /**
   * Resource tags
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;
}

/**
 * Properties of Managed Network
 */
model ScopeAssignmentProperties extends ResourceProperties {
  /**
   * The managed network ID with scope will be assigned to.
   */
  assignedManagedNetwork?: string;
}

/**
 * Properties of a Hub and Spoke Peering Policy
 */
model HubAndSpokePeeringPolicyProperties
  extends ManagedNetworkPeeringPolicyProperties {}

/**
 * Properties of a Mesh Peering Policy
 */
model MeshPeeringPolicyProperties
  extends ManagedNetworkPeeringPolicyProperties {}
