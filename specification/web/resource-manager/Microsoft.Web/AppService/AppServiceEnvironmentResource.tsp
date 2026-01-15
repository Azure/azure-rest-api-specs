import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * App Service Environment ARM resource.
 */
model AppServiceEnvironmentResource
  is Azure.ResourceManager.TrackedResource<AppServiceEnvironment> {
  ...ResourceNameParameter<
    Resource = AppServiceEnvironmentResource,
    KeyName = "name",
    SegmentName = "hostingEnvironments",
    NamePattern = ""
  >;

  /** Kind of resource. If the resource is an app, you can refer to https://github.com/Azure/app-service-linux-docs/blob/master/Things_You_Should_Know/kind_property.md#app-service-resource-kind-reference for details supported values for kind. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

alias DiagnosticsOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
  },
  {
    /** Name of the app. */
    @path
    @segment("hostingEnvironments")
    @key
    name: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/hostingEnvironments",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface AppServiceEnvironmentResources {
  /**
   * Description for Get the properties of an App Service Environment.
   */
  @summary("Get the properties of an App Service Environment.")
  get is ArmResourceRead<
    AppServiceEnvironmentResource,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Create or update an App Service Environment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or update an App Service Environment.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AppServiceEnvironmentResource,
    Response = ArmResourceUpdatedResponse<AppServiceEnvironmentResource> | ArmResourceCreatedResponse<
      AppServiceEnvironmentResource,
      ArmLroLocationHeader<FinalResult = AppServiceEnvironmentResource> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = AppServiceEnvironmentResource>> &
      Azure.Core.Foundations.RetryAfterHeader & {
        @bodyRoot
        _: AppServiceEnvironmentResource;
      }),
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Create or update an App Service Environment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or update an App Service Environment.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AppServiceEnvironmentResource,
    PatchModel = AppServiceEnvironmentPatchResource,
    Response = ArmResponse<AppServiceEnvironmentResource> | ArmResourceCreatedSyncResponse<AppServiceEnvironmentResource> | (AcceptedResponse & {
      @bodyRoot
      _: AppServiceEnvironmentResource;
    }),
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Delete an App Service Environment.
   */
  @summary("Delete an App Service Environment.")
  delete is ArmResourceDeleteWithoutOkAsync<
    AppServiceEnvironmentResource,
    Parameters = {
      /**
       * Specify <code>true</code> to force the deletion even if the App Service Environment contains resources. The default is <code>false</code>.
       */
      @query("forceDelete")
      forceDelete?: boolean;
    },
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get all App Service Environments in a resource group.
   */
  @summary("Get all App Service Environments in a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    AppServiceEnvironmentResource,
    Response = ArmResponse<AppServiceEnvironmentCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get all App Service Environments for a subscription.
   */
  @summary("Get all App Service Environments for a subscription.")
  list is ArmListBySubscription<
    AppServiceEnvironmentResource,
    Response = ArmResponse<AppServiceEnvironmentCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get the used, available, and total worker capacity an App Service Environment.
   */
  @summary("Get the used, available, and total worker capacity an App Service Environment.")
  @get
  @list
  @action("capacities/compute")
  listCapacities is ArmResourceActionSync<
    AppServiceEnvironmentResource,
    void,
    ArmResponse<StampCapacityCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Move an App Service Environment to a different VNET.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Move an App Service Environment to a different VNET.")
  @action("changeVirtualNetwork")
  @list
  changeVnet is Azure.ResourceManager.ArmResourceActionAsyncBase<
    AppServiceEnvironmentResource,
    VirtualNetworkProfile,
    ArmResponse<WebAppCollection> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = WebAppCollection>> & {
      @bodyRoot
      _: WebAppCollection;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<WebAppCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get diagnostic information for an App Service Environment.
   */
  @summary("Get diagnostic information for an App Service Environment.")
  @get
  @action("diagnostics")
  listDiagnostics is ArmResourceActionSync<
    AppServiceEnvironmentResource,
    void,
    ArmResponse<HostingEnvironmentDiagnostics[]>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get a diagnostics item for an App Service Environment.
   */
  @summary("Get a diagnostics item for an App Service Environment.")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/hostingEnvironments/{name}/diagnostics/{diagnosticsName}")
  getDiagnosticsItem is DiagnosticsOps.ActionSync<
    AppServiceEnvironmentResource,
    void,
    ArmResponse<HostingEnvironmentDiagnostics>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      @key
      diagnosticsName: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get the network endpoints of all inbound dependencies of an App Service Environment.
   */
  @summary("Get the network endpoints of all inbound dependencies of an App Service Environment.")
  @get
  @action("inboundNetworkDependenciesEndpoints")
  @list
  getInboundNetworkDependenciesEndpoints is ArmResourceActionSync<
    AppServiceEnvironmentResource,
    void,
    ArmResponse<InboundEnvironmentEndpointCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Send a test notification that an upgrade is available for this App Service Environment.
   */
  @summary("Send a test notification that an upgrade is available for this App Service Environment.")
  testUpgradeAvailableNotification is ArmResourceActionSync<
    AppServiceEnvironmentResource,
    void,
    {
      @body body: void;
    },
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Initiate an upgrade of an App Service Environment if one is available.
   */
  @summary("Initiate an upgrade of an App Service Environment if one is available.")
  upgrade is ArmResourceActionAsyncBase<
    AppServiceEnvironmentResource,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<AppServiceEnvironmentResource>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for List all currently running operations on the App Service Environment.
   */
  @summary("List all currently running operations on the App Service Environment.")
  @get
  @action("operations")
  listOperations is ArmResourceActionSync<
    AppServiceEnvironmentResource,
    void,
    ArmResponse<Operation[]>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get the network endpoints of all outbound dependencies of an App Service Environment.
   */
  @summary("Get the network endpoints of all outbound dependencies of an App Service Environment.")
  @get
  @action("outboundNetworkDependenciesEndpoints")
  @list
  getOutboundNetworkDependenciesEndpoints is ArmResourceActionSync<
    AppServiceEnvironmentResource,
    void,
    ArmResponse<OutboundEnvironmentEndpointCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets the private link resources
   */
  @summary("Gets the private link resources")
  @get
  @action("privateLinkResources")
  getPrivateLinkResources is ArmResourceActionSync<
    AppServiceEnvironmentResource,
    void,
    ArmResponse<PrivateLinkResourcesWrapper>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Reboot all machines in an App Service Environment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Reboot all machines in an App Service Environment.")
  reboot is ArmResourceActionSync<
    AppServiceEnvironmentResource,
    void,
    AcceptedResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Resume an App Service Environment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Resume an App Service Environment.")
  @list
  resume is ArmResourceActionAsyncBase<
    AppServiceEnvironmentResource,
    void,
    ArmResponse<WebAppCollection> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = WebAppCollection>> & {
      @bodyRoot
      _: WebAppCollection;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<AppServiceEnvironmentResource>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get all App Service plans in an App Service Environment.
   */
  @summary("Get all App Service plans in an App Service Environment.")
  @get
  @action("serverfarms")
  @list
  listAppServicePlans is ArmResourceActionSync<
    AppServiceEnvironmentResource,
    void,
    ArmResponse<AppServicePlanCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get all apps in an App Service Environment.
   */
  @summary("Get all apps in an App Service Environment.")
  @get
  @action("sites")
  @list
  listWebApps is ArmResourceActionSync<
    AppServiceEnvironmentResource,
    void,
    ArmResponse<WebAppCollection>,
    Parameters = {
      /**
       * Comma separated list of app properties to include.
       */
      @query("propertiesToInclude")
      propertiesToInclude?: string;
    },
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Suspend an App Service Environment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Suspend an App Service Environment.")
  @list
  suspend is ArmResourceActionAsyncBase<
    AppServiceEnvironmentResource,
    void,
    ArmResponse<WebAppCollection> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = WebAppCollection>> & {
      @bodyRoot
      _: WebAppCollection;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<AppServiceEnvironmentResource>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get global usage metrics of an App Service Environment.
   */
  @summary("Get global usage metrics of an App Service Environment.")
  @get
  @action("usages")
  @list
  listUsages is ArmResourceActionSync<
    AppServiceEnvironmentResource,
    void,
    ArmResponse<CsmUsageQuotaCollection>,
    Parameters = {
      /**
       * Return only usages/metrics specified in the filter. Filter conforms to odata syntax. Example: $filter=(name.value eq 'Metric1' or name.value eq 'Metric2') and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get past recommendations for an app, optionally specified by the time range.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get past recommendations for an app, optionally specified by the time range.")
  @Azure.ResourceManager.Legacy.renamePathParameter(
    "name",
    "hostingEnvironmentName"
  )
  @get
  @action("recommendationHistory")
  @list
  listHistoryForHostingEnvironment is ArmResourceActionSync<
    AppServiceEnvironmentResource,
    void,
    ArmResponse<RecommendationCollection>,
    Parameters = {
      /**
       * Specify <code>false</code> to return all recommendations. The default is <code>true</code>, which returns only expired recommendations.
       */
      @query("expiredOnly")
      expiredOnly?: boolean;

      /**
       * Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification' and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[PT1H|PT1M|P1D]
       */
      @query("$filter")
      $filter?: string;
    },
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get all recommendations for a hosting environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get all recommendations for a hosting environment.")
  @Azure.ResourceManager.Legacy.renamePathParameter(
    "name",
    "hostingEnvironmentName"
  )
  @get
  @action("recommendations")
  @list
  listRecommendedRulesForHostingEnvironment is ArmResourceActionSync<
    AppServiceEnvironmentResource,
    void,
    ArmResponse<RecommendationCollection>,
    Parameters = {
      /**
       * Specify <code>true</code> to return only the most critical recommendations. The default is <code>false</code>, which returns all recommendations.
       */
      @query("featured")
      featured?: boolean;

      /**
       * Return only channels specified in the filter. Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification'
       */
      @query("$filter")
      $filter?: string;
    },
    Error = DefaultErrorResponse
  >;
  /**
   * Description for Disable all recommendations for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Disable all recommendations for an app.")
  @post
  @action("recommendations/disable")
  @Azure.ResourceManager.Legacy.renamePathParameter(
    "name",
    "hostingEnvironmentName"
  )
  disableAllForHostingEnvironment is ArmResourceActionSync<
    AppServiceEnvironmentResource,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * Name of the app.
       */
      @query("environmentName")
      environmentName: string;
    },
    Error = DefaultErrorResponse
  >;
  /**
   * Description for Reset all recommendation opt-out settings for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Reset all recommendation opt-out settings for an app.")
  @post
  @action("recommendations/reset")
  @Azure.ResourceManager.Legacy.renamePathParameter(
    "name",
    "hostingEnvironmentName"
  )
  resetAllFiltersForHostingEnvironment is ArmResourceActionSync<
    AppServiceEnvironmentResource,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * Name of the app.
       */
      @query("environmentName")
      environmentName: string;
    },
    Error = DefaultErrorResponse
  >;
}

@@doc(AppServiceEnvironmentResource.name,
  "Name of the App Service Environment."
);
@@doc(AppServiceEnvironmentResource.properties, "Core resource properties");
@@doc(AppServiceEnvironmentResources.createOrUpdate::parameters.resource,
  "Configuration details of the App Service Environment."
);
@@doc(AppServiceEnvironmentResources.update::parameters.properties,
  "Configuration details of the App Service Environment."
);
@@doc(AppServiceEnvironmentResources.changeVnet::parameters.body,
  "Details for the new virtual network."
);
