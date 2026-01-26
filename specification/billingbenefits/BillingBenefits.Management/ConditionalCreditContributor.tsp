import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConditionalCredit.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.BillingBenefits;
/**
 * Conditional credit contributor
 */
@parentResource(ConditionalCredit)
model ConditionalCreditContributor
  is Azure.ResourceManager.ProxyResource<ContributorConditionalCreditProperties> {
  ...ResourceNameParameter<
    Resource = ConditionalCreditContributor,
    KeyName = "contributorName",
    SegmentName = "contributors",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;
}

@armResourceOperations
interface ConditionalCreditContributors {
  /**
   * Get a conditional credit contributor for primary service admin
   */
  getFromPrimary is ArmResourceRead<ConditionalCreditContributor>;

  /**
   * List contributors under a primary conditional credit for primary service admin
   */
  listFromPrimary is ArmResourceListByParent<
    ConditionalCreditContributor,
    Response = ArmResponse<ConditionalCreditContributorList>
  >;
}

@@doc(ConditionalCreditContributor.name,
  "Unique name of contributor in the format {contributorCloudSubId}_{resourceGroupName}_{nameInContributorTenant}."
);
@@doc(ConditionalCreditContributor.properties,
  "Conditional credit contributor properties"
);
