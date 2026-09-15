import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "./models.tsp";
import "./BillingProfile.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;

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
    NamePattern = PaymentMethodPattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

alias PaymentMethodLinkOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The ID that uniquely identifies a billing account. */
    @path
    @segment("billingAccounts")
    @key
    @pattern(BillingAccountNamePattern)
    billingAccountName: string;

    /** The ID that uniquely identifies a billing profile. */
    @path
    @segment("billingProfiles")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    billingProfileName: string;
  },
  {
    /** The ID that uniquely identifies a payment method. */
    @path
    @segment("paymentMethodLinks")
    @key
    @pattern(PaymentMethodPattern)
    paymentMethodName: string;
  }
>;

alias PaymentMethodLinkByBillingAccountOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing";

    /** The ID that uniquely identifies a billing account. */
    @path
    @segment("billingAccounts")
    @key
    @pattern(BillingAccountNamePattern)
    billingAccountName: string;
  },
  {},
  {},
  "BillingAccountPaymentMethodLink"
>;

@armResourceOperations(#{ omitTags: true })
interface PaymentMethodLinks {
  /**
   * Lists payment methods attached to a billing account. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("PaymentMethods")
  listByBillingAccount is PaymentMethodLinkByBillingAccountOps.List<
    PaymentMethodLink,
    Parameters = DefaultODataParameters,
    Response = ArmResponse<PaymentMethodLinksListResult>
  >;

  /**
   * Gets a payment method linked with a billing profile. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("PaymentMethods")
  getByBillingProfile is PaymentMethodLinkOps.Read<PaymentMethodLink>;

  /**
   * Deletes a payment method link and removes the payment method from a billing profile. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("PaymentMethods")
  deleteAtBillingProfile is PaymentMethodLinkOps.DeleteWithoutOkAsync<PaymentMethodLink>;

  /**
   * Lists payment methods attached to a billing profile. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("PaymentMethods")
  listByBillingProfile is PaymentMethodLinkOps.List<
    PaymentMethodLink,
    Response = ArmResponse<PaymentMethodLinksListResult>
  >;
}

@@doc(
  PaymentMethodLink.name,
  "The ID that uniquely identifies a payment method."
);
@@doc(PaymentMethodLink.properties, "Payment method link properties");
