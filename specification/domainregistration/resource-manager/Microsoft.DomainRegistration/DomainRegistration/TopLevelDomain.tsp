import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DomainRegistration;
/**
 * A top level domain object.
 */
@subscriptionResource
model TopLevelDomain
  is Azure.ResourceManager.ProxyResource<TopLevelDomainProperties> {
  ...ResourceNameParameter<
    Resource = TopLevelDomain,
    KeyName = "name",
    SegmentName = "topLevelDomains",
    NamePattern = ""
  >;

  /**
   * Kind of resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface TopLevelDomains {
  /**
   * Description for Get details of a top-level domain.
   */
  @summary("Get details of a top-level domain.")
  get is ArmResourceRead<
    TopLevelDomain,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get all top-level domains supported for registration.
   */
  @summary("Get all top-level domains supported for registration.")
  list is ArmResourceListByParent<
    TopLevelDomain,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<TopLevelDomainCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets all legal agreements that user needs to accept before purchasing a domain.
   */
  @list
  @summary("Gets all legal agreements that user needs to accept before purchasing a domain.")
  listAgreements is ArmResourceActionSync<
    TopLevelDomain,
    TopLevelDomainAgreementOption,
    ArmResponse<TldLegalAgreementCollection>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = DefaultErrorResponse
  >;
}

@@doc(TopLevelDomain.name, "Name of the top-level domain.");
@@doc(TopLevelDomain.properties, "TopLevelDomain resource specific properties");
@@doc(TopLevelDomains.listAgreements::parameters.body,
  "Domain agreement options."
);
