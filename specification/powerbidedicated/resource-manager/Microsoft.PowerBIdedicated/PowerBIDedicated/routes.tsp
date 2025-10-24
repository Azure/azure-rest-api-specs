import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.PowerBIDedicated;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface CapacitiesOperationGroup {
  /**
   * Lists eligible SKUs for PowerBI Dedicated resource provider.
   */
  @autoRoute
  @get
  @action("skus")
  listSkus is ArmProviderActionSync<
    Response = SkuEnumerationForNewResourceResult,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = ErrorResponse
  >;
  /**
   * Check the name availability in the target location.
   */
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckCapacityNameAvailabilityParameters,
    Response = CheckCapacityNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = ErrorResponse
  >;
}
