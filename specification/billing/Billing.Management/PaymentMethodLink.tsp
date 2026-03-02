import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BillingProfile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Billing;
/**
 * A payment method link.
 */
@tenantResource
@parentResource(BillingProfile)
model PaymentMethodLink
  is Azure.ResourceManager.ProxyResource<PaymentMethodLinkProperties> {
  ...ResourceNameParameter<
    Resource = PaymentMethodLink,
    KeyName = "paymentMethodName",
    SegmentName = "paymentMethodLinks",
    NamePattern = ""
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations(#{ omitTags: true })
interface PaymentMethodLinks {
  /**
   * Gets a payment method linked with a billing profile. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("PaymentMethods")
  getByBillingProfile is ArmResourceRead<
    PaymentMethodLink,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists payment methods attached to a billing profile. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("PaymentMethods")
  listByBillingProfile is ArmResourceListByParent<
    PaymentMethodLink,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<PaymentMethodLinksListResult>
  >;
}

@@doc(PaymentMethodLink.name,
  "The ID that uniquely identifies a payment method."
);
@@doc(PaymentMethodLink.properties, "Payment method link properties");
