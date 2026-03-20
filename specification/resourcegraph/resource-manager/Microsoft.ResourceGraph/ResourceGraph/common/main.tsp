import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace ResourceGraphCommon;

/**
 * An error response from the API.
 */
@summary("Error response.")
@error
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

/**
 * Defines in which format query result returned.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResultFormat {
  /**
   * table
   */
  table,

  /**
   * objectArray
   */
  objectArray,
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
