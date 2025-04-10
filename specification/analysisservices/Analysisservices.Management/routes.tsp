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

namespace Microsoft.AnalysisServices;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ServersOperationGroup {
  /**
   * Lists eligible SKUs for Analysis Services resource provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Servers_ListSkusForNew")
  @autoRoute
  @get
  @action("skus")
  listSkusForNew is ArmProviderActionSync<
    Response = SkuEnumerationForNewResourceResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Check the name availability in the target location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Servers_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckServerNameAvailabilityParameters,
    Response = CheckServerNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
  /**
   * List the result of the specified operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Servers_ListOperationResults")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AnalysisServices/locations/{location}/operationresults/{operationId}")
  @get
  listOperationResults(
    ...ApiVersionParameter,
    ...LocationResourceParameter,

    /**
     * The target operation Id.
     */
    @path
    operationId: string,

    ...SubscriptionIdParameter,
  ): OkResponse | ArmAcceptedResponse | ErrorResponse;

  /**
   * List the status of operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Servers_ListOperationStatuses")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AnalysisServices/locations/{location}/operationstatuses/{operationId}")
  @get
  listOperationStatuses(
    ...ApiVersionParameter,
    ...LocationResourceParameter,

    /**
     * The target operation Id.
     */
    @path
    operationId: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<OperationStatus> | ErrorResponse;
}
