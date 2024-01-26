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

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

/**
 * Marketplace subscription status of the file system resource
 */
@fixed
enum MarketplaceSubscriptionStatus {
  /**
   * Fulfillment has not started
   */
  PendingFulfillmentStart,

  /**
   * Marketplace offer is subscribed
   */
  Subscribed,

  /**
   * Marketplace offer is suspended because of non payment
   */
  Suspended,

  /**
   * Marketplace offer is unsubscribed
   */
  Unsubscribed,
}

/**
 * Provisioning State of the File system resource
 */
@fixed
enum ProvisioningState {
  /**
   * File system resource creation request accepted
   */
  Accepted,

  /**
   * File system resource creation started
   */
  Creating,

  /**
   * File system resource is being updated
   */
  Updating,

  /**
   * File system resource deletion started
   */
  Deleting,

  /**
   * File system resource creation successful
   */
  Succeeded,

  /**
   * File system resource creation failed
   */
  Failed,

  /**
   * File system resource creation canceled
   */
  Canceled,

  /**
   * File system resource is deleted
   */
  Deleted,

  /**
   * File system resource state is unknown
   */
  NotSpecified,
}

/**
 * Storage Sku
 */
@fixed
enum StorageSku {
  /**
   * Standard Storage Sku
   */
  Standard,

  /**
   * Performance Storage Sku
   */
  Performance,
}

/**
 * Properties specific to the Qumulo File System resource
 */
model FileSystemResourceProperties {
  /**
   * Marketplace details
   */
  marketplaceDetails: MarketplaceDetails;

  /**
   * Provisioning State of the resource
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Storage Sku
   */
  storageSku: StorageSku;

  /**
   * User Details
   */
  userDetails: UserDetails;

  /**
   * Delegated subnet id for Vnet injection
   */
  delegatedSubnetId: string;

  /**
   * File system Id of the resource
   */
  clusterLoginUrl?: string;

  /**
   * Private IPs of the resource
   */
  privateIPs?: string[];

  /**
   * Initial administrator password of the resource
   */
  adminPassword: string;

  /**
   * Storage capacity in TB
   */
  initialCapacity: int32;

  /**
   * Availability zone
   */
  availabilityZone?: string;
}

/**
 * MarketplaceDetails of Qumulo FileSystem resource
 */
model MarketplaceDetails {
  /**
   * Marketplace Subscription Id
   */
  marketplaceSubscriptionId?: string;

  /**
   * Plan Id
   */
  planId: string;

  /**
   * Offer Id
   */
  offerId: string;

  /**
   * Publisher Id
   */
  publisherId: string;

  /**
   * Marketplace subscription status
   */
  @visibility("read")
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;
}

/**
 * User Details of Qumulo FileSystem resource
 */
model UserDetails {
  /**
   * User Email
   */
  email?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The type used for update operations of the FileSystemResource.
 */
model FileSystemResourceUpdate {
  /**
   * The managed service identities assigned to this resource.
   */
  identity?: ManagedServiceIdentity;

  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * The updatable properties of the FileSystemResource.
   */
  properties?: FileSystemResourceUpdateProperties;
}

/**
 * The updatable properties of the FileSystemResource.
 */
model FileSystemResourceUpdateProperties {
  /**
   * Marketplace details
   */
  marketplaceDetails?: MarketplaceDetails;

  /**
   * User Details
   */
  userDetails?: UserDetails;

  /**
   * Delegated subnet id for Vnet injection
   */
  delegatedSubnetId?: string;

  /**
   * File system Id of the resource
   */
  clusterLoginUrl?: string;

  /**
   * Private IPs of the resource
   */
  privateIPs?: string[];
}
