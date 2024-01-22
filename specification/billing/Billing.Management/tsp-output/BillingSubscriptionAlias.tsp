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
 * A billing subscription alias.
 */
@tenantResource
model BillingSubscriptionAlias
  is ProxyResource<BillingSubscriptionAliasProperties> {
  /**
   * The ID that uniquely identifies a subscription alias.
   */
  @path
  @key("aliasName")
  @segment("billingSubscriptionAliases")
  name: string;
}

@armResourceOperations
interface BillingSubscriptionAliases {
  /**
   * Gets a subscription by its alias ID.  The operation is supported for seat based billing subscriptions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BillingSubscriptionsAliases_Get")
  get is ArmResourceRead<BillingSubscriptionAlias>;

  /**
   * Creates or updates a billing subscription by its alias ID.  The operation is supported for seat based billing subscriptions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BillingSubscriptionsAliases_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BillingSubscriptionAlias>;

  /**
   * Lists the subscription aliases for a billing account. The operation is supported for seat based billing subscriptions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BillingSubscriptionsAliases_ListByBillingAccount")
  listByBillingAccount is ArmResourceListByParent<BillingSubscriptionAlias>;
}

@@projectedName(BillingSubscriptionAliases.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(BillingSubscriptionAliases.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(BillingSubscriptionAliases.createOrUpdate::parameters.resource,
  "New or updated billing subscription alias."
);
