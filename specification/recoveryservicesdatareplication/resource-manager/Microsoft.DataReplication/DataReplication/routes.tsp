// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DataReplication;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Cannot use @armResourceOperations decorator here, the auto-generated routes do not match feature requirements"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Cannot use  @armResourceOperations decorator here, the auto-generated routes do not match feature requirements"
interface CheckNameAvailability {
  /**
   * Checks the resource name availability.
   */
  @summary("Performs the resource name availability check.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataReplication/locations/{location}/checkNameAvailability")
  @post
  post(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * Resource details.
     */
    @body
    body?: CheckNameAvailabilityModel,
  ): ArmResponse<CheckNameAvailabilityResponseModel> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Cannot use @armResourceOperations decorator here, the auto-generated routes do not match feature requirements"
interface DeploymentPreflight {
  /**
   * Performs resource deployment preflight validation.
   */
  @summary("Performs resource deployment validation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/deployments/{deploymentId}/preflight")
  @armResourceAction(DeploymentPreflightModel)
  @post
  post(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Deployment Id.
     */
    @path
    deploymentId: string,

    /**
     * Deployment preflight model.
     */
    @body
    body?: DeploymentPreflightModel,
  ): ArmResponse<DeploymentPreflightModel> | ErrorResponse;
}

@armResourceOperations
interface OperationResults {
  /**
   * Gets the operations.
   */
  @summary("Gets the operation result status.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/operationResults/{operationId}")
  @armResourceRead(ArmResponse<OperationStatus>)
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...Foundations.OperationIdParameter,
  ): ArmResponse<OperationStatus> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Cannot use @armResourceOperations decorator here, the auto-generated routes do not match feature requirements"
interface LocationBasedOperationResults {
  /**
   * Gets the location based operation result.
   */
  @summary("Gets the location based operation result status.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/locations/{location}/operationResults/{operationId}")
  @armResourceRead(ArmResponse<OperationStatus>)
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...LocationResourceParameter,
    ...Foundations.OperationIdParameter,
  ): ArmResponse<OperationStatus> | ErrorResponse;
}
