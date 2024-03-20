import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Edge;

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
enum ManagedServiceIdentityType {
  /**
 * None.
 */
  None,

  /**
 * SystemAssigned.
 */
  SystemAssigned,

 /**
 * UserAssigned.
 */
  UserAssigned,

   /**
 * SystemAssigned,UserAssigned.
 */
  `SystemAssigned,UserAssigned`,
}

/**
 * Distinguishes whether RP is already supported or coming soon.
 */
enum AvailabilityStatus {
  /**
   * RP is coming soon
   */
  ComingSoon,

  /**
   * RP is already supported
   */
  Supported,
}

/**
 * Site properties
 */
model SiteProperties {
  /**
   * Friendly name of site
   */
  displayName?: string;

  /**
   * Description of site
   */
  description?: string;

  /**
   * AddressResourceId for site
   */
  addressResourceId?: ResourceIdentifier<[
    {
      type: "Microsoft.EdgeOrder/addresses";
    }
  ]>;

  /**
   * The status of the last operation.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: ResourceIdentifier;

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
 * The type used for update operations of the Site.
 */
model SiteUpdate {
  /**
   * Identity of Sites resource
   */
  @extension("x-ms-client-flatten", true)
  identity?: ManagedServiceIdentity;

  /**
   * The updatable properties of the Site.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SiteUpdateProperties;
}

/**
 * The updatable properties of the Site.
 */
model SiteUpdateProperties {
  /**
   * Friendly name of site
   */
  displayName?: string;

  /**
   * Description of site
   */
  description?: string;

  /**
   * AddressResourceId for site
   */
  addressResourceId?: ResourceIdentifier<[
    {
      type: "Microsoft.EdgeOrder/addresses";
    }
  ]>;
}

/**
 * Properties of the SiteAwareResourceTypes resource type.
 */
model SiteAwareResourceTypesProperties {
  /**
   * Details for each SiteAwareResourceType
   */
  supportedResourceTypes?: SiteAwareResourceTypesDetails[];

  /**
   * The status of the last operation.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The properties and availability status of each resource type which recognizes Sites as an aggregation concept.
 */
model SiteAwareResourceTypesDetails {
  /**
   * Name to be displayed on portal.
   */
  @visibility("read")
  displayName?: string;

  /**
   * Fully qualified name of the resource type.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * Distinguishes whether RP is already supported or coming soon.
   */
  @visibility("read")
  availabilityStatus?: AvailabilityStatus;

  /**
   * Aggregation properties which are currently supported.
   */
  @visibility("read")
  supportedCapabilities?: string[];
}
