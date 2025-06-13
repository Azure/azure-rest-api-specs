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

namespace Microsoft.StorageSync;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface StorageSyncServicesOperationGroup {
  /**
   * Check the give namespace name availability.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StorageSyncServices_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityParameters,
    Response = CheckNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The desired region for the name check.
       */
      @path
      @segment("locations")
      locationName: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationStatusOperationGroup {
  /**
   * Get Operation status
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OperationStatus_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/locations/{locationName}/workflows/{workflowId}/operations/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The desired region to obtain information from.
     */
    @path
    locationName: string,

    /**
     * workflow Id
     */
    @path
    workflowId: string,

    /**
     * operation Id
     */
    @path
    operationId: string,
  ): ArmResponse<OperationStatus> | ErrorResponse;
  /**
   * Get Operation status
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "For backward compatibility"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StorageSync/locations/{locationName}/operations/{operationId}")
  @get
  @operationId("LocationOperationStatus")
  locationOperationStatus(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The desired region to obtain information from.
     */
    @path
    locationName: string,

    /**
     * operation Id
     */
    @path
    operationId: string,
  ): ArmResponse<LocationOperationStatus> | ErrorResponse;
}
