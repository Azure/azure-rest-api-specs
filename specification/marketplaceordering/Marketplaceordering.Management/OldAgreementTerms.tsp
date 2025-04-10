import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MarketplaceOrdering;
/**
 * Terms properties for provided Publisher/Offer/Plan tuple
 */
@subscriptionResource
model OldAgreementTerms
  is Azure.ResourceManager.ProxyResource<OldAgreementProperties> {
  ...ResourceNameParameter<
    Resource = OldAgreementTerms,
    KeyName = "planId",
    SegmentName = "plans",
    NamePattern = ""
  >;
}

@armResourceOperations
interface OldAgreementTermsOperationGroup {
  /**
   * Get marketplace agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MarketplaceAgreements_GetAgreement")
  getAgreement is ArmResourceRead<
    OldAgreementTerms,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * List marketplace agreements in the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MarketplaceAgreements_List")
  list is ArmResourceListByParent<
    OldAgreementTerms,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<OldAgreementTermsList>
  >;

  /**
   * Sign marketplace terms.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MarketplaceAgreements_Sign")
  sign is ArmResourceActionSync<
    OldAgreementTerms,
    void,
    ArmResponse<OldAgreementTerms>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Cancel marketplace terms.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MarketplaceAgreements_Cancel")
  cancel is ArmResourceActionSync<
    OldAgreementTerms,
    void,
    ArmResponse<OldAgreementTerms>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(OldAgreementTerms.name,
  "Plan identifier string of image being deployed."
);
@@doc(OldAgreementTerms.properties,
  "Represents the properties of the resource."
);
