import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Qumulo.Storage;

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}
@Azure.Core.fixed
enum MarketplaceSubscriptionStatus {
  @doc("Fulfillment has not started") PendingFulfillmentStart,
  @doc("Marketplace offer is subscribed") Subscribed,
  @doc("Marketplace offer is suspended because of non payment") Suspended,
  @doc("Marketplace offer is unsubscribed") Unsubscribed,
}
@Azure.Core.fixed
enum ProvisioningState {
  @doc("File system resource creation request accepted") Accepted,
  @doc("File system resource creation started") Creating,
  @doc("File system resource is being updated") Updating,
  @doc("File system resource deletion started") Deleting,
  @doc("File system resource creation successful") Succeeded,
  @doc("File system resource creation failed") Failed,
  @doc("File system resource creation canceled") Canceled,
  @doc("File system resource is deleted") Deleted,
  @doc("File system resource state is unknown") NotSpecified,
}
@Azure.Core.fixed
enum StorageSku {
  @doc("Standard Storage Sku") Standard,
  @doc("Performance Storage Sku") Performance,
}

@doc("""
A list of REST API operations supported by an Azure Resource Provider. It
contains an URL link to get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("""
Details of a REST API operation, returned from the Resource Provider Operations
API
""")
model Operation {
  @doc("""
The name of the operation, as per Resource-Based Access Control (RBAC).
Examples: \"Microsoft.Compute/virtualMachines/write\",
\"Microsoft.Compute/virtualMachines/capture/action\"
""")
  @visibility("read")
  name?: string;

  @doc("""
Whether the operation applies to data-plane. This is \"true\" for data-plane
operations and \"false\" for ARM/control-plane operations.
""")
  @visibility("read")
  isDataAction?: boolean;

  @doc("Localized display information for this particular operation.")
  display?: OperationDisplay;

  @doc("""
The intended executor of the operation; as in Resource Based Access Control
(RBAC) and audit logs UX. Default value is \"user,system\"
""")
  @visibility("read")
  origin?: Origin;

  @doc("""
Enum. Indicates the action type. \"Internal\" refers to actions that are for
internal only APIs.
""")
  @visibility("read")
  actionType?: ActionType;
}

@doc("Localized display information for this particular operation.")
model OperationDisplay {
  @doc("""
The localized friendly form of the resource provider name, e.g. \"Microsoft
Monitoring Insights\" or \"Microsoft Compute\".
""")
  @visibility("read")
  provider?: string;

  @doc("""
The localized friendly name of the resource type related to this operation.
E.g. \"Virtual Machines\" or \"Job Schedule Collections\".
""")
  @visibility("read")
  resource?: string;

  @doc("""
The concise, localized friendly name for the operation; suitable for dropdowns.
E.g. \"Create or Update Virtual Machine\", \"Restart Virtual Machine\".
""")
  @visibility("read")
  operation?: string;

  @doc("""
The short, localized friendly description of the operation; suitable for tool
tips and detailed views.
""")
  @visibility("read")
  description?: string;
}

@doc("""
Common error response for all Azure Resource Manager APIs to return error
details for failed operations. (This also follows the OData error response
format.).
""")
@error
model ErrorResponse {
  @doc("The error object.")
  error?: ErrorDetail;
}

@doc("The error detail.")
model ErrorDetail {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: ErrorDetail[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  @visibility("read")
  type?: string;

  @doc("The additional info.")
  @visibility("read")
  info?: unknown;
}

@doc("The response of a FileSystemResource list operation.")
model FileSystemResourceListResult is Azure.Core.Page<FileSystemResource>;

@doc("A FileSystem Resource by Qumulo")
model FileSystemResource {
  ...TrackedResource;

  @doc("The resource-specific properties for this resource.")
  properties: FileSystemResourceProperties;

  @doc("The managed service identities assigned to this resource.")
  identity?: ManagedServiceIdentity;
}

@doc("Properties specific to the Qumulo File System resource")
model FileSystemResourceProperties {
  @doc("Marketplace details")
  marketplaceDetails: MarketplaceDetails;

  @doc("Provisioning State of the resource")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Storage Sku")
  storageSku: StorageSku;

  @doc("User Details")
  userDetails: UserDetails;

  @doc("Delegated subnet id for Vnet injection")
  delegatedSubnetId: string;

  @doc("File system Id of the resource")
  clusterLoginUrl?: string;

  @doc("Private IPs of the resource")
  privateIPs?: string[];

  @doc("Initial administrator password of the resource")
  adminPassword: string;

  @doc("Storage capacity in TB")
  initialCapacity: int32;

  @doc("Availability zone")
  availabilityZone?: string;
}

@doc("MarketplaceDetails of Qumulo FileSystem resource")
model MarketplaceDetails {
  @doc("Marketplace Subscription Id")
  marketplaceSubscriptionId?: string;

  @doc("Plan Id")
  planId: string;

  @doc("Offer Id")
  offerId: string;

  @doc("Publisher Id")
  publisherId: string;

  @doc("Marketplace subscription status")
  @visibility("read")
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;
}

@doc("User Details of Qumulo FileSystem resource")
model UserDetails {
  @doc("User Email")
  email: string;
}

@doc("Managed service identity (system assigned and/or user assigned identities)")
model ManagedServiceIdentity {
  @doc("""
The service principal ID of the system assigned identity. This property will
only be provided for a system assigned identity.
""")
  @visibility("read")
  principalId?: string;

  @doc("""
The tenant ID of the system assigned identity. This property will only be
provided for a system assigned identity.
""")
  @visibility("read")
  tenantId?: string;

  @doc("""
Type of managed service identity (where both SystemAssigned and UserAssigned
types are allowed).
""")
  type: ManagedServiceIdentityType;

  @doc("""
The set of user assigned identities associated with the resource. The
userAssignedIdentities dictionary keys will be ARM resource ids in the form:
'/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}.
The dictionary values can be empty objects ({}) in requests.
""")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

@doc("User assigned identity properties")
model UserAssignedIdentity {
  @doc("The principal ID of the assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client ID of the assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("""
The resource model definition for an Azure Resource Manager tracked top level
resource which has 'tags' and a 'location'
""")
model TrackedResource {
  ...Resource;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  location: string;
}

@doc("""
Common fields that are returned in the response for all Azure Resource Manager
resources
""")
model Resource {
  @doc("""
Fully qualified resource ID for the resource. Ex -
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
""")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("""
The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or
\"Microsoft.Storage/storageAccounts\"
""")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("The type used for update operations of the FileSystemResource.")
model FileSystemResourceUpdate {
  @doc("The managed service identities assigned to this resource.")
  identity?: ManagedServiceIdentity;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The updatable properties of the FileSystemResource.")
  properties?: FileSystemResourceUpdateProperties;
}

@doc("The updatable properties of the FileSystemResource.")
model FileSystemResourceUpdateProperties {
  @doc("Marketplace details")
  marketplaceDetails?: MarketplaceDetails;

  @doc("User Details")
  userDetails?: UserDetails;

  @doc("Delegated subnet id for Vnet injection")
  delegatedSubnetId?: string;

  @doc("File system Id of the resource")
  clusterLoginUrl?: string;

  @doc("Private IPs of the resource")
  privateIPs?: string[];
}
