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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DomainsOperationGroup {
  /**
   * Description for Check if a domain is available for registration.
   */
  @summary("Check if a domain is available for registration.")
  @autoRoute
  @action("checkDomainAvailability")
  checkAvailability is ArmProviderActionSync<
    Request = NameIdentifier,
    Response = DomainAvailabilityCheckResult,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Generate a single sign-on request for the domain management portal.
   */
  @summary("Generate a single sign-on request for the domain management portal.")
  @autoRoute
  @action("generateSsoRequest")
  getControlCenterSsoRequest is ArmProviderActionSync<
    Response = DomainControlCenterSsoRequest,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get domain name recommendations based on keywords.
   */
  @summary("Get domain name recommendations based on keywords.")
  @autoRoute
  @action("listDomainRecommendations")
  @list
  listRecommendations is ArmProviderActionSync<
    Request = DomainRecommendationSearchParameters,
    Response = NameIdentifierCollection,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = DefaultErrorResponse
  >;
}
