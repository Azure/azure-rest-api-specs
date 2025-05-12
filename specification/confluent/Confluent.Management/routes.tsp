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

namespace Microsoft.Confluent;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface MarketplaceAgreementsOperationGroup {
  /**
   * List Confluent marketplace agreements in the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List Confluent marketplace agreements in the subscription.")
  @operationId("MarketplaceAgreements_List")
  @autoRoute
  @get
  @action("agreements")
  list is ArmProviderActionSync<
    Response = ConfluentAgreementResourceListResponse,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = ResourceProviderDefaultErrorResponse
  >;
  /**
   * Create Confluent Marketplace agreement in the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Create Confluent Marketplace agreement in the subscription.")
  @operationId("MarketplaceAgreements_Create")
  @autoRoute
  @put
  @action("agreements/default")
  create is ArmProviderActionSync<
    Request = ConfluentAgreementResource,
    Response = ConfluentAgreementResource,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = ResourceProviderDefaultErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ValidationsOperationGroup {
  /**
   * Organization Validate proxy resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Organization Validate proxy resource")
  @operationId("Validations_ValidateOrganization")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Confluent/validations/{organizationName}/orgvalidate")
  @post
  validateOrganization(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Organization resource name
     */
    @path
    organizationName: string,

    /**
     * Organization resource model
     */
    @bodyRoot
    body: OrganizationResource,
  ): ArmResponse<OrganizationResource> | ResourceProviderDefaultErrorResponse;

  /**
   * Organization Validate proxy resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Organization Validate proxy resource")
  @operationId("Validations_ValidateOrganizationV2")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Confluent/validations/{organizationName}/orgvalidateV2")
  @post
  validateOrganizationV2(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Organization resource name
     */
    @path
    organizationName: string,

    /**
     * Organization resource model
     */
    @bodyRoot
    body: OrganizationResource,
  ): ArmResponse<ValidationResponse> | ResourceProviderDefaultErrorResponse;
}
