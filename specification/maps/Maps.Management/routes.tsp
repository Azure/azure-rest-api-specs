// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Maps;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationResultOperationGroup {
  /**
   * Get the result of a long running azure asynchronous operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OperationResult_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maps/locations/{location}/operationResults/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,
    ...Azure.ResourceManager.CommonTypes.OperationIdParameter,
  ): OkResponse | ArmAcceptedResponse<ExtraHeaders = {
    @header("Location")
    location?: string;
  }> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationStatusOperationGroup {
  /**
   * Get the status of a long running azure asynchronous operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OperationStatus_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maps/locations/{location}/operationStatuses/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,
    ...Azure.ResourceManager.CommonTypes.OperationIdParameter,
  ): ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult> | ErrorResponse;
}
