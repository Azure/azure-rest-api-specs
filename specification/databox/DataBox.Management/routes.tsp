// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBox;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ServiceOperationGroup {
  /**
   * This API provides configuration details specific to given region/location at Subscription level.
   */
  @autoRoute
  regionConfiguration is ArmProviderActionSync<
    Request = RegionConfigurationRequest,
    Response = RegionConfigurationResponse,
    Scope = SubscriptionActionScope,
    Parameters = LocationResourceParameter,
    Error = ApiError
  >;

  /**
   * [DEPRECATED NOTICE: This operation will soon be removed]. This method validates the customer shipping address and provide alternate addresses if any.
   */
  #deprecated "This operation will soon be removed"
  @autoRoute
  validateAddress is ArmProviderActionSync<
    Request = ValidateAddress,
    Response = AddressValidationOutput,
    Scope = SubscriptionActionScope,
    Parameters = LocationResourceParameter,
    Error = ApiError
  >;

  /**
   * This method does all necessary pre-job creation validation under subscription.
   */
  @autoRoute
  validateInputs is ArmProviderActionSync<
    Request = ValidationRequest,
    Response = ValidationResponse,
    Scope = SubscriptionActionScope,
    Parameters = LocationResourceParameter,
    Error = ApiError
  >;

  /**
   * This method provides the list of available skus for the given subscription, resource group and location.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/locations/{location}/availableSkus")
  @post
  @list
  listAvailableSkusByResourceGroup(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...LocationResourceParameter,

    /**
     * Filters for showing the available skus.
     */
    @bodyRoot
    availableSkuRequest: AvailableSkuRequest,
  ): ArmResponse<AvailableSkusResult> | ApiError;

  /**
   * This API provides configuration details specific to given region/location at Resource group level.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/locations/{location}/regionConfiguration")
  @post
  regionConfigurationByResourceGroup(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...LocationResourceParameter,

    /**
     * Request body to get the configuration for the region at resource group level.
     */
    @bodyRoot
    regionConfigurationRequest: RegionConfigurationRequest,
  ): ArmResponse<RegionConfigurationResponse> | ApiError;

  /**
   * This method does all necessary pre-job creation validation under resource group.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/locations/{location}/validateInputs")
  @post
  validateInputsByResourceGroup(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...LocationResourceParameter,

    /**
     * Inputs of the customer.
     */
    @bodyRoot
    validationRequest: ValidationRequest,
  ): ArmResponse<ValidationResponse> | ApiError;
}
