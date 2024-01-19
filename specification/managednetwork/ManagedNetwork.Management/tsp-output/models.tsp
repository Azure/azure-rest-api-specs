import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ManagedNetwork;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning state of the ManagedNetwork resource.")
enum ProvisioningState {
  Updating,
  Deleting,
  Failed,
  Succeeded,
}

@doc("Responsibility role under which this Managed Network Group will be created")
enum Kind {
  Connectivity,
}

@doc("Gets or sets the connectivity type of a network structure policy")
enum ConnectivityType {
  HubAndSpokeTopology,
  MeshTopology,
}

@doc("Properties of Managed Network")
model ManagedNetworkProperties extends ResourceProperties {
  @doc("The collection of management groups, subscriptions, virtual networks, and subnets by the Managed Network. This is a read-only property that is reflective of all ScopeAssignments for this Managed Network")
  scope?: Scope;

  @doc("The collection of groups and policies concerned with connectivity")
  @visibility("read")
  connectivity?: ConnectivityCollection;
}

@doc("Scope of a Managed Network")
model Scope {
  @doc("The collection of management groups covered by the Managed Network")
  managementGroups?: ResourceId[];

  @doc("The collection of subscriptions covered by the Managed Network")
  subscriptions?: ResourceId[];

  @doc("The collection of virtual nets covered by the Managed Network")
  virtualNetworks?: ResourceId[];

  @doc("The collection of  subnets covered by the Managed Network")
  subnets?: ResourceId[];
}

@doc("Generic pointer to a resource")
model ResourceId {
  @doc("Resource Id")
  id?: string;
}

@doc("The collection of Connectivity related groups and policies within the Managed Network")
model ConnectivityCollection {
  @doc("The collection of connectivity related Managed Network Groups within the Managed Network")
  @visibility("read")
  groups?: ManagedNetworkGroup[];

  @doc("The collection of Managed Network Peering Policies within the Managed Network")
  @visibility("read")
  peerings?: ManagedNetworkPeeringPolicy[];
}

@doc("Properties of a Managed Network Group")
model ManagedNetworkGroupProperties extends ResourceProperties {
  @doc("The collection of management groups covered by the Managed Network")
  managementGroups?: ResourceId[];

  @doc("The collection of subscriptions covered by the Managed Network")
  subscriptions?: ResourceId[];

  @doc("The collection of virtual nets covered by the Managed Network")
  virtualNetworks?: ResourceId[];

  @doc("The collection of  subnets covered by the Managed Network")
  subnets?: ResourceId[];
}

@doc("Base for resource properties.")
model ResourceProperties {
  @doc("Provisioning state of the ManagedNetwork resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;
}

@doc("The general resource model definition")
model Resource {
  @doc("Fully qualified resource Id for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. Ex- Microsoft.Compute/virtualMachines or Microsoft.Storage/storageAccounts.")
  @visibility("read")
  type?: string;

  @doc("The geo-location where the resource lives")
  @visibility("read", "create")
  location?: string;
}

@doc("Properties of a Managed Network Peering Policy")
model ManagedNetworkPeeringPolicyProperties extends ResourceProperties {
  @doc("Gets or sets the connectivity type of a network structure policy")
  @projectedName("json", "type")
  connectivityType: ConnectivityType;

  @doc("Gets or sets the hub virtual network ID")
  hub?: ResourceId;

  @doc("Gets or sets the spokes group IDs")
  spokes?: ResourceId[];

  @doc("Gets or sets the mesh group IDs")
  mesh?: ResourceId[];
}

@doc("Update Tags of Managed Network")
model ManagedNetworkUpdate {
  @doc("Resource tags")
  @visibility("read", "create", "update")
  tags?: Record<string>;
}

@doc("Properties of Managed Network")
model ScopeAssignmentProperties extends ResourceProperties {
  @doc("The managed network ID with scope will be assigned to.")
  assignedManagedNetwork?: string;
}

@doc("Properties of a Hub and Spoke Peering Policy")
model HubAndSpokePeeringPolicyProperties
  extends ManagedNetworkPeeringPolicyProperties {}

@doc("Properties of a Mesh Peering Policy")
model MeshPeeringPolicyProperties
  extends ManagedNetworkPeeringPolicyProperties {}
