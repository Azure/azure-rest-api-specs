// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.DomainRegistration;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DomainsOperationGroup {
  /**
   * Description for Check if a domain is available for registration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Check if a domain is available for registration.")
  @operationId("Domains_CheckAvailability")
  @autoRoute
  @action("checkDomainAvailability")
  checkAvailability is ArmProviderActionSync<
    Request = NameIdentifier,
    Response = DomainAvailabilityCheckResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Description for Generate a single sign-on request for the domain management portal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Generate a single sign-on request for the domain management portal.")
  @operationId("Domains_GetControlCenterSsoRequest")
  @autoRoute
  @action("generateSsoRequest")
  getControlCenterSsoRequest is ArmProviderActionSync<
    Response = DomainControlCenterSsoRequest,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Description for Get domain name recommendations based on keywords.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get domain name recommendations based on keywords.")
  @operationId("Domains_ListRecommendations")
  @autoRoute
  @action("listDomainRecommendations")
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  listRecommendations is ArmProviderActionSync<
    Request = DomainRecommendationSearchParameters,
    Response = NameIdentifierCollection,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
