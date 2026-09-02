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

namespace Microsoft.HealthcareApis;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ServicesOperationGroup {
  /**
   * Check if a service instance name is available.
   */
  @tag("Proxy")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityParameters,
    Response = ServicesNameAvailabilityInfo,
    Scope = SubscriptionActionScope,
    Error = ErrorDetails
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OperationResultsOperationGroup {
  /**
   * Get the operation result for a long running operation.
   */
  @tag("Proxy")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HealthcareApis/locations/{locationName}/operationresults/{operationResultId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The location of the operation.
     */
    @path
    locationName: string,

    /**
     * The ID of the operation result to get.
     */
    @path
    operationResultId: string,
  ): ArmResponse<OperationResultsDescription> | ErrorDetails;
}
