import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Billing;
@doc("A billing subscription alias.")
@tenantResource
model BillingSubscriptionAlias
  is ProxyResource<BillingSubscriptionAliasProperties> {
  @doc("The ID that uniquely identifies a subscription alias.")
  @key("aliasName")
  @segment("billingSubscriptionAliases")
  name: string;
}

@armResourceOperations
interface BillingSubscriptionsAliases {
  @doc("Gets a subscription by its alias ID.  The operation is supported for seat based billing subscriptions.")
  get is ArmResourceRead<BillingSubscriptionAlias>;
  @doc("Creates or updates a billing subscription by its alias ID.  The operation is supported for seat based billing subscriptions.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BillingSubscriptionAlias>;
  @doc("Lists the subscription aliases for a billing account. The operation is supported for seat based billing subscriptions.")
  listByBillingAccount is ArmResourceListByParent<BillingSubscriptionAlias>;
}
