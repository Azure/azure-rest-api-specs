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
@doc("A billing subscription alias.")
@tenantResource
model BillingSubscriptionAlias
  is ProxyResource<BillingSubscriptionAliasProperties> {
  @doc("The ID that uniquely identifies a subscription alias.")
  @path
  @key("aliasName")
  @segment("billingSubscriptionAliases")
  name: string;
}

@armResourceOperations
interface BillingSubscriptionAliases {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a subscription by its alias ID.  The operation is supported for seat based billing subscriptions.")
  @operationId("BillingSubscriptionsAliases_Get")
  get is ArmResourceRead<BillingSubscriptionAlias>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a billing subscription by its alias ID.  The operation is supported for seat based billing subscriptions.")
  @operationId("BillingSubscriptionsAliases_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BillingSubscriptionAlias>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the subscription aliases for a billing account. The operation is supported for seat based billing subscriptions.")
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
