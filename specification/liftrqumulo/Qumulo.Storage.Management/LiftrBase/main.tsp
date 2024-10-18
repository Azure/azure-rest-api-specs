import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Reflection;
using TypeSpec.OpenAPI;

@versioned(LiftrBase.Versions)
namespace LiftrBase;

@doc("Supported versions for LiftrBase resource model")
enum Versions {
  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  v2_preview: "2024-02-01-preview",
}

/**
 * Marketplace subscription status of the file system resource
 */
union MarketplaceSubscriptionStatus {
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

  string,
}

@doc("MarketplaceDetails of Qumulo FileSystem resource")
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
   * Term Unit
   */
  termUnit?: string;

  /**
   * Marketplace subscription status
   */
  @visibility("read")
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;
}

@doc("User Details of Qumulo FileSystem resource")
model UserDetails {
  /**
   * User Email
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Legacy"
  @extension("x-ms-secret", true)
  email: string;
}

/**
 * Provisioning State of the File system resource
 */
union ProvisioningState {
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

  string,
}
