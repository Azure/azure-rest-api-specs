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

namespace Microsoft.ServiceFabric;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationResultsOperations {
  /**
   * Get long running operation result.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get long running operation result.")
  @operationId("OperationResults_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedClusterOperationResults/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * operation identifier.
     */
    @path
    operationId: string,
  ): OkResponse | ArmAcceptedResponse | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationStatusOperations {
  /**
   * Get long running operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get long running operation status.")
  @operationId("OperationStatus_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedClusterOperations/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * operation identifier.
     */
    @path
    operationId: string,
  ): ArmResponse<LongRunningOperationResult> | ErrorResponse;
}
