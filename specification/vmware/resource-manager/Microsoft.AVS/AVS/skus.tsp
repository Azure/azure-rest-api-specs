namespace Microsoft.AVS;

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
@added(Versions.v2024_09_01)
interface Skus {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
  @doc("A list of SKUs.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AVS/skus")
  @get
  @list
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
  ): ArmResponse<PagedResourceSku> | ErrorResponse;
}

@@identifiers(PagedResourceSku.value, #[]);
model PagedResourceSku is Page<ResourceSku>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@doc("A SKU for a resource.")
model ResourceSku {
  @doc("The type of resource the SKU applies to.")
  resourceType: ResourceSkuResourceType;

  @doc("The name of the SKU.")
  name: string;

  @doc("The tier of virtual machines in a scale set")
  tier?: string;

  @doc("The size of the SKU.")
  size?: string;

  @doc("The family of the SKU.")
  family?: string;

  @doc("The set of locations that the SKU is available.")
  locations: azureLocation[];

  @doc("A list of locations and availability zones in those locations where the SKU is available")
  @extension("x-ms-identifiers", #[])
  locationInfo: ResourceSkuLocationInfo[];

  @doc("Name value pairs to describe the capability.")
  @extension("x-ms-identifiers", #[])
  capabilities?: ResourceSkuCapabilities[];

  @doc("The restrictions of the SKU.")
  @extension("x-ms-identifiers", #[])
  restrictions: ResourceSkuRestrictions[];
}

@doc("Describes an available Compute SKU Location Information.")
model ResourceSkuLocationInfo {
  @doc("Location of the SKU")
  location: azureLocation;

  @doc("List of availability zones where the SKU is supported.")
  zones: string[];

  @doc("Gets details of capabilities available to a SKU in specific zones.")
  @extension("x-ms-identifiers", #[])
  zoneDetails: ResourceSkuZoneDetails[];
}

@doc("Describes The zonal capabilities of a SKU.")
model ResourceSkuZoneDetails {
  @doc("Gets the set of zones that the SKU is available in with the specified capabilities.")
  name: string[];

  @doc("A list of capabilities that are available for the SKU in the specified list of zones.")
  @extension("x-ms-identifiers", #[])
  capabilities: ResourceSkuCapabilities[];
}

@doc("Describes The SKU capabilities object.")
model ResourceSkuCapabilities {
  @doc("The name of the SKU capability.")
  name: string;

  @doc("The value of the SKU capability.")
  value: string;
}

@doc("The restrictions of the SKU.")
model ResourceSkuRestrictions {
  @doc("the type of restrictions.")
  type?: ResourceSkuRestrictionsType;

  @doc("The value of restrictions. If the restriction type is set to location. This would be different locations where the SKU is restricted.")
  values: string[];

  @doc("The information about the restriction where the SKU cannot be used.")
  restrictionInfo: ResourceSkuRestrictionInfo;

  @doc("the reason for restriction.")
  reasonCode?: ResourceSkuRestrictionsReasonCode;
}

/** Describes the kind of SKU restrictions that can exist */
union ResourceSkuRestrictionsType {
  string,

  /** SKU restricted by location. */
  "Location",

  /** SKU restricted by availability zone. */
  "Zone",
}

@doc("Describes an available Compute SKU Restriction Information.")
model ResourceSkuRestrictionInfo {
  @doc("Locations where the SKU is restricted")
  locations?: azureLocation[];

  @doc("List of availability zones where the SKU is restricted.")
  zones?: string[];
}

/** Describes the reason for SKU restriction. */
union ResourceSkuRestrictionsReasonCode {
  string,

  /** The restriction is due to exceeding a quota limitation. */
  "QuotaId",

  /** The restriction is not available for this subscription. */
  "NotAvailableForSubscription",
}

/** Describes the type of resource the SKU applies to. */
union ResourceSkuResourceType {
  string,

  /** The SKU is for a private cloud. */
  "privateClouds",

  /** The SKU is for a private cloud cluster. */
  "privateClouds/clusters",
}
