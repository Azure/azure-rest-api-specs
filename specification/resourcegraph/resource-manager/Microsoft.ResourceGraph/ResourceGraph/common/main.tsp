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
