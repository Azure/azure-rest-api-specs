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

namespace Microsoft.HybridCompute;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface LicensesOperationGroup {
  /**
   * The operation to validate a license.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Licenses_ValidateLicense")
  @autoRoute
  validateLicense is ArmProviderActionAsync<
    Request = License,
    Response = License,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ExtensionTypeOperationGroup {
  /**
   * Gets all Extension types based on location and publisher
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExtensionType_List")
  @autoRoute
  @get
  @action("extensionTypes")
  list is ArmProviderActionSync<
    Response = ExtensionTypeListResult,
    Parameters = {
      ...LocationParameter;

      /**
       * The publisher of the Extension being received.
       */
      @path
      @segment("publishers")
      publisher: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ExtensionPublisherOperationGroup {
  /**
   * Gets all Extension publishers based on the location
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExtensionPublisher_List")
  @autoRoute
  @get
  @action("publishers")
  list is ArmProviderActionSync<
    Response = ExtensionPublisherListResult,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PrivateLinkScopesOperationGroup {
  /**
   * Returns a Azure Arc PrivateLinkScope's validation details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkScopes_GetValidationDetails")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HybridCompute/locations/{location}/privateLinkScopes/{privateLinkScopeId}")
  @get
  getValidationDetails(
    ...ApiVersionParameter,
    ...LocationResourceParameter,
    ...SubscriptionIdParameter,

    /**
     * The id (Guid) of the Azure Arc PrivateLinkScope resource.
     */
    @path
    privateLinkScopeId: string,
  ): ArmResponse<PrivateLinkScopeValidationDetails> | ErrorResponse;
}
