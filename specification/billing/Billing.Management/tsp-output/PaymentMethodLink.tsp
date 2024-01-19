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
@doc("A payment method link.")
@tenantResource
model PaymentMethodLink is ProxyResource<PaymentMethodLinkProperties> {
  @doc("The ID that uniquely identifies a payment method.")
  @path
  @key("paymentMethodName")
  @segment("paymentMethodLinks")
  name: string;
}

@armResourceOperations
interface PaymentMethodLinks {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a payment method linked with a billing profile. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.")
  @operationId("PaymentMethods_GetByBillingProfile")
  getByBillingProfile is ArmResourceRead<PaymentMethodLink>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a payment method link and removes the payment method from a billing profile. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.")
  @operationId("PaymentMethods_DeleteAtBillingProfile")
  deleteAtBillingProfile is ArmResourceDeleteAsync<PaymentMethodLink>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists payment methods attached to a billing profile. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.")
  @operationId("PaymentMethods_ListByBillingProfile")
  listByBillingProfile is ArmResourceListByParent<PaymentMethodLink>;
}
