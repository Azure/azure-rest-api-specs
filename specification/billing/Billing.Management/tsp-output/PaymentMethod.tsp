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
 * A payment method.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@includeInapplicableMetadataInPayload(false)
model PaymentMethod extends Resource {
  /**
   * The ID that uniquely identifies a payment method.
   */
  @path
  @key("paymentMethodName")
  @segment("paymentMethods")
  @visibility("read")
  name: string;

  /**
   * The properties of a payment method.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PaymentMethodProperties;
}

@armResourceOperations
interface PaymentMethods {
  /**
   * Gets a payment method owned by the caller.
   */
  getByUser is ArmResourceRead<PaymentMethod>;

  /**
   * Deletes a payment method owned by the caller.
   */
  deleteByUser is ArmResourceDeleteSync<PaymentMethod>;

  /**
   * Lists the payment methods owned by the caller.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PaymentMethods_ListByUser")
  listByUser is ArmResourceListByParent<PaymentMethod>;
}
