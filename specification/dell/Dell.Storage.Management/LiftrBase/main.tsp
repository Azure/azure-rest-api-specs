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
   * The 2024-08-28-preview API version.
   */
  v2_preview: "2024-08-28-preview",
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
   * Marketplace subscription status
   */
  @visibility(Lifecycle.Read)
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;
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
