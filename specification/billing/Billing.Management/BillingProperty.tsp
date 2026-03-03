import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations(#{ omitTags: true })
interface BillingProperties {
  /**
   * Gets the billing properties for a subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingProperty")
  get is ArmResourceRead<
    BillingProperty,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
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
    }
  >;

  /**
   * Updates the billing property of a subscription. Currently, cost center can be updated for billing accounts with agreement type Microsoft Customer Agreement and subscription service usage address can be updated for billing accounts with agreement type Microsoft Online Service Program.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingProperty")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    BillingProperty,
    PatchModel = BillingProperty,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(BillingProperty.name, "");
@@doc(BillingProperty.properties, "A billing property.");
@@doc(BillingProperties.update::parameters.properties, "A billing property.");
