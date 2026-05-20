import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace PolicyInsightsCommon;

/**
 * Error response.
 */
@error
model QueryFailure {
  /**
   * Error definition.
   */
  error?: QueryFailureError;
}

/**
 * Error definition.
 */
model QueryFailureError {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Description of the error.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}
