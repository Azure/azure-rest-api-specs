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
 * Description for Validate whether a resource can be moved.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("Validate whether a resource can be moved.")
@summary("Validate whether a resource can be moved.")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/validateMoveResources")
@post
op validateMove(
  ...ApiVersionParameter,
  ...ResourceGroupParameter,
  ...SubscriptionIdParameter,

  /**
   * Object that represents the resource to move.
   */
  @bodyRoot
  moveResourceEnvelope: CsmMoveResourceEnvelope,
): DefaultErrorResponse | NoContentResponse;
/**
 * Description for Validate if a resource can be created.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("Validate if a resource can be created.")
@summary("Validate if a resource can be created.")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/validate")
@post
op validate(
  ...ApiVersionParameter,
  ...ResourceGroupParameter,
  ...SubscriptionIdParameter,

  /**
   * Request with the resources to validate.
   */
  @bodyRoot
  validateRequest: ValidateRequest,
): ArmResponse<ValidateResponse> | DefaultErrorResponse;

/**
 * Description for Gets list of available geo regions plus ministamps
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("Gets list of available geo regions plus ministamps")
@autoRoute
@get
@action("deploymentLocations")
op getSubscriptionDeploymentLocations is ArmProviderActionSync<
  Response = DeploymentLocations,
  Scope = SubscriptionActionScope,
  Parameters = {},
  Error = DefaultErrorResponse
>;

/**
 * Description for get a list of available ASE regions and its supported Skus.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("Get a list of available ASE regions and its supported Skus.")
@autoRoute
@get
@action("aseRegions")
@list
op listAseRegions is ArmProviderActionSync<
  Response = AseRegionCollection,
  Scope = SubscriptionActionScope,
  Parameters = {},
  Error = DefaultErrorResponse
>;

/**
 * Description for Gets a list of meters for a given location.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("Gets a list of meters for a given location.")
@autoRoute
@get
@action("billingMeters")
@list
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
  },
  Error = DefaultErrorResponse
>;

/**
 * Description for Check if a resource name is available.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("Check if a resource name is available.")
@autoRoute
@action("checknameavailability")
op checkNameAvailability is ArmProviderActionSync<
  Request = ResourceNameAvailabilityRequest,
  Response = ResourceNameAvailability,
  Scope = SubscriptionActionScope,
  Parameters = {},
  Error = DefaultErrorResponse
>;

/**
 * Get custom hostnames under this subscription
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("Get custom hostnames under this subscription")
@autoRoute
@get
@action("customhostnameSites")
@list
op listCustomHostNameSites is ArmProviderActionSync<
  Response = CustomHostnameSitesCollection,
  Scope = SubscriptionActionScope,
  Parameters = {
    /**
     * Specific hostname
     */
    @query("hostname")
    hostname?: string;
  },
  Error = DefaultErrorResponse
>;

/**
 * Description for Get a list of available geographical regions.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("Get a list of available geographical regions.")
@autoRoute
@get
@action("geoRegions")
@list
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

    /**
     * Specify <code>true</code> if you want to filter to only regions that support App Service Plans with <code>IsCustomMode</code> set to <code>true</code>.
     */
    @query("customModeWorkersEnabled")
    customModeWorkersEnabled?: boolean;
  },
  Error = DefaultErrorResponse
>;

/**
 * Description for List all apps that are assigned to a hostname.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("List all apps that are assigned to a hostname.")
@autoRoute
@action("listSitesAssignedToHostName")
@list
op listSiteIdentifiersAssignedToHostName is ArmProviderActionSync<
  Request = NameIdentifier,
  Response = IdentifierCollection,
  Scope = SubscriptionActionScope,
  Parameters = {},
  Error = DefaultErrorResponse
>;

/**
 * Check if a resource name is available for DNL sites.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("Check if a resource name is available for DNL sites.")
@autoRoute
@action("checknameavailability")
op regionalCheckNameAvailability is ArmProviderActionSync<
  Request = DnlResourceNameAvailabilityRequest,
  Response = DnlResourceNameAvailability,
  Scope = SubscriptionActionScope,
  Parameters = LocationParameter,
  Error = DefaultErrorResponse
>;

/**
 * Description for List all premier add-on offers.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("List all premier add-on offers.")
@autoRoute
@get
@action("premieraddonoffers")
@list
op listPremierAddOnOffers is ArmProviderActionSync<
  Response = PremierAddOnOfferCollection,
  Scope = SubscriptionActionScope,
  Parameters = {},
  Error = DefaultErrorResponse
>;

/**
 * Description for List all SKUs.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("List all SKUs.")
@autoRoute
@get
@action("skus")
op listSkus is ArmProviderActionSync<
  Response = SkuInfos,
  Scope = SubscriptionActionScope,
  Parameters = {},
  Error = DefaultErrorResponse
>;

/**
 * Description for Verifies if this VNET is compatible with an App Service Environment by analyzing the Network Security Group rules.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("Verifies if this VNET is compatible with an App Service Environment by analyzing the Network Security Group rules.")
@autoRoute
op verifyHostingEnvironmentVnet is ArmProviderActionSync<
  Request = VnetParameters,
  Response = VnetValidationFailureDetails,
  Scope = SubscriptionActionScope,
  Parameters = {},
  Error = DefaultErrorResponse
>;

/**
 * Description for Move resources between resource groups.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
): NoContentResponse | DefaultErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GlobalOperationGroup {
  /**
   * Description for Gets an operation in a subscription and given region
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets an operation in a subscription and given region")
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
  ): NoContentResponse | DefaultErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ProviderOperationGroup {
  /**
   * Description for Get available application frameworks and their versions
   */
  @summary("Get available application frameworks and their versions")
  @autoRoute
  @get
  @action("availableStacks")
  @list
  getAvailableStacks is ArmProviderActionSync<
    Response = ApplicationStackCollection,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("osTypeSelected")
      osTypeSelected?: ProviderOsTypeSelected;
    },
    Error = DefaultErrorResponse
  >;
  /**
   * Description for Get available Function app frameworks and their versions
   */
  @summary("Get available Function app frameworks and their versions")
  @autoRoute
  @get
  @action("functionAppStacks")
  @list
  getFunctionAppStacks is ArmProviderActionSync<
    Response = FunctionAppStackCollection,
    Parameters = {
      /**
       * Stack OS Type
       */
      @query("stackOsType")
      stackOsType?: ProviderStackOsType;
    },
    Error = DefaultErrorResponse
  >;
  /**
   * Description for Get available Function app frameworks and their versions for location
   */
  @summary("Get available Function app frameworks and their versions for location")
  @autoRoute
  @get
  @action("functionAppStacks")
  @list
  getFunctionAppStacksForLocation is ArmProviderActionSync<
    Response = FunctionAppStackCollection,
    Parameters = {
      ...LocationParameter;

      /**
       * Stack OS Type
       */
      @query("stackOsType")
      stackOsType?: ProviderStackOsType;
    },
    Error = DefaultErrorResponse
  >;
  /**
   * Description for Get available Web app frameworks and their versions for location
   */
  @summary("Get available Web app frameworks and their versions for location")
  @autoRoute
  @get
  @action("webAppStacks")
  @list
  getWebAppStacksForLocation is ArmProviderActionSync<
    Response = WebAppStackCollection,
    Parameters = {
      ...LocationParameter;

      /**
       * Stack OS Type
       */
      @query("stackOsType")
      stackOsType?: ProviderStackOsType;
    },
    Error = DefaultErrorResponse
  >;
  /**
   * Description for Get available Web app frameworks and their versions
   */
  @summary("Get available Web app frameworks and their versions")
  @autoRoute
  @get
  @action("webAppStacks")
  @list
  getWebAppStacks is ArmProviderActionSync<
    Response = WebAppStackCollection,
    Parameters = {
      /**
       * Stack OS Type
       */
      @query("stackOsType")
      stackOsType?: ProviderStackOsType;
    },
    Error = DefaultErrorResponse
  >;
  /**
   * Description for Get available application frameworks and their versions
   */
  @summary("Get available application frameworks and their versions")
  @autoRoute
  @get
  @action("availableStacks")
  @list
  getAvailableStacksOnPrem is ArmProviderActionSync<
    Response = ApplicationStackCollection,
    Scope = SubscriptionActionScope,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("osTypeSelected")
      osTypeSelected?: ProviderOsTypeSelected;
    },
    Error = DefaultErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface RecommendationsOperationGroup {
  /**
   * Description for List all recommendations for a subscription.
   */
  @summary("List all recommendations for a subscription.")
  @autoRoute
  @get
  @action("recommendations")
  @list
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
    },
    Error = DefaultErrorResponse
  >;
  /**
   * Description for Reset all recommendation opt-out settings for a subscription.
   */
  @summary("Reset all recommendation opt-out settings for a subscription.")
  @autoRoute
  @action("recommendations/reset")
  resetAllFilters is ArmProviderActionSync<
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = DefaultErrorResponse
  >;
  /**
   * Description for Disables the specified rule so it will not apply to a subscription in the future.
   */
  @summary("Disables the specified rule so it will not apply to a subscription in the future.")
  @autoRoute
  @action("disable")
  disableRecommendationForSubscription is ArmProviderActionSync<
    Response = {
      @body body: void;
    },
    Scope = Extension.Subscription,
    Parameters = {
      /**
       * Rule name
       */
      @path
      @segment("recommendations")
      name: string;
    },
    Error = DefaultErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ResourceHealthMetadataNonResourceOperationGroup {
  /**
   * Description for List all ResourceHealthMetadata for all sites in the subscription.
   */
  @summary("List all ResourceHealthMetadata for all sites in the subscription.")
  @autoRoute
  @get
  @action("resourceHealthMetadata")
  @list
  list is ArmProviderActionSync<
    Response = ResourceHealthMetadataCollection,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = DefaultErrorResponse
  >;
  /**
   * Description for List all ResourceHealthMetadata for all sites in the resource group in the subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("List all ResourceHealthMetadata for all sites in the resource group in the subscription.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/resourceHealthMetadata")
  @get
  @list
  listByResourceGroup(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,
  ): ArmResponse<ResourceHealthMetadataCollection> | DefaultErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GetUsagesInLocationOperationGroup {
  /**
   * List usages in cores for all skus used by a subscription in a given location, for a specific quota type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Lists subscription core usages for all skus used in a location, for a given type of quota.")
  @operationId("GetUsagesInLocation_list")
  @autoRoute
  @get
  @action("usages")
  @list
  list is ArmProviderActionSync<
    Response = CsmUsageQuotaCollection,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = DefaultErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface StaticSitesOperationGroup {
  /**
   * Description for Generates a preview workflow file for the static site
   */
  @summary("Generates a preview workflow file for the static site")
  @autoRoute
  @action("previewStaticSiteWorkflowFile")
  previewWorkflow is ArmProviderActionSync<
    Request = StaticSitesWorkflowPreviewRequest,
    Response = StaticSitesWorkflowPreview,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = DefaultErrorResponse
  >;
}
