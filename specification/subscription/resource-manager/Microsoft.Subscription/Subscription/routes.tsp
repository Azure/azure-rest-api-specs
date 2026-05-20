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

namespace Microsoft.Subscription;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SubscriptionIdPathParameter {
  /**
   * Subscription Id.
   */
  @path
  @segment("subscriptions")
  subscriptionId: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SubscriptionOperationGroup {
  /**
   * The operation to cancel a subscription
   */
  @autoRoute
  cancel is ArmProviderActionSync<
    Response = CanceledSubscriptionId,
    Scope = SubscriptionActionScope
  >;
  /**
   * The operation to rename a subscription
   */
  @autoRoute
  rename is ArmProviderActionSync<
    Request = SubscriptionName,
    Response = RenamedSubscriptionId,
    Scope = SubscriptionActionScope
  >;
  /**
   * The operation to enable a subscription
   */
  @autoRoute
  enable is ArmProviderActionSync<
    Response = EnabledSubscriptionId,
    Scope = SubscriptionActionScope
  >;
  /**
   * Accept subscription ownership.
   */
  @route("/providers/Microsoft.Subscription/subscriptions/{subscriptionId}/acceptOwnership")
  acceptOwnership(
    ...ApiVersionParameter,
    ...SubscriptionIdPathParameter,

    /**
     * The request body
     */
    @body body: AcceptOwnershipRequest,
  ): ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = void> &
    Azure.Core.Foundations.RetryAfterHeader> | ErrorResponse;
  /**
   * Accept subscription ownership status.
   */
  @autoRoute
  @get
  acceptOwnershipStatus is ArmProviderActionSync<
    Response = AcceptOwnershipStatusResponse,
    Parameters = {
      ...SubscriptionIdPathParameter;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SubscriptionOperationOperationGroup {
  /**
   * Get the status of the pending Microsoft.Subscription API operations.
   */
  @route("/providers/Microsoft.Subscription/subscriptionOperations/{operationId}")
  @get
  get(
    ...ApiVersionParameter,

    /**
     * The operation ID, which can be found from the Location field in the generate recommendation response header.
     */
    @path
    operationId: string,
  ): ArmResponse<SubscriptionCreationResult> | (ArmAcceptedResponse & {
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @header("Location")
    @doc("The Location header contains the URL where the status of the long running operation can be checked.")
    Location: string;
  }) | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SubscriptionsOperationGroup {
  /**
   * The operation to accept Subscription Changed Request
   */
  @autoRoute
  @action("acceptChangeTenant")
  acceptTargetDirectory is ArmProviderActionSync<Parameters = {
    ...SubscriptionIdPathParameter;
  }>;
  /**
   * The operation for Acceptor to view the accepted request
   */
  @autoRoute
  @action("changeTenantStatus")
  targetDirectoryStatus is ArmProviderActionSync<
    Response = TargetDirectoryResultProperties,
    Parameters = {
      ...SubscriptionIdPathParameter;
    }
  >;
}
