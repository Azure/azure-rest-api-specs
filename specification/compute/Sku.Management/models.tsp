import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Compute;

/**
 * The type of the extended location.
 */
union ExtendedLocationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EdgeZone: "EdgeZone",
}

/**
 * The scale type applicable to the sku.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceSkuCapacityScaleType {
  Automatic,
  Manual,
  None,
}

/**
 * The type of restrictions.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceSkuRestrictionsType {
  Location,
  Zone,
}

/**
 * The reason for restriction.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "backwards compatibility"
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

// /**
//  * The SubResource model definition.
//  */
// model SubResource {
//   /**
//    * Resource Id
//    */
//   id?: string;
// }

// /**
//  * The SubResourceReadOnly model definition.
//  */
// model SubResourceReadOnly {
//   /**
//    * Resource Id
//    */
//   @visibility("read")
//   id?: string;
// }

// model UserAssignedIdentitiesValue {
//   /**
//    * The principal id of user assigned identity.
//    */
//   @visibility("read")
//   principalId?: string;

//   /**
//    * The client id of user assigned identity.
//    */
//   @visibility("read")
//   clientId?: string;
// }
