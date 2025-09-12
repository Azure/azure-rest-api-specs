import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace PurviewDataQuality;

/**
 * Represents a business/data quality rule entity.
 */
model RuleEntity {
  name: string;
  description?: string;
  type: string;
  status: string;

  /**
   * Holds additional properties related to rule type.
   */
  typeProperties?: TypeProperties;

  @format("uuid")
  id: string;

  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  businessDomain?: Reference;

  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  dataProduct?: Reference;

  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  dataAsset?: Reference;

  score?: float64;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;

  @format("uuid")
  createdBy?: string;

  @format("uuid")
  lastModifiedBy?: string;
}

/**
 * Holds additional properties related to rule type.
 */
model TypeProperties {
  /**
   * Represents a column in a dataset.
   */
  column?: Column;
}

/**
 * Represents a column in a dataset.
 */
model Column {
  type?: string;
  value?: string;
}

/**
 * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
 */
model Reference {
  type?: string;

  @format("uuid")
  referenceId?: string;
}
