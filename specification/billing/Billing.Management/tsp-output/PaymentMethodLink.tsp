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
 * A payment method link.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@includeInapplicableMetadataInPayload(false)
model PaymentMethodLink extends Resource {
  /**
   * The ID that uniquely identifies a payment method.
   */
  @path
  @key("paymentMethodName")
  @segment("paymentMethodLinks")
  @visibility("read")
  name: string;

  /**
   * The properties of a payment method link.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PaymentMethodLinkProperties;
}

@armResourceOperations
interface PaymentMethodLinks {
  /**
   * Gets a payment method linked with a billing profile. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PaymentMethods_GetByBillingProfile")
  getByBillingProfile is ArmResourceRead<PaymentMethodLink>;

  /**
   * Deletes a payment method link and removes the payment method from a billing profile. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PaymentMethods_DeleteAtBillingProfile")
  deleteAtBillingProfile is ArmResourceDeleteAsync<PaymentMethodLink>;

  /**
   * Lists payment methods attached to a billing profile. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PaymentMethods_ListByBillingProfile")
  listByBillingProfile is ArmResourceListByParent<PaymentMethodLink>;
}
