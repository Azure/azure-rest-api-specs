import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Genome;

/**
 * choices for server host
 */
union HostOptions {
  string,

  /**
   * host: https://api.genomerp.com
   */
  `https://api.genomerp.com`: "https://api.genomerp.com",

  /**
   * host: https://api-dev.genomerp.com
   */
  `https://api-dev.genomerp.com`: "https://api-dev.genomerp.com",
}

/**
 * Response containing list of configurations
 */
model ConfigurationListResponse {
  /**
   * List of configuration entries
   */
  configurations: ConfigurationResponse[];

  /**
   * Total number of configurations
   */
  totalCount: int32;

  /**
   * Pagination information (if applicable)
   */
  pagination?: ConfigurationListResponsePagination;
}

/**
 * Configuration entry response
 */
model ConfigurationResponse {
  /**
   * Unique identifier for the configuration entry
   */
  id: string;

  /**
   * Configuration key(s) - can be a single string or array of strings
   */
  key: string;

  /**
   * Configuration value(s) - can be a single string or array of strings
   */
  value: string;

  /**
   * Human-readable description of the configuration
   */
  description?: string;

  /**
   * Category or group for organizing configurations
   */
  category?: string;

  /**
   * Flag indicating if the configuration is active
   */
  isActive?: boolean;

  /**
   * User ID who created the configuration
   */
  createdBy: string;

  /**
   * User ID who last modified the configuration
   */
  modifiedBy?: string;

  /**
   * Timestamp when the configuration was created
   */
  createdOn?: utcDateTime;

  /**
   * Timestamp when the configuration was last modified
   */
  modifiedOn?: utcDateTime;
}

/**
 * Pagination information (if applicable)
 */
model ConfigurationListResponsePagination {
  /** Total number of configurations */
  totalCount?: int32;

  /** Maximum number of items per page */
  limit?: int32;

  /** Number of items to skip */
  offset?: int32;

  /** Indicates if there is a next page */
  hasNext?: boolean;

  /** Indicates if there is a previous page */
  hasPrevious?: boolean;
}

/** Common error response structure */
model CommonError {
  /** Error details */
  error?: CommonErrorError;
}

/** Detailed error information */
model CommonErrorError {
  /** Error code */
  code?: string;

  /** Human-readable error message */
  message?: string;
}

/** Standard error response format for general errors */
model ErrorResponse {
  /** Error type */
  error?: string;

  /** Human-readable error message */
  message?: string;
}

/**
 * Request for creating or updating a configuration
 */
model ConfigurationRequest {
  /**
   * Unique configuration key(s) - can be a single string or array of strings
   */
  key: string;

  /**
   * Configuration value(s) - can be a single string or array of strings. For
   * arrays, values are stored as JSON-serialized string
   */
  value: string;

  /**
   * Human-readable description of the configuration
   */
  description?: string;

  /**
   * Category or group for organizing configurations
   */
  category?: string;

  /**
   * User ID of the person creating or updating the configuration
   */
  modifiedBy: string;
}

/** Response containing configuration key and value */
model PathsB13Wt0V1ConfigurationsKeyValueGetResponses200ContentApplicationJsonSchema {
  /**
   * Configuration key
   */
  key?: string;

  /**
   * Configuration value - can be a single string or array of strings
   */
  value?: string;
}
