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

namespace Microsoft.Orbital;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AvailableGroundStationsOperationGroup {
  /**
   * Returns list of available ground stations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AvailableGroundStations_ListByCapability")
  @autoRoute
  @get
  @action("availableGroundStations")
  listByCapability is ArmProviderActionSync<
    Response = AvailableGroundStationListResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Ground Station Capability.
       */
      @query("capability")
      capability: CapabilityParameter;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationsResultsOperationGroup {
  /**
   * Returns operation results.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OperationsResults_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Orbital/locations/{location}/operationResults/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,
    ...CommonTypes.OperationIdParameter,
  ): (ArmResponse<OperationResult> &
    ArmLroLocationHeader) | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> | ErrorResponse;
}
