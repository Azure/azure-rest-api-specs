import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * App Service Environment ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
model AppServiceEnvironmentResource extends Resource {
  /**
   * Name of the App Service Environment.
   */
  @path
  @key("name")
  @segment("hostingEnvironments")
  @visibility("read")
  name: string;

  /**
   * Core resource properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: AppServiceEnvironment;
}

@armResourceOperations
interface AppServiceEnvironmentResources {
  /**
   * Description for Get the properties of an App Service Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_Get")
  get is ArmResourceRead<AppServiceEnvironmentResource>;

  /**
   * Description for Create or update an App Service Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AppServiceEnvironmentResource>;

  /**
   * Description for Create or update an App Service Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("AppServiceEnvironments_Update")
  update is ArmCustomPatchSync<
    AppServiceEnvironmentResource,
    AppServiceEnvironmentPatchResource
  >;

  /**
   * Description for Delete an App Service Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    AppServiceEnvironmentResource,
    {
      ...BaseParameters<AppServiceEnvironmentResource>;

      /**
       * Specify <code>true</code> to force the deletion even if the App Service Environment contains resources. The default is <code>false</code>.
       */
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;

  /**
   * Description for Get all App Service Environments in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AppServiceEnvironmentResource>;

  /**
   * Description for Get all App Service Environments for a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_List")
  list is ArmListBySubscription<AppServiceEnvironmentResource>;

  /**
   * Description for Reboot all machines in an App Service Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_Reboot")
  reboot is ArmResourceActionNoContentSync<AppServiceEnvironmentResource, void>;

  /**
   * Description for Disable all recommendations for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Recommendations_DisableAllForHostingEnvironment")
  disableAllForHostingEnvironment is ArmResourceActionNoContentSync<
    AppServiceEnvironmentResource,
    void,
    {
      ...BaseParameters<AppServiceEnvironmentResource>;

      /**
       * Name of the app.
       */
      @query("environmentName")
      environmentName: string;

      @path
      hostingEnvironmentName: string;
    }
  >;

  /**
   * Description for Reset all recommendation opt-out settings for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Recommendations_ResetAllFiltersForHostingEnvironment")
  resetAllFiltersForHostingEnvironment is ArmResourceActionNoContentSync<
    AppServiceEnvironmentResource,
    void,
    {
      ...BaseParameters<AppServiceEnvironmentResource>;

      /**
       * Name of the app.
       */
      @query("environmentName")
      environmentName: string;

      @path
      hostingEnvironmentName: string;
    }
  >;

  /**
   * Description for Get the used, available, and total worker capacity an App Service Environment.
   */
  // FIXME: AppServiceEnvironments_ListCapacities could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListCapacities")
  @summary("Get the used, available, and total worker capacity an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/capacities/compute")
  @get
  listCapacities is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    StampCapacityCollection
  >;

  /**
   * Description for Get IP addresses assigned to an App Service Environment.
   */
  // FIXME: AppServiceEnvironments_GetVipInfo could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_GetVipInfo")
  @summary("Get IP addresses assigned to an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/capacities/virtualip")
  @get
  getVipInfo is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    AddressResponse
  >;

  /**
   * Description for Get diagnostic information for an App Service Environment.
   */
  // FIXME: AppServiceEnvironments_ListDiagnostics could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListDiagnostics")
  @summary("Get diagnostic information for an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/diagnostics")
  @get
  listDiagnostics is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Get a diagnostics item for an App Service Environment.
   */
  // FIXME: AppServiceEnvironments_GetDiagnosticsItem could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_GetDiagnosticsItem")
  @summary("Get a diagnostics item for an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/diagnostics/{diagnosticsName}")
  @get
  getDiagnosticsItem is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Name of the diagnostics item.
       */
      @path
      diagnosticsName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    HostingEnvironmentDiagnostics
  >;

  /**
   * Description for Get the network endpoints of all inbound dependencies of an App Service Environment.
   */
  // FIXME: AppServiceEnvironments_GetInboundNetworkDependenciesEndpoints could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_GetInboundNetworkDependenciesEndpoints")
  @summary("Get the network endpoints of all inbound dependencies of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/inboundNetworkDependenciesEndpoints")
  @get
  getInboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    InboundEnvironmentEndpointCollection
  >;

  /**
   * Description for List all currently running operations on the App Service Environment.
   */
  // FIXME: AppServiceEnvironments_ListOperations could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListOperations")
  @summary("List all currently running operations on the App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/operations")
  @get
  listOperations is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Get the network endpoints of all outbound dependencies of an App Service Environment.
   */
  // FIXME: AppServiceEnvironments_GetOutboundNetworkDependenciesEndpoints could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_GetOutboundNetworkDependenciesEndpoints")
  @summary("Get the network endpoints of all outbound dependencies of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/outboundNetworkDependenciesEndpoints")
  @get
  getOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    OutboundEnvironmentEndpointCollection
  >;

  /**
   * Description for Gets the private link resources
   */
  // FIXME: AppServiceEnvironments_GetPrivateLinkResources could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_GetPrivateLinkResources")
  @summary("Gets the private link resources")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/privateLinkResources")
  @get
  getPrivateLinkResources is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    PrivateLinkResourcesWrapper
  >;

  /**
   * Description for Get all App Service plans in an App Service Environment.
   */
  // FIXME: AppServiceEnvironments_ListAppServicePlans could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListAppServicePlans")
  @summary("Get all App Service plans in an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/serverfarms")
  @get
  listAppServicePlans is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<AppServicePlan>
  >;

  /**
   * Description for Get all apps in an App Service Environment.
   */
  // FIXME: AppServiceEnvironments_ListWebApps could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListWebApps")
  @summary("Get all apps in an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/sites")
  @get
  listWebApps is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Comma separated list of app properties to include.
       */
      @query("propertiesToInclude")
      propertiesToInclude?: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<Site>
  >;

  /**
   * Description for Get global usage metrics of an App Service Environment.
   */
  // FIXME: AppServiceEnvironments_ListUsages could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListUsages")
  @summary("Get global usage metrics of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/usages")
  @get
  listUsages is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Return only usages/metrics specified in the filter. Filter conforms to odata syntax. Example: $filter=(name.value eq 'Metric1' or name.value eq 'Metric2') and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.
       */
      @query("$filter")
      $filter?: string;
    },
    CsmUsageQuotaCollection
  >;

  /**
   * Description for Get past recommendations for an app, optionally specified by the time range.
   */
  // FIXME: Recommendations_ListHistoryForHostingEnvironment could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Recommendations_ListHistoryForHostingEnvironment")
  @summary("Get past recommendations for an app, optionally specified by the time range.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{hostingEnvironmentName}/recommendationHistory")
  @get
  listHistoryForHostingEnvironment is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the hosting environment.
       */
      @path
      hostingEnvironmentName: string;

      /**
       * Specify <code>false</code> to return all recommendations. The default is <code>true</code>, which returns only expired recommendations.
       */
      @query("expiredOnly")
      expiredOnly?: boolean;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification' and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[PT1H|PT1M|P1D]
       */
      @query("$filter")
      $filter?: string;
    },
    RecommendationCollection
  >;

  /**
   * Description for Get all recommendations for a hosting environment.
   */
  // FIXME: Recommendations_ListRecommendedRulesForHostingEnvironment could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Recommendations_ListRecommendedRulesForHostingEnvironment")
  @summary("Get all recommendations for a hosting environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{hostingEnvironmentName}/recommendations")
  @get
  listRecommendedRulesForHostingEnvironment is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      hostingEnvironmentName: string;

      /**
       * Specify <code>true</code> to return only the most critical recommendations. The default is <code>false</code>, which returns all recommendations.
       */
      @query("featured")
      featured?: boolean;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Return only channels specified in the filter. Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification'
       */
      @query("$filter")
      $filter?: string;
    },
    RecommendationCollection
  >;
}

@@projectedName(AppServiceEnvironmentResources.createOrUpdate::parameters.resource,
  "json",
  "hostingEnvironmentEnvelope"
);
@@extension(AppServiceEnvironmentResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "hostingEnvironmentEnvelope"
);
@@doc(AppServiceEnvironmentResources.createOrUpdate::parameters.resource,
  "Configuration details of the App Service Environment."
);
@@projectedName(AppServiceEnvironmentResources.update::parameters.properties,
  "json",
  "hostingEnvironmentEnvelope"
);
@@extension(AppServiceEnvironmentResources.update::parameters.properties,
  "x-ms-client-name",
  "hostingEnvironmentEnvelope"
);
@@doc(AppServiceEnvironmentResources.update::parameters.properties,
  "Configuration details of the App Service Environment."
);
