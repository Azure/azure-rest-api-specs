import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.Qumulo;

interface Operations extends Azure.ResourceManager.Operations {}

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
  email?: string;
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
