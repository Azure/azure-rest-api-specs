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

namespace Microsoft.RecoveryServices;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface RecoveryServicesOperationGroup {
  /**
   * API to check for resource name availability.
   * A name is available if no other resource exists that has the same SubscriptionId, Resource Name and Type
   * or if one or more such resources exist, each of these must be GC'd and their time of deletion be more than 24 Hours Ago
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("""
    API to check for resource name availability.
    A name is available if no other resource exists that has the same SubscriptionId, Resource Name and Type
    or if one or more such resources exist, each of these must be GC'd and their time of deletion be more than 24 Hours Ago
    """)
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/locations/{location}/checkNameAvailability")
  @post
  checkNameAvailability(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...LocationResourceParameter,

    /**
     * Contains information about Resource type and Resource name
     */
    @bodyRoot
    input: CheckNameAvailabilityParameters,
  ): ArmResponse<CheckNameAvailabilityResult> | CloudError;

  /**
   * API to get details about capabilities provided by Microsoft.RecoveryServices RP
   */
  @summary("API to get details about capabilities provided by Microsoft.RecoveryServices RP")
  @autoRoute
  capabilities is ArmProviderActionSync<
    Request = ResourceCapabilities,
    Response = CapabilitiesResponse,
    Scope = SubscriptionActionScope,
    Parameters = {
      @path
      @segment("locations")
      @doc("The location of the resource.")
      location: string;
    },
    Error = CloudError
  >;
}
