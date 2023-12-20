import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Billing;
@doc("A payment method link.")
@tenantResource
model BillingPaymentMethodLink is ProxyResource<PaymentMethodLinkProperties> {
  @doc("The ID that uniquely identifies a payment method.")
  @path
  @key("paymentMethodName")
  @segment("paymentMethodLinks")
  name: string;
}

@armResourceOperations
interface BillingPaymentMethodLinks {
  @doc("Gets a payment method linked with a billing profile. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.")
  getByBillingProfile is ArmResourceRead<BillingPaymentMethodLink>;
  @doc("Deletes a payment method link and removes the payment method from a billing profile. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.")
  deleteAtBillingProfile is ArmResourceDeleteAsync<BillingPaymentMethodLink>;
  @doc("Lists payment methods attached to a billing profile. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.")
  listByBillingProfile is ArmResourceListByParent<BillingPaymentMethodLink>;
}
