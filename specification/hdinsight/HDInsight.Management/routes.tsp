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

namespace Microsoft.HDInsight;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface LocationsOperationGroup {
  /**
   * Gets the capabilities for the specified location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Locations_GetCapabilities")
  @autoRoute
  @get
  @action("capabilities")
  getCapabilities is ArmProviderActionSync<
    Response = ArmResponse<CapabilitiesResult>,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = ErrorResponse
  >;
  /**
   * Lists the usages for the specified location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Locations_ListUsages")
  @autoRoute
  @get
  @action("usages")
  listUsages is ArmProviderActionSync<
    Response = ArmResponse<UsagesListResult>,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = ErrorResponse
  >;
  /**
   * Lists the billingSpecs for the specified subscription and location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Locations_ListBillingSpecs")
  @autoRoute
  @get
  @action("billingSpecs")
  listBillingSpecs is ArmProviderActionSync<
    Response = BillingResponseListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = ErrorResponse
  >;
  /**
   * Get the async operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Locations_GetAzureAsyncOperationStatus")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HDInsight/locations/{location}/azureasyncoperations/{operationId}")
  @get
  getAzureAsyncOperationStatus(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The long running operation id.
     */
    @path
    operationId: string,
  ): ArmResponse<AsyncOperationResult> | ErrorResponse;

  /**
   * Check the cluster name is available or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Locations_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = NameAvailabilityCheckRequestParameters,
    Response = NameAvailabilityCheckResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = ErrorResponse
  >;
  /**
   * Validate the cluster create request spec is valid or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Locations_ValidateClusterCreateRequest")
  @autoRoute
  @action("validateCreateRequest")
  validateClusterCreateRequest is ArmProviderActionSync<
    Request = ClusterCreateRequestValidationParameters,
    Response = ClusterCreateValidationResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = ErrorResponse
  >;
}
