import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Compute;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The type of the extended location.
 */
union ExtendedLocationType {
  string,
  EdgeZone: "EdgeZone",
}

/**
 * The type of extendedLocation.
 */
union ExtendedLocationTypes {
  string,
  EdgeZone: "EdgeZone",
}

/**
 * The scale type applicable to the sku.
 */
enum ResourceSkuCapacityScaleType {
  Automatic,
  Manual,
  None,
}

/**
 * The type of restrictions.
 */
enum ResourceSkuRestrictionsType {
  Location,
  Zone,
}

/**
 * The reason for restriction.
 */
enum ResourceSkuRestrictionsReasonCode {
  QuotaId,
  NotAvailableForSubscription,
}

/**
 * The List Resource Skus operation response.
 */
model ResourceSkusResult is Azure.Core.Page<ResourceSku>;

/**
 * Describes an available Compute SKU.
 */
model ResourceSku {
  /**
   * The type of resource the SKU applies to.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The name of SKU.
   */
  @visibility("read")
  name?: string;

  /**
   * Specifies the tier of virtual machines in a scale set.<br /><br /> Possible Values:<br /><br /> **Standard**<br /><br /> **Basic**
   */
  @visibility("read")
  tier?: string;

  /**
   * The Size of the SKU.
   */
  @visibility("read")
  size?: string;

  /**
   * The Family of this particular SKU.
   */
  @visibility("read")
  family?: string;

  /**
   * The Kind of resources that are supported in this SKU.
   */
  @visibility("read")
  kind?: string;

  /**
   * Specifies the number of virtual machines in the scale set.
   */
  @visibility("read")
  capacity?: ResourceSkuCapacity;

  /**
   * The set of locations that the SKU is available.
   */
  @visibility("read")
  locations?: string[];

  /**
   * A list of locations and availability zones in those locations where the SKU is available.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["location"])
  locationInfo?: ResourceSkuLocationInfo[];

  /**
   * The api versions that support this SKU.
   */
  @visibility("read")
  apiVersions?: string[];

  /**
   * Metadata for retrieving price info.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  costs?: ResourceSkuCosts[];

  /**
   * A name value pair to describe the capability.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  capabilities?: ResourceSkuCapabilities[];

  /**
   * The restrictions because of which SKU cannot be used. This is empty if there are no restrictions.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  restrictions?: ResourceSkuRestrictions[];
}

/**
 * Describes scaling information of a SKU.
 */
model ResourceSkuCapacity {
  /**
   * The minimum capacity.
   */
  @visibility("read")
  minimum?: int64;

  /**
   * The maximum capacity that can be set.
   */
  @visibility("read")
  maximum?: int64;

  /**
   * The default capacity.
   */
  @visibility("read")
  default?: int64;

  /**
   * The scale type applicable to the sku.
   */
  @visibility("read")
  scaleType?: ResourceSkuCapacityScaleType;
}

/**
 * Describes an available Compute SKU Location Information.
 */
model ResourceSkuLocationInfo {
  /**
   * Location of the SKU
   */
  @visibility("read")
  location?: string;

  /**
   * List of availability zones where the SKU is supported.
   */
  @visibility("read")
  zones?: string[];

  /**
   * Details of capabilities available to a SKU in specific zones.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  zoneDetails?: ResourceSkuZoneDetails[];

  /**
   * The names of extended locations.
   */
  @visibility("read")
  extendedLocations?: string[];

  /**
   * The type of the extended location.
   */
  @visibility("read")
  type?: ExtendedLocationType;
}

/**
 * Describes The zonal capabilities of a SKU.
 */
model ResourceSkuZoneDetails {
  /**
   * The set of zones that the SKU is available in with the specified capabilities.
   */
  @visibility("read")
  name?: string[];

  /**
   * A list of capabilities that are available for the SKU in the specified list of zones.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  capabilities?: ResourceSkuCapabilities[];
}

/**
 * Describes The SKU capabilities object.
 */
model ResourceSkuCapabilities {
  /**
   * An invariant to describe the feature.
   */
  @visibility("read")
  name?: string;

  /**
   * An invariant if the feature is measured by quantity.
   */
  @visibility("read")
  value?: string;
}

/**
 * Describes metadata for retrieving price info.
 */
model ResourceSkuCosts {
  /**
   * Used for querying price from commerce.
   */
  @visibility("read")
  meterID?: string;

  /**
   * The multiplier is needed to extend the base metered cost.
   */
  @visibility("read")
  quantity?: int64;

  /**
   * An invariant to show the extended unit.
   */
  @visibility("read")
  extendedUnit?: string;
}

/**
 * Describes scaling information of a SKU.
 */
model ResourceSkuRestrictions {
  /**
   * The type of restrictions.
   */
  @visibility("read")
  type?: ResourceSkuRestrictionsType;

  /**
   * The value of restrictions. If the restriction type is set to location. This would be different locations where the SKU is restricted.
   */
  @visibility("read")
  values?: string[];

  /**
   * The information about the restriction where the SKU cannot be used.
   */
  @visibility("read")
  restrictionInfo?: ResourceSkuRestrictionInfo;

  /**
   * The reason for restriction.
   */
  @visibility("read")
  reasonCode?: ResourceSkuRestrictionsReasonCode;
}

/**
 * Describes an available Compute SKU Restriction Information.
 */
model ResourceSkuRestrictionInfo {
  /**
   * Locations where the SKU is restricted
   */
  @visibility("read")
  locations?: string[];

  /**
   * List of availability zones where the SKU is restricted.
   */
  @visibility("read")
  zones?: string[];
}

/**
 * Api error base.
 */
model ApiErrorBase {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The target of the particular error.
   */
  target?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * Inner error details.
 */
model InnerError {
  /**
   * The exception type.
   */
  exceptiontype?: string;

  /**
   * The internal error message or exception dump.
   */
  errordetail?: string;
}

/**
 * An error response from the Compute service.
 */
model CloudError {
  /**
   * Api error.
   */
  error?: ApiError;
}

/**
 * Api error.
 */
model ApiError {
  /**
   * The Api error details
   */
  @OpenAPI.extension("x-ms-identifiers", ["message", "target"])
  details?: ApiErrorBase[];

  /**
   * The Api inner error
   */
  innererror?: InnerError;

  /**
   * The error code.
   */
  code?: string;

  /**
   * The target of the particular error.
   */
  target?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * The Resource model definition.
 */
model Resource {
  /**
   * Resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location
   */
  location: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

model SubResource {
  /**
   * Resource Id
   */
  id?: string;
}

model SubResourceReadOnly {
  /**
   * Resource Id
   */
  @visibility("read")
  id?: string;
}

/**
 * The Resource model definition with location property as optional.
 */
model ResourceWithOptionalLocation {
  /**
   * Resource location
   */
  location?: string;

  /**
   * Resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * The complex type of the extended location.
 */
model ExtendedLocation {
  /**
   * The name of the extended location.
   */
  name?: string;

  /**
   * The type of the extended location.
   */
  type?: ExtendedLocationTypes;
}

model UserAssignedIdentitiesValue {
  /**
   * The principal id of user assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility("read")
  clientId?: string;
}
