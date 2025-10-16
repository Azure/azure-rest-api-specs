// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DevTestLab;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface Operations {
  /**
   * Get operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DevTestLab/locations/{locationName}/operations/{name}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the location.
     */
    @path
    locationName: string,

    /**
     * The name of the operation.
     */
    @path
    name: string,
  ): ArmResponse<OperationResult> | AcceptedResponse | ErrorResponse;
}

/**
 * Response for operations that return with 202 Accepted status code.
 */
model AcceptedResponse {
  /**
   * HTTP status code 202
   */
  @statusCode
  statusCode: 202;

  /**
   * The operation result object.
   */
  @body
  body: OperationResult;
}
