import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Qumulo.Storage;

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
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
union ManagedServiceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Storage Sku
   */
  storageSku: string;

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
  publisherId?: string;

  /**
   * Term Unit
   */
  termUnit?: string;

  /**
   * Marketplace subscription status
   */
  @visibility(Lifecycle.Read)
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;
}

/**
 * User Details of Qumulo FileSystem resource
 */
model UserDetails {
  /**
   * User Email
   */
  email: string;
}

/**
 * Managed service identity (system assigned and/or user assigned identities)
 */
model ManagedServiceIdentity {
  /**
   * The service principal ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;

  /**
   * The tenant ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  tenantId?: string;

  /**
   * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
   */
  type: ManagedServiceIdentityType;

  /**
   * The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
}
