import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Http;

namespace Genome;

/** Sort order for supply chain entities */
union Paths1995XaxV1SupplychainEntitiesGetParameters13Schema {
  string,

  /**
   * ASC
   */
  ASC: "ASC",

  /**
   * DESC
   */
  DESC: "DESC",
}

/** Sort order for supply chain entities */
union PathsMi8Vf6V1SupplychainEntitiesGetParameters15Schema {
  string,

  /**
   * ASC
   */
  ASC: "ASC",

  /**
   * DESC
   */
  DESC: "DESC",
}

/** Sort order for supply chain entity search */
union Paths1A00F2QV1SupplychainEntitiesEntitykeySearchGetParameters15Schema {
  string,

  /**
   * ASC
   */
  ASC: "ASC",

  /**
   * DESC
   */
  DESC: "DESC",
}

/** Sort order for supply chain entity search */
union Paths1Dk1QrqV1SupplychainEntitiesEntitykeySearchGetParameters17Schema {
  string,

  /**
   * ASC
   */
  ASC: "ASC",

  /**
   * DESC
   */
  DESC: "DESC",
}

/** Response containing a paginated list of suppliers */
model SupplierListResponse {
  /**
   * The list of suppliers
   */
  suppliers?: SupplierResponse[];

  /**
   * The total count of suppliers found
   */
  totalCount?: int32;

  /**
   * The cursor for the next page (if applicable)
   */
  nextCursor?: string;

  /**
   * The cursor for the previous page (if applicable)
   */
  previousCursor?: string;

  /**
   * Indicates whether there are more results available
   */
  hasMore?: boolean;
}

/** Response containing supplier entity details */
model SupplierResponse {
  /**
   * The unique entity key/identifier
   */
  entityKey: string;

  /**
   * The data source identifier
   */
  source: string;

  /**
   * The entity type
   */
  entityType: string;

  /**
   * The supplier name
   */
  name: string;

  /**
   * The jurisdiction/country where the supplier is located
   */
  jurisdiction?: string;

  /**
   * The risk score
   */
  score?: int32;

  /**
   * The LEI (Legal Entity Identifier) code
   */
  leiCode?: string;

  /**
   * The last modified date
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedAt?: utcDateTime;

  /**
   * The created date
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The data version identifier
   */
  version?: string;

  /**
   * The DUNS number
   */
  dunsNumber?: string;

  /**
   * The VAT identifier
   */
  vatId?: string;

  /**
   * The business registration number
   */
  bizRegNo?: string;

  /**
   * The street address
   */
  streetAddress?: string;

  /**
   * The city
   */
  city?: string;

  /**
   * The state or province
   */
  stateProvince?: string;

  /**
   * The postal code
   */
  postalCode?: string;

  /**
   * The primary contact name
   */
  primaryContactName?: string;

  /**
   * The primary email address
   */
  primaryEmail?: string;

  /**
   * The primary phone number
   */
  primaryPhone?: string;

  /**
   * The website URL
   */
  website?: string;

  /**
   * The list of capabilities
   */
  capabilities?: string[];

  /**
   * The list of certifications
   */
  certifications?: string[];

  /**
   * The list of flags associated with this supplier
   */
  flags?: string[];
}

/** Azure AI Search results response with dynamic structure */
model SearchResultsResponse is Record<string>;

/** Error response from the API */
model ErrorResponse {
  /**
   * Error message
   */
  error?: string;

  /**
   * Additional error details
   */
  details?: string;

  /**
   * Error timestamp
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Request path that caused the error
   */
  path?: string;
}

/** Response containing search results for N-tier supplier relationships */
model SearchNtierSuppliersResponse {
  /**
   * The list of suppliers with their depth information
   */
  suppliers?: SupplierWithDepthResponse[];

  /**
   * The root entity key that was used for the traversal
   */
  rootEntityKey?: string;

  /**
   * The maximum upstream depth that was traversed
   */
  maxUpstreamDepth?: int32;

  /**
   * The maximum downstream depth that was traversed
   */
  maxDownstreamDepth?: int32;

  /**
   * The total count of suppliers found
   */
  totalCount?: int32;

  /**
   * The cursor for the next page (if applicable)
   */
  nextCursor?: string;

  /**
   * The cursor for the previous page (if applicable)
   */
  previousCursor?: string;

  /**
   * Indicates whether there are more results available
   */
  hasMore?: boolean;
}

/** Supplier entity with depth information for hierarchical traversal */
model SupplierWithDepthResponse {
  /**
   * The unique entity key/identifier
   */
  entityKey: string;

  /**
   * The data source identifier
   */
  source: string;

  /**
   * The entity type
   */
  entityType: string;

  /**
   * The supplier name
   */
  name: string;

  /**
   * The jurisdiction/country where the supplier is located
   */
  jurisdiction?: string;

  /**
   * The supplier score
   */
  score?: int32;

  /**
   * The LEI (Legal Entity Identifier) code
   */
  leiCode?: string;

  /**
   * The modification timestamp
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedAt?: utcDateTime;

  /**
   * The creation timestamp
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The data version identifier
   */
  version?: string;

  /**
   * The DUNS number
   */
  dunsNumber?: string;

  /**
   * The VAT identifier
   */
  vatId?: string;

  /**
   * The business registration number
   */
  bizRegNo?: string;

  /**
   * The street address
   */
  streetAddress?: string;

  /**
   * The city
   */
  city?: string;

  /**
   * The state or province
   */
  stateProvince?: string;

  /**
   * The postal code
   */
  postalCode?: string;

  /**
   * The primary contact name
   */
  primaryContactName?: string;

  /**
   * The primary email address
   */
  primaryEmail?: string;

  /**
   * The primary phone number
   */
  primaryPhone?: string;

  /**
   * The website URL
   */
  website?: string;

  /**
   * The list of capabilities
   */
  capabilities?: string[];

  /**
   * The list of certifications
   */
  certifications?: string[];

  /**
   * The list of supplier flags
   */
  flags?: string[];

  /**
   * The depth/tier level of this supplier in the graph traversal
   */
  depth: int32;
}

/** Response containing N-tier supplier hierarchy and relationships */
model NtierSuppliersResponse {
  /**
   * The list of suppliers with their depth information
   */
  suppliers?: SupplierWithDepthResponse[];

  /**
   * The list of relationships between entities
   */
  relationships?: NtierSupplierRelationship[];

  /**
   * The root entity key that was used for the traversal
   */
  rootEntityKey?: string;

  /**
   * The maximum upstream depth that was traversed
   */
  maxUpstreamDepth?: int32;

  /**
   * The maximum downstream depth that was traversed
   */
  maxDownstreamDepth?: int32;

  /**
   * The cursor for the next page (if applicable)
   */
  nextCursor?: string;

  /**
   * The cursor for the previous page (if applicable)
   */
  previousCursor?: string;

  /**
   * Indicates whether there are more results available
   */
  hasMore?: boolean;
}

/** Represents a supplier relationship in the N-tier supply chain graph */
model NtierSupplierRelationship {
  /**
   * The source entity key in the relationship
   */
  fromEntityKey?: string;

  /**
   * The target entity key in the relationship
   */
  toEntityKey?: string;

  /**
   * The type of relationship (e.g., SUPPLIES_TO, SUPPLIED_BY)
   */
  relationshipType?: string;

  /**
   * The depth level where this relationship occurs
   */
  depth?: int32;

  /**
   * Additional properties of the relationship. HS codes are available in this
   * dictionary under the 'hsCodes' key.
   */
  properties?: Record<string>;
}

/** Response containing list of supply chain flags */
model PathsFbhgtlV1SupplychainFlagsGetResponses200ContentApplicationJsonSchema {
  /** List of flags */
  flags?: Get200ApplicationJsonPropertiesItemsItem[];

  /**
   * Cursor for next page
   */
  nextCursor?: string;

  /**
   * Indicates if more results are available
   */
  hasMore?: boolean;
}

/** Flag details item */
model Get200ApplicationJsonPropertiesItemsItem {
  /**
   * Unique flag identifier
   */
  flagId?: string;

  /**
   * Flag name
   */
  flagName?: string;

  /**
   * Flag description
   */
  flagDescription?: string;
}

/** Common error details */
model CommonErrorDetails {
  /**
   * Error code identifying the type of error
   */
  code?: string;

  /**
   * Human-readable error message
   */
  message?: string;

  /**
   * Additional error details for validation errors
   */
  details?: CommonErrorDetails[];
}

/** Common error response wrapper */
model CommonError {
  /** Error details */
  error?: CommonErrorDetails;
}

/** Pagination information */
model Pagination {
  /**
   * Total number of items
   */
  totalCount?: int32;

  /**
   * Number of items per page
   */
  limit?: int32;

  /**
   * Number of items skipped
   */
  offset?: int32;

  /**
   * Whether there are more items
   */
  hasNext?: boolean;

  /**
   * Whether there are previous items
   */
  hasPrevious?: boolean;
}
