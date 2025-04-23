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

namespace Microsoft.PowerBIDedicated;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface CapacitiesOperationGroup {
  /**
   * Lists eligible SKUs for PowerBI Dedicated resource provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Capacities_ListSkus")
  @autoRoute
  @get
  @action("skus")
  listSkus is ArmProviderActionSync<
    Response = SkuEnumerationForNewResourceResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Check the name availability in the target location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Capacities_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckCapacityNameAvailabilityParameters,
    Response = CheckCapacityNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
