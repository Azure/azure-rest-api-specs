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

namespace Microsoft.Web;

/**
 * Description for get a list of available ASE regions and its supported Skus.
 */
@summary("Get a list of available ASE regions and its supported Skus.")
@autoRoute
@get
@action("aseRegions")
op listAseRegions is ArmProviderActionSync<
  Response = AseRegionCollection,
  Scope = SubscriptionActionScope,
  Parameters = {}
>;

/**
 * Description for Gets a list of meters for a given location.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@summary("Gets a list of meters for a given location.")
@autoRoute
@get
@action("billingMeters")
op listBillingMeters is ArmProviderActionSync<
  Response = BillingMeterCollection,
  Scope = SubscriptionActionScope,
  Parameters = {
    /**
     * Azure Location of billable resource
     */
    @query("billingLocation")
    billingLocation?: string;

    /**
     * App Service OS type meters used for
     */
    @query("osType")
    osType?: string;
  }
>;

/**
 * Description for Check if a resource name is available.
 */
@summary("Check if a resource name is available.")
@autoRoute
@action("checknameavailability")
op checkNameAvailability is ArmProviderActionSync<
  Request = ResourceNameAvailabilityRequest,
  Response = ResourceNameAvailability,
  Scope = SubscriptionActionScope,
  Parameters = {}
>;

/**
 * Get custom hostnames under this subscription
 */
@summary("Get custom hostnames under this subscription")
@autoRoute
@get
@action("customhostnameSites")
op listCustomHostNameSites is ArmProviderActionSync<
  Response = CustomHostnameSitesCollection,
  Scope = SubscriptionActionScope,
  Parameters = {
    /**
     * Specific hostname
     */
    @query("hostname")
    hostname?: string;
  }
>;

/**
 * Description for Get a list of available geographical regions.
 */
@summary("Get a list of available geographical regions.")
@autoRoute
@get
@action("geoRegions")
op listGeoRegions is ArmProviderActionSync<
  Response = GeoRegionCollection,
  Scope = SubscriptionActionScope,
  Parameters = {
    /**
     * Name of SKU used to filter the regions.
     */
    @query("sku")
    sku?: SkuName;

    /**
     * Specify <code>true</code> if you want to filter to only regions that support Linux workers.
     */
    @query("linuxWorkersEnabled")
    linuxWorkersEnabled?: boolean;

    /**
     * Specify <code>true</code> if you want to filter to only regions that support Xenon workers.
     */
    @query("xenonWorkersEnabled")
    xenonWorkersEnabled?: boolean;

    /**
     * Specify <code>true</code> if you want to filter to only regions that support Linux Consumption Workers.
     */
    @query("linuxDynamicWorkersEnabled")
    linuxDynamicWorkersEnabled?: boolean;
  }
>;

/**
 * Description for List all apps that are assigned to a hostname.
 */
@summary("List all apps that are assigned to a hostname.")
@autoRoute
@action("listSitesAssignedToHostName")
op listSiteIdentifiersAssignedToHostName is ArmProviderActionSync<
  Request = NameIdentifier,
  Response = IdentifierCollection,
  Scope = SubscriptionActionScope,
  Parameters = {}
>;

/**
 * Check if a resource name is available for DNL sites.
 */
@summary("Check if a resource name is available for DNL sites.")
@autoRoute
@action("checknameavailability")
op regionalCheckNameAvailability is ArmProviderActionSync<
  Request = DnlResourceNameAvailabilityRequest,
  Response = DnlResourceNameAvailability,
  Scope = SubscriptionActionScope,
  Parameters = LocationParameter
>;

/**
 * Description for List all premier add-on offers.
 */
@summary("List all premier add-on offers.")
@autoRoute
@get
@action("premieraddonoffers")
op listPremierAddOnOffers is ArmProviderActionSync<
  Response = PremierAddOnOfferCollection,
  Scope = SubscriptionActionScope,
  Parameters = {}
>;

/**
 * Description for List all SKUs.
 */
@summary("List all SKUs.")
@autoRoute
@get
@action("skus")
op listSkus is ArmProviderActionSync<
  Response = SkuInfos,
  Scope = SubscriptionActionScope,
  Parameters = {}
>;

/**
 * Description for Verifies if this VNET is compatible with an App Service Environment by analyzing the Network Security Group rules.
 */
@summary("Verifies if this VNET is compatible with an App Service Environment by analyzing the Network Security Group rules.")
@autoRoute
op verifyHostingEnvironmentVnet is ArmProviderActionSync<
  Request = VnetParameters,
  Response = VnetValidationFailureDetails,
  Scope = SubscriptionActionScope,
  Parameters = {}
>;

/**
 * Description for Move resources between resource groups.
 */
@summary("Move resources between resource groups.")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/moveResources")
@post
op move(
  ...ApiVersionParameter,
  ...ResourceGroupParameter,
  ...SubscriptionIdParameter,

  /**
   * Object that represents the resource to move.
   */
  @bodyRoot
  moveResourceEnvelope: CsmMoveResourceEnvelope,
): NoContentResponse | ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface GlobalOperationGroup {
  /**
   * Description for Gets an operation in a subscription and given region
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets an operation in a subscription and given region")
  @operationId("Global_GetSubscriptionOperationWithAsyncResponse")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/locations/{location}/operations/{operationId}")
  @get
  getSubscriptionOperationWithAsyncResponse(
    ...ApiVersionParameter,
    ...LocationResourceParameter,

    /**
     * Operation Id
     */
    @path
    operationId: string,

    ...SubscriptionIdParameter,
  ): NoContentResponse | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ProviderOperationGroup {
  /**
   * Description for Get available application frameworks and their versions
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get available application frameworks and their versions")
  @operationId("Provider_GetAvailableStacks")
  @autoRoute
  @get
  @action("availableStacks")
  getAvailableStacks is ArmProviderActionSync<
    Response = ApplicationStackCollection,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("osTypeSelected")
      osTypeSelected?: ProviderOsTypeSelected;
    }
  >;
  /**
   * Description for Get available Function app frameworks and their versions
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get available Function app frameworks and their versions")
  @operationId("Provider_GetFunctionAppStacks")
  @autoRoute
  @get
  @action("functionAppStacks")
  getFunctionAppStacks is ArmProviderActionSync<
    Response = FunctionAppStackCollection,
    Parameters = {
      /**
       * Stack OS Type
       */
      @query("stackOsType")
      stackOsType?: ProviderStackOsType;
    }
  >;
  /**
   * Description for Get available Function app frameworks and their versions for location
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get available Function app frameworks and their versions for location")
  @operationId("Provider_GetFunctionAppStacksForLocation")
  @autoRoute
  @get
  @action("functionAppStacks")
  getFunctionAppStacksForLocation is ArmProviderActionSync<
    Response = FunctionAppStackCollection,
    Parameters = {
      ...LocationParameter;

      /**
       * Stack OS Type
       */
      @query("stackOsType")
      stackOsType?: ProviderStackOsType;
    }
  >;
  /**
   * Description for Get available Web app frameworks and their versions for location
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get available Web app frameworks and their versions for location")
  @operationId("Provider_GetWebAppStacksForLocation")
  @autoRoute
  @get
  @action("webAppStacks")
  getWebAppStacksForLocation is ArmProviderActionSync<
    Response = WebAppStackCollection,
    Parameters = {
      ...LocationParameter;

      /**
       * Stack OS Type
       */
      @query("stackOsType")
      stackOsType?: ProviderStackOsType;
    }
  >;
  /**
   * Description for Get available Web app frameworks and their versions
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get available Web app frameworks and their versions")
  @operationId("Provider_GetWebAppStacks")
  @autoRoute
  @get
  @action("webAppStacks")
  getWebAppStacks is ArmProviderActionSync<
    Response = WebAppStackCollection,
    Parameters = {
      /**
       * Stack OS Type
       */
      @query("stackOsType")
      stackOsType?: ProviderStackOsType;
    }
  >;
  /**
   * Description for Get available application frameworks and their versions
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get available application frameworks and their versions")
  @operationId("Provider_GetAvailableStacksOnPrem")
  @autoRoute
  @get
  @action("availableStacks")
  getAvailableStacksOnPrem is ArmProviderActionSync<
    Response = ApplicationStackCollection,
    Scope = SubscriptionActionScope,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("osTypeSelected")
      osTypeSelected?: ProviderOsTypeSelected;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface RecommendationsOperationGroup {
  /**
   * Description for List all recommendations for a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List all recommendations for a subscription.")
  @operationId("Recommendations_List")
  @autoRoute
  @get
  @action("recommendations")
  list is ArmProviderActionSync<
    Response = RecommendationCollection,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Specify <code>true</code> to return only the most critical recommendations. The default is <code>false</code>, which returns all recommendations.
       */
      @query("featured")
      featured?: boolean;

      /**
       * Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification' and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[PT1H|PT1M|P1D]
       */
      @query("$filter")
      $filter?: string;
    }
  >;
  /**
   * Description for Reset all recommendation opt-out settings for a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Reset all recommendation opt-out settings for a subscription.")
  @operationId("Recommendations_ResetAllFilters")
  @autoRoute
  @action("recommendations/reset")
  resetAllFilters is ArmProviderActionSync<
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Description for Disables the specified rule so it will not apply to a subscription in the future.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Disables the specified rule so it will not apply to a subscription in the future.")
  @operationId("Recommendations_DisableRecommendationForSubscription")
  @autoRoute
  @action("disable")
  disableRecommendationForSubscription is ArmProviderActionSync<
    Response = {
      @body body: void;
    },
    Scope = SubscriptionActionScope,
    Parameters = {
      // /**
      //  * Rule name
      //  */
      // @path
      // @segment("recommendations")
      // name: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ResourceHealthMetadataNonResourceOperationGroup {
  /**
   * Description for List all ResourceHealthMetadata for all sites in the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List all ResourceHealthMetadata for all sites in the subscription.")
  @operationId("ResourceHealthMetadata_List")
  @autoRoute
  @get
  @action("resourceHealthMetadata")
  list is ArmProviderActionSync<
    Response = ResourceHealthMetadataCollection,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Description for List all ResourceHealthMetadata for all sites in the resource group in the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List all ResourceHealthMetadata for all sites in the resource group in the subscription.")
  @operationId("ResourceHealthMetadata_ListByResourceGroup")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/resourceHealthMetadata")
  @get
  listByResourceGroup(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,
  ): ArmResponse<ResourceHealthMetadataCollection> | ErrorResponse;

  /**
   * Description for Gets list of available geo regions plus ministamps
   */
  @summary("Gets list of available geo regions plus ministamps")
  @autoRoute
  @get
  @action("deploymentLocations")
  getSubscriptionDeploymentLocations is ArmProviderActionSync<
    Response = DeploymentLocations,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;

  /**
   * Description for Validate if a resource can be created.
   */
  @summary("Validate if a resource can be created.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/validate")
  @post
  validate(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * Request with the resources to validate.
     */
    @bodyRoot
    validateRequest: ValidateRequest,
  ): ArmResponse<ValidateResponse> | ErrorResponse;

  /**
   * Description for Validate whether a resource can be moved.
   */
  @summary("Validate whether a resource can be moved.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/validateMoveResources")
  @post
  validateMove(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * Object that represents the resource to move.
     */
    @bodyRoot
    moveResourceEnvelope: CsmMoveResourceEnvelope,
  ): ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface GetUsagesInLocationOperationGroup {
  /**
   * List usages in cores for all skus used by a subscription in a given location, for a specific quota type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Lists subscription core usages for all skus used in a location, for a given type of quota.")
  @operationId("GetUsagesInLocation_list")
  @autoRoute
  @get
  @action("usages")
  list is ArmProviderActionSync<
    Response = CsmUsageQuotaCollection,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface StaticSitesOperationGroup {
  /**
   * Description for Generates a preview workflow file for the static site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Generates a preview workflow file for the static site")
  @operationId("StaticSites_PreviewWorkflow")
  @autoRoute
  @action("previewStaticSiteWorkflowFile")
  previewWorkflow is ArmProviderActionSync<
    Request = StaticSitesWorkflowPreviewRequest,
    Response = StaticSitesWorkflowPreview,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
