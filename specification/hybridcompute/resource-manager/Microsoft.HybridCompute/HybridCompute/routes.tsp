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

alias LicensesOps = Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Legacy.Provider;
  },
  {},
  {}
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface LicensesOperationGroup {
  /**
   * The operation to validate a license.
   */
  @tag("licenses")
  @autoRoute
  @action("validateLicense")
  validateLicense is LicensesOps.ActionAsync<
    License,
    Request = License,
    Result = void,
    Response = ArmResponse<License> &
      ArmLroLocationHeader<FinalResult = License> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ExtensionTypeOperationGroup {
  /**
   * Gets all Extension types based on location and publisher
   */
  @tag("extensions")
  @autoRoute
  @list
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ExtensionPublisherOperationGroup {
  /**
   * Gets all Extension publishers based on the location
   */
  @tag("extensions")
  @autoRoute
  @list
  @get
  @action("publishers")
  list is ArmProviderActionSync<
    Response = ExtensionPublisherListResult,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface PrivateLinkScopesOperationGroup {
  /**
   * Returns a Azure Arc PrivateLinkScope's validation details.
   */
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
