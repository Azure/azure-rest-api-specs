import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ServiceFabric;

/**
 * Parameter identifying a long-running operation.
 */
model OperationIdParameter {
  /**
   * operation identifier.
   */
  @path
  operationId: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Needed to avoid autoroute"
interface OperationResults {
  /**
   * Get long running operation result.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Day 0 property, no body for 200 response"
  #suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "FIXME: review suppression and update justification"
  #suppress "@azure-tools/typespec-azure-resource-manager/use-api-version" "FIXME: review suppression and update justification"
  #suppress "@azure-tools/typespec-azure-resource-manager/use-interface" "Necessary to avoid standard routing"
  @summary("Get long running operation result.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedClusterOperationResults/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,
    ...OperationIdParameter,
  ):
    | OkResponse
    | (AcceptedResponse & LocationHeader)
    | ArmNoContentResponse<"No Content. For Delete operation results.">
    | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Needed to avoid autoroute"
interface OperationStatus {
  /**
   * Get long running operation status.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "FIXME: review suppression and update justification"
  #suppress "@azure-tools/typespec-azure-resource-manager/use-api-version" "FIXME: review suppression and update justification"
  #suppress "@azure-tools/typespec-azure-resource-manager/use-interface" "Necessary to avoid standard routing"
  @summary("Get long running operation status.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedClusterOperations/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,
    ...OperationIdParameter,
  ): ArmResponse<LongRunningOperationResult> | ErrorResponse;
}
