import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Billing;
@doc("A payment method.")
@tenantResource
model BillingPaymentMethod is ProxyResource<PaymentMethodProperties> {
  @doc("The ID that uniquely identifies a payment method.")
  @path
  @key("paymentMethodName")
  @segment("paymentMethods")
  name: string;
}

@armResourceOperations
interface BillingPaymentMethods {
  @doc("Gets a payment method owned by the caller.")
  getByUser is ArmResourceRead<BillingPaymentMethod>;
  @doc("Deletes a payment method owned by the caller.")
  deleteByUser is ArmResourceDeleteSync<BillingPaymentMethod>;
  @doc("Lists the payment methods owned by the caller.")
  listByUser is ArmResourceListByParent<BillingPaymentMethod>;
}
