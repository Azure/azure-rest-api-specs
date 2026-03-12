import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace ResourceHistory;

/**
 * Defines in which format query result returned.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResultFormat {
  /**
   * table result format
   */
  table,

  /**
   * object array result format
   */
  objectArray,
}

/**
 * Describes a history request to be executed.
 */
model ResourcesHistoryRequest {
  /**
   * Azure subscriptions against which to execute the query.
   */
  subscriptions?: string[];

  /**
   * The resources query.
   */
  query?: string;

  /**
   * The history request evaluation options
   */
  options?: ResourcesHistoryRequestOptions;

  /**
   * Azure management group against which to execute the query. Example: 'mg1'
   */
  @Versioning.removed(Versions.v2021_06_01_preview)
  managementGroupId?: string;

  /**
   * Azure management groups against which to execute the query. Example: [ 'mg1', 'mg2' ]
   */
  @Versioning.added(Versions.v2021_06_01_preview)
  managementGroups?: string[];
}

/**
 * The options for history request evaluation
 */
model ResourcesHistoryRequestOptions {
  /**
   * The time interval used to fetch history.
   */
  interval?: DateTimeInterval;

  /**
   * The maximum number of rows that the query should return. Overrides the page size when ```$skipToken``` property is present.
   */
  @maxValue(1000)
  @minValue(1)
  $top?: int32;

  /**
   * The number of rows to skip from the beginning of the results. Overrides the next page offset when ```$skipToken``` property is present.
   */
  @minValue(0)
  $skip?: int32;

  /**
   * Continuation token for pagination, capturing the next page size and offset, as well as the context of the query.
   */
  @secret
  $skipToken?: string;

  /**
   * Defines in which format query result returned.
   */
  resultFormat?: ResultFormat;
}

/**
 * An interval in time specifying the date and time for the inclusive start and exclusive end, i.e. `[start, end)`.
 */
model DateTimeInterval {
  /**
   * A datetime indicating the inclusive/closed start of the time interval, i.e. `[`**`start`**`, end)`. Specifying a `start` that occurs chronologically after `end` will result in an error.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  start: utcDateTime;

  /**
   * A datetime indicating the exclusive/open end of the time interval, i.e. `[start, `**`end`**`)`. Specifying an `end` that occurs chronologically before `start` will result in an error.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  end: utcDateTime;
}

/**
 * An error response from the API.
 */
@error
@summary("Error response.")
model ErrorResponse {
  /**
   * Error information.
   */
  error: Error;
}

/**
 * Error details.
 */
@summary("Error info.")
model Error {
  /**
   * Error code identifying the specific error.
   */
  code: string;

  /**
   * A human readable error message.
   */
  message: string;

  /**
   * Error details
   */
  @identifiers(#[])
  details?: ErrorDetails[];
}

/**
 * Error details.
 */
@summary("Error details.")
model ErrorDetails {
  ...Record<unknown>;

  /**
   * Error code identifying the specific error.
   */
  code: string;

  /**
   * A human readable error message.
   */
  message: string;
}

alias ResourcesHistoryResult = Record<unknown>;
