import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Billing;
/**
 * A billing property.
 */
@singleton("default")
@subscriptionResource
model BillingProperty
  is Azure.ResourceManager.ProxyResource<BillingPropertyProperties> {
  ...ResourceNameParameter<
    Resource = BillingProperty,
    KeyName = "billingProperty",
    SegmentName = "billingProperty",
    NamePattern = ""
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

@armResourceOperations(#{ omitTags: true })
interface BillingProperties {
  /**
   * Gets the billing properties for a subscription
   */
  @tag("BillingProperty")
  get is ArmResourceRead<
    BillingProperty,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = BillingPropertyGetParameters
  >;

  /**
   * Updates the billing property of a subscription. Currently, cost center can be updated for billing accounts with agreement type Microsoft Customer Agreement and subscription service usage address can be updated for billing accounts with agreement type Microsoft Online Service Program.
   */
  @tag("BillingProperty")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    BillingProperty,
    PatchModel = BillingProperty,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

alias BillingPropertyGetParameters = {
  /**
   * A flag that specifies whether or not to include billing country.
   */
  @query("includeBillingCountry")
  includeBillingCountry?: boolean = false;

  /**
   * A flag that specifies whether or not to include transition status for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @query("includeTransitionStatus")
  includeTransitionStatus?: boolean = false;

  /**
   * A flag that specifies whether or not to include payment instrument.
   */
  @added(Versions.v2024_08_01_preview)
  @query("includePaymentInstrument")
  includePaymentInstrument?: boolean = false;

  /**
   * A flag that specifies whether or not to include soldTo address.
   */
  @added(Versions.v2024_08_01_preview)
  @query("includeAddress")
  includeAddress?: boolean = false;
};

@@doc(BillingProperty.name, "");
@@doc(BillingProperty.properties, "A billing property.");
@@doc(BillingProperties.update::parameters.properties, "A billing property.");
