import "@typespec/versioning";
import "@typespec/openapi";

using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

@versioned(LiftrBase.Versions)
namespace LiftrBase;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2025-03-21-preview API version.
   */
  v2_preview: "2025-03-21-preview",
}

/**
 * Marketplace subscription status of the file system resource
 */
union MarketplaceSubscriptionStatus {
  string,

  /**
   * Fulfillment has not started
   */
  PendingFulfillmentStart: "PendingFulfillmentStart",

  /**
   * Marketplace offer is subscribed
   */
  Subscribed: "Subscribed",

  /**
   * Marketplace offer is suspended because of non payment
   */
  Suspended: "Suspended",

  /**
   * Marketplace offer is unsubscribed
   */
  Unsubscribed: "Unsubscribed",
}

/**
 * Provisioning State of the File system resource
 */
union ProvisioningState {
  string,

  /**
   * File system resource creation request accepted
   */
  Accepted: "Accepted",

  /**
   * File system resource creation started
   */
  Creating: "Creating",

  /**
   * File system resource is being updated
   */
  Updating: "Updating",

  /**
   * File system resource deletion started
   */
  Deleting: "Deleting",

  /**
   * File system resource creation successful
   */
  Succeeded: "Succeeded",

  /**
   * File system resource creation failed
   */
  Failed: "Failed",

  /**
   * File system resource creation canceled
   */
  Canceled: "Canceled",

  /**
   * File system resource is deleted
   */
  Deleted: "Deleted",

  /**
   * File system resource state is unknown
   */
  NotSpecified: "NotSpecified",
}

/**
 * MarketplaceDetails of Dell FileSystem resource
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
  publisherId?: string;

  /**
   * Private Offer Id
   */
  privateOfferId?: string;

  /**
   * Plan Name
   */
  planName: string;

  /**
   * Marketplace subscription status
   */
  @visibility(Lifecycle.Read)
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;

  /**
   * End Date of the subscription
   */
  endDate?: string;

  /**
   * Term Unit
   */
  termUnit?: string;
}

/**
 * Identity type of ManagedIdentity Associated with Dell FileSystem resource
 */
union ResourceEncryptionType {
  string,

  /**
   * Microsoft managed keys (Default)
   */
  `Microsoft-managed keys (MMK)`: "Microsoft-managed keys (MMK)",

  /**
   * Customer managed keys
   * (CMK) - Only UserAssigned identity is supported
   */
  `Customer-managed keys (CMK)`: "Customer-managed keys (CMK)",
}

/**
 * Identity type of ManagedIdentity Associated with Dell FileSystem resource
 */
union EncryptionIdentityType {
  string,

  /**
   * System Assigned Managed identity
   */
  SystemAssigned: "SystemAssigned",

  /**
   * User Assigned managed identity
   */
  UserAssigned: "UserAssigned",
}

/**
 * EncryptionIdentityProperties of Dell FileSystem resource
 */
model EncryptionIdentityProperties {
  /**
   * Identity type - SystemAssigned/UserAssigned - Only UserAssigned is supported now
   */
  identityType?: EncryptionIdentityType;

  /**
   * User-assigned identity resource id - Only when user opts for UserAssigned identity and hence optional
   */
  identityResourceId?: string;
}

/**
 * EncryptionIdentityUpdateProperties of Dell FileSystem resource
 */
model EncryptionIdentityUpdateProperties {
  /**
   * Identity type - SystemAssigned/UserAssigned - Only UserAssigned is supported now
   */
  identityType?: EncryptionIdentityType;

  /**
   * User-assigned identity resource id - Only when user opts for UserAssigned identity and hence optional
   */
  identityResourceId?: string;
}

/**
 * EncryptionProperties of Dell FileSystem resource
 */
model EncryptionProperties {
  /**
   * Encryption Type - MMK/CMK
   */
  encryptionType: ResourceEncryptionType;

  /**
   * Versioned Encryption Key Url - Only when user opts for CMK and hence optional
   */
  keyUrl?: string;

  /**
   * Identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault - Only when user opts for CMK and hence optional
   */
  encryptionIdentityProperties?: EncryptionIdentityProperties;
}

/**
 * EncryptionUpdateProperties of Dell FileSystem resource
 */
model EncryptionUpdateProperties {
  /**
   * Encryption Type - MMK/CMK
   */
  encryptionType?: ResourceEncryptionType;

  /**
   * Versioned Encryption Key Url - Only when user opts for CMK and hence optional
   */
  keyUrl?: string;

  /**
   * Identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault - Only when user opts for CMK and hence optional
   */
  encryptionIdentityProperties?: EncryptionIdentityUpdateProperties;
}

/**
 * User Details of Dell FileSystem resource
 */
model UserDetails {
  /**
   * User Email
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "This needs to be a secret"
  @extension("x-ms-secret", true)
  email: string;
}
