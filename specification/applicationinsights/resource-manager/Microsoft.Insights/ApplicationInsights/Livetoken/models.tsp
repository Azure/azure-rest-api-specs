import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace LiveTokenApi;

/**
 * The response to a live token query.
 */
model LiveTokenResponse {
  /**
   * JWT token for accessing live metrics stream data.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" ""
  @visibility(Lifecycle.Read)
  liveToken?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@error
model ErrorResponseLinkedStorage {
  /**
   * Error response indicates Insights service is not able to process the incoming request. The reason is provided in the error message.
   */
  error?: ErrorResponseLinkedStorageError;
}

/**
 * Error response indicates Insights service is not able to process the incoming request. The reason is provided in the error message.
 */
model ErrorResponseLinkedStorageError {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}
