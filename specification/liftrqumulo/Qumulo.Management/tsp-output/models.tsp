import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Qumulo.Storage;

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
@fixed
enum MarketplaceSubscriptionStatus {
  @doc("Fulfillment has not started") PendingFulfillmentStart,
  @doc("Marketplace offer is subscribed") Subscribed,
  @doc("Marketplace offer is suspended because of non payment") Suspended,
  @doc("Marketplace offer is unsubscribed") Unsubscribed,
}
@fixed
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
@fixed
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

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
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
