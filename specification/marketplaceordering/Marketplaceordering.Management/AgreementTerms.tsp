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
@singleton("current")
@subscriptionResource
model AgreementTerms
  is Azure.ResourceManager.ProxyResource<AgreementProperties> {
  ...ResourceNameParameter<
    Resource = AgreementTerms,
    KeyName = "agreement",
    SegmentName = "agreements",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MarketplaceAgreements {
  /**
   * Get marketplace terms.
   */
  get is ArmResourceRead<
    AgreementTerms,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Save marketplace terms.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceSync<
    AgreementTerms,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResourceUpdatedResponse<AgreementTerms>
  >;
}

@@doc(AgreementTerms.name, "");
@@doc(AgreementTerms.properties, "Represents the properties of the resource.");
@@doc(MarketplaceAgreements.create::parameters.resource,
  "Parameters supplied to the Create Marketplace Terms operation."
);
