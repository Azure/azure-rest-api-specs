import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Resources;

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,

  /**
   * user
   */
  user: "user",

  /**
   * system
   */
  system: "system",

  /**
   * user,system
   */
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,

  /**
   * Internal
   */
  Internal: "Internal",
}

/**
 * The type of the region.
 */
union RegionType {
  string,

  /**
   * Physical
   */
  Physical: "Physical",

  /**
   * Logical
   */
  Logical: "Logical",
}

/**
 * The category of the region.
 */
union RegionCategory {
  string,

  /**
   * Recommended
   */
  Recommended: "Recommended",

  /**
   * Extended
   */
  Extended: "Extended",

  /**
   * Other
   */
  Other: "Other",
}

/**
 * Is the resource name Allowed or Reserved
 */
union ResourceNameStatus {
  string,

  /**
   * Allowed
   */
  Allowed: "Allowed",

  /**
   * Reserved
   */
  Reserved: "Reserved",
}

/**
 * The location type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum LocationType {
  /**
   * Region
   */
  Region,

  /**
   * EdgeZone
   */
  EdgeZone,
}

/**
 * The subscription state. Possible values are Enabled, Warned, PastDue, Disabled, and Deleted.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum SubscriptionState {
  /**
   * Enabled
   */
  Enabled,

  /**
   * Warned
   */
  Warned,

  /**
   * PastDue
   */
  PastDue,

  /**
   * Disabled
   */
  Disabled,

  /**
   * Deleted
   */
  Deleted,
}

/**
 * The subscription spending limit.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum SpendingLimit {
  /**
   * On
   */
  On,

  /**
   * Off
   */
  Off,

  /**
   * CurrentPeriodOff
   */
  CurrentPeriodOff,
}

/**
 * Category of the tenant.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum TenantCategory {
  /**
   * Home
   */
  Home,

  /**
   * ProjectedBy
   */
  ProjectedBy,

  /**
   * ManagedBy
   */
  ManagedBy,
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * An error response for a resource management request.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
   */
  error?: Azure.ResourceManager.CommonTypes.ErrorResponse;
}

/**
 * Location list operation response.
 */
model LocationListResult {
  /**
   * An array of locations.
   */
  @pageItems
  value?: Location[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Location information.
 */
model Location {
  /**
   * The fully qualified ID of the location. For example, /subscriptions/8d65815f-a5b6-402f-9298-045155da7d74/locations/westus.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The subscription ID.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * The location name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The location type.
   */
  @visibility(Lifecycle.Read)
  type?: LocationType;

  /**
   * The display name of the location.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The display name of the location and its region.
   */
  @visibility(Lifecycle.Read)
  regionalDisplayName?: string;

  /**
   * Metadata of the location, such as lat/long, paired region, and others.
   */
  metadata?: LocationMetadata;

  /**
   * The availability zone mappings for this region.
   */
  @identifiers(#[])
  availabilityZoneMappings?: AvailabilityZoneMappings[];
}

/**
 * Location metadata information
 */
model LocationMetadata {
  /**
   * The type of the region.
   */
  @visibility(Lifecycle.Read)
  regionType?: RegionType;

  /**
   * The category of the region.
   */
  @visibility(Lifecycle.Read)
  regionCategory?: RegionCategory;

  /**
   * The geography of the location.
   */
  @visibility(Lifecycle.Read)
  geography?: string;

  /**
   * The geography group of the location.
   */
  @visibility(Lifecycle.Read)
  geographyGroup?: string;

  /**
   * The longitude of the location.
   */
  @visibility(Lifecycle.Read)
  longitude?: string;

  /**
   * The latitude of the location.
   */
  @visibility(Lifecycle.Read)
  latitude?: string;

  /**
   * The physical location of the Azure location.
   */
  @visibility(Lifecycle.Read)
  physicalLocation?: string;

  /**
   * The regions paired to this region.
   */
  pairedRegion?: PairedRegion[];

  /**
   * The home location of an edge zone.
   */
  @visibility(Lifecycle.Read)
  homeLocation?: string;
}

/**
 * Information regarding paired region.
 */
model PairedRegion {
  /**
   * The name of the paired region.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The fully qualified ID of the location. For example, /subscriptions/8d65815f-a5b6-402f-9298-045155da7d74/locations/westus.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The subscription ID.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;
}

/**
 * Availability zone mappings for the region
 */
model AvailabilityZoneMappings {
  /**
   * The logical zone id for the availability zone
   */
  @visibility(Lifecycle.Read)
  logicalZone?: string;

  /**
   * The fully qualified physical zone id of availability zone to which logical zone id is mapped to
   */
  @visibility(Lifecycle.Read)
  physicalZone?: string;
}

/**
 * Subscription information.
 */
model Subscription {
  /**
   * The fully qualified ID for the subscription. For example, /subscriptions/8d65815f-a5b6-402f-9298-045155da7d74
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The subscription ID.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * The subscription display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The subscription tenant ID.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The subscription state. Possible values are Enabled, Warned, PastDue, Disabled, and Deleted.
   */
  @visibility(Lifecycle.Read)
  state?: SubscriptionState;

  /**
   * The subscription policies.
   */
  subscriptionPolicies?: SubscriptionPolicies;

  /**
   * The authorization source of the request. Valid values are one or more combinations of Legacy, RoleBased, Bypassed, Direct and Management. For example, 'Legacy, RoleBased'.
   */
  authorizationSource?: string;

  /**
   * An array containing the tenants managing the subscription.
   */
  @identifiers(#["tenantId"])
  managedByTenants?: ManagedByTenant[];

  /**
   * The tags attached to the subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Subscription policies.
 */
model SubscriptionPolicies {
  /**
   * The subscription location placement ID. The ID indicates which regions are visible for a subscription. For example, a subscription with a location placement Id of Public_2014-09-01 has access to Azure public regions.
   */
  @visibility(Lifecycle.Read)
  locationPlacementId?: string;

  /**
   * The subscription quota ID.
   */
  @visibility(Lifecycle.Read)
  quotaId?: string;

  /**
   * The subscription spending limit.
   */
  @visibility(Lifecycle.Read)
  spendingLimit?: SpendingLimit;
}

/**
 * Information about a tenant managing the subscription.
 */
model ManagedByTenant {
  /**
   * The tenant ID of the managing tenant. This is a GUID.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

/**
 * Subscription list operation response.
 */
model SubscriptionListResult is Azure.Core.Page<Subscription>;

/**
 * Tenant Ids information.
 */
model TenantListResult is Azure.Core.Page<TenantIdDescription>;

/**
 * Tenant Id information.
 */
model TenantIdDescription {
  /**
   * The fully qualified ID of the tenant. For example, /tenants/8d65815f-a5b6-402f-9298-045155da7d74
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The tenant ID. For example, 8d65815f-a5b6-402f-9298-045155da7d74
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Category of the tenant.
   */
  @visibility(Lifecycle.Read)
  tenantCategory?: TenantCategory;

  /**
   * Country/region name of the address for the tenant.
   */
  @visibility(Lifecycle.Read)
  country?: string;

  /**
   * Country/region abbreviation for the tenant.
   */
  @visibility(Lifecycle.Read)
  countryCode?: string;

  /**
   * The display name of the tenant.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The list of domains for the tenant.
   */
  @visibility(Lifecycle.Read)
  domains?: string[];

  /**
   * The default domain for the tenant.
   */
  @visibility(Lifecycle.Read)
  defaultDomain?: string;

  /**
   * The tenant type. Only available for 'Home' tenant category.
   */
  @visibility(Lifecycle.Read)
  tenantType?: string;

  /**
   * The tenant's branding logo URL. Only available for 'Home' tenant category.
   */
  @visibility(Lifecycle.Read)
  tenantBrandingLogoUrl?: string;
}

/**
 * Check zone peers request parameters.
 */
model CheckZonePeersRequest {
  /**
   * The Microsoft location.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * The peer Microsoft Azure subscription ID.
   */
  subscriptionIds?: string[];
}

/**
 * Result of the Check zone peers operation.
 */
model CheckZonePeersResult {
  /**
   * The subscription ID.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * the location of the subscription.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * The Availability Zones shared by the subscriptions.
   */
  @identifiers(#["availabilityZone"])
  availabilityZonePeers?: AvailabilityZonePeers[];
}

/**
 * List of availability zones shared by the subscriptions.
 */
model AvailabilityZonePeers {
  /**
   * The availabilityZone.
   */
  @visibility(Lifecycle.Read)
  availabilityZone?: string;

  /**
   * Details of shared availability zone.
   */
  @identifiers(#["availabilityZone", "subscriptionId"])
  peers?: Peers[];
}

/**
 * Information about shared availability zone.
 */
model Peers {
  /**
   * The subscription ID.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * The availabilityZone.
   */
  @visibility(Lifecycle.Read)
  availabilityZone?: string;
}

/**
 * Name and Type of the Resource
 */
model ResourceName {
  /**
   * Name of the resource
   */
  name: string;

  /**
   * The type of the resource
   */
  type: string;
}

/**
 * Resource Name valid if not a reserved word, does not contain a reserved word and does not start with a reserved word
 */
model CheckResourceNameResult {
  /**
   * Name of Resource
   */
  name?: string;

  /**
   * Type of Resource
   */
  type?: string;

  /**
   * Is the resource name Allowed or Reserved
   */
  status?: ResourceNameStatus;
}
