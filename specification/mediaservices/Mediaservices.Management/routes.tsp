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

namespace Microsoft.Media;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface LocationsOperationGroup {
  /**
   * Checks whether the Media Service resource name is available.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Check Name Availability")
  @operationId("Locations_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityInput,
    Response = EntityNameAvailabilityCheckOutput,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Location name.
       */
      @path
      @segment("locations")
      locationName: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface MediaServicesOperationStatusesOperationGroup {
  /**
   * Get media service operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get operation status.")
  @operationId("MediaServicesOperationStatuses_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Media/locations/{locationName}/mediaServicesOperationStatuses/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * Location name.
     */
    @path
    locationName: string,

    /**
     * Operation ID.
     */
    @path
    operationId: string,
  ): ArmResponse<MediaServiceOperationStatus> | ErrorResponse;
}
