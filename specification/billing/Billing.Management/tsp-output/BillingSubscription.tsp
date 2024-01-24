import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Billing;
/**
 * A billing subscription.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@Azure.ResourceManager.Private.armResourceInternal(
  BillingSubscriptionProperties
)
@includeInapplicableMetadataInPayload(false)
model BillingSubscription extends Resource {
  /**
   * The ID that uniquely identifies a subscription.
   */
  @path
  @key("billingSubscriptionName")
  @segment("billingSubscriptions")
  name: string;

  /**
   * The billing properties of a subscription.
   */
  @extension("x-ms-client-flatten", true)
  properties?: BillingSubscriptionProperties;
}

@armResourceOperations
interface BillingSubscriptions {
  /**
   * Gets a subscription by its ID. The operation is currently supported for billing accounts with agreement type Microsoft Customer Agreement, Microsoft Partner Agreement and Microsoft Online Services Program.
   */
  get is ArmResourceRead<BillingSubscription>;

  /**
   * Updates the properties of a billing subscription.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    BillingSubscription,
    BillingSubscription,
    BaseParameters<BillingSubscription>,
    ArmLroLocationHeader
  >;

  /**
   * Cancels a billing subscription.
   */
  delete is ArmResourceDeleteAsync<
    BillingSubscription,
    BaseParameters<BillingSubscription>,
    ArmLroLocationHeader
  >;

  /**
   * Lists the subscriptions for a billing account. The operation is currently supported for billing accounts with agreement type Microsoft Customer Agreement, Microsoft Partner Agreement and Microsoft Online Services Program.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BillingSubscriptions_ListByBillingAccount")
  listByBillingAccount is ArmResourceListByParent<BillingSubscription>;

  /**
   * Moves a subscription's charges to a new invoice section. This operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  move is ArmResourceActionAsync<
    BillingSubscription,
    MoveBillingSubscriptionRequest,
    BillingSubscription,
    BaseParameters<BillingSubscription>,
    ArmLroLocationHeader
  >;

  /**
   * Validates if a subscription's charges can be moved to a new invoice section. This operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  validateMoveEligibility is ArmResourceActionSync<
    BillingSubscription,
    MoveBillingSubscriptionRequest,
    ValidateMoveBillingSubscriptionEligibilityResult
  >;

  /**
   * Merges the billing subscription provided in the request with a target billing subscription.
   */
  merge is ArmResourceActionAsync<
    BillingSubscription,
    BillingSubscriptionMergeRequest,
    BillingSubscription,
    BaseParameters<BillingSubscription>,
    ArmLroLocationHeader
  >;

  /**
   * Splits a subscription into a new subscription with quantity less than current subscription quantity and not equal to 0.
   */
  split is ArmResourceActionAsync<
    BillingSubscription,
    BillingSubscriptionSplitRequest,
    BillingSubscription,
    BaseParameters<BillingSubscription>,
    ArmLroLocationHeader
  >;
}

@@projectedName(BillingSubscriptions.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(BillingSubscriptions.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(BillingSubscriptions.update::parameters.properties,
  "Request parameters that are provided to the update billing subscription operation."
);
@@projectedName(BillingSubscriptions.move::parameters.body,
  "json",
  "parameters"
);
@@extension(BillingSubscriptions.move::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(BillingSubscriptions.move::parameters.body,
  "Request parameters that are provided to the move subscription operation."
);
@@projectedName(BillingSubscriptions.validateMoveEligibility::parameters.body,
  "json",
  "parameters"
);
@@extension(BillingSubscriptions.validateMoveEligibility::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(BillingSubscriptions.validateMoveEligibility::parameters.body,
  "Request parameters that are provided to the validate move eligibility operation."
);
@@projectedName(BillingSubscriptions.merge::parameters.body,
  "json",
  "parameters"
);
@@extension(BillingSubscriptions.merge::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(BillingSubscriptions.merge::parameters.body,
  "Request parameters that are provided to merge the two billing subscriptions."
);
@@projectedName(BillingSubscriptions.split::parameters.body,
  "json",
  "parameters"
);
@@extension(BillingSubscriptions.split::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(BillingSubscriptions.split::parameters.body,
  "Request parameters that are provided to split the billing subscription."
);
