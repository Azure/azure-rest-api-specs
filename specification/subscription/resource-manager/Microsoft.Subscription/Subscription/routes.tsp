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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
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
  @autoRoute
  acceptOwnership is ArmProviderActionAsync<
    Request = AcceptOwnershipRequest,
    Parameters = {
      ...SubscriptionIdParameter;
    },
    Response = ArmAcceptedResponse & ArmLroLocationHeader
  >;
  /**
   * Accept subscription ownership status.
   */
  @autoRoute
  @get
  acceptOwnershipStatus is ArmProviderActionSync<
    Response = AcceptOwnershipStatusResponse,
    Parameters = {
      ...SubscriptionIdParameter;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
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
  ): ArmResponse<SubscriptionCreationResult> | (ArmAcceptedResponse &
    ArmLroLocationHeader) | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SubscriptionsOperationGroup {
  /**
   * The operation to accept Subscription Changed Request
   */
  @autoRoute
  @action("acceptChangeTenant")
  acceptTargetDirectory is ArmProviderActionSync<Parameters = {
    ...SubscriptionIdParameter;
  }>;
  /**
   * The operation for Acceptor to view the accepted request
   */
  @autoRoute
  @action("changeTenantStatus")
  targetDirectoryStatus is ArmProviderActionSync<
    Response = TargetDirectoryResultProperties,
    Parameters = {
      ...SubscriptionIdParameter;
    }
  >;
}
