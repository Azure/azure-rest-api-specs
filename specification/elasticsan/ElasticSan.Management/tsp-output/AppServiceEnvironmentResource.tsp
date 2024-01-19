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
@doc("App Service Environment ARM resource.")
model AppServiceEnvironmentResource is TrackedResource<AppServiceEnvironment> {
  @doc("Name of the App Service Environment.")
  @path
  @key("name")
  @segment("hostingEnvironments")
  name: string;
}

@armResourceOperations
interface AppServiceEnvironmentResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get the properties of an App Service Environment.")
  @operationId("AppServiceEnvironments_Get")
  get is ArmResourceRead<AppServiceEnvironmentResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Create or update an App Service Environment.")
  @operationId("AppServiceEnvironments_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppServiceEnvironmentResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Create or update an App Service Environment.")
  @operationId("AppServiceEnvironments_Update")
  update is ArmCustomPatchSync<
    AppServiceEnvironmentResource,
    AppServiceEnvironmentPatchResource
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Delete an App Service Environment.")
  @operationId("AppServiceEnvironments_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    AppServiceEnvironmentResource,
    {
      ...BaseParameters<AppServiceEnvironmentResource>;

      @doc("Specify <code>true</code> to force the deletion even if the App Service Environment contains resources. The default is <code>false</code>.")
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get all App Service Environments in a resource group.")
  @operationId("AppServiceEnvironments_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AppServiceEnvironmentResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get all App Service Environments for a subscription.")
  @operationId("AppServiceEnvironments_List")
  list is ArmListBySubscription<AppServiceEnvironmentResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Reboot all machines in an App Service Environment.")
  @operationId("AppServiceEnvironments_Reboot")
  reboot is ArmResourceActionNoContentSync<AppServiceEnvironmentResource, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Disable all recommendations for an app.")
  @operationId("Recommendations_DisableAllForHostingEnvironment")
  disableAllForHostingEnvironment is ArmResourceActionNoContentSync<
    AppServiceEnvironmentResource,
    void,
    {
      ...BaseParameters<AppServiceEnvironmentResource>;

      @doc("Name of the app.")
      @query("environmentName")
      environmentName: string;

      @path
      hostingEnvironmentName: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Reset all recommendation opt-out settings for an app.")
  @operationId("Recommendations_ResetAllFiltersForHostingEnvironment")
  resetAllFiltersForHostingEnvironment is ArmResourceActionNoContentSync<
    AppServiceEnvironmentResource,
    void,
    {
      ...BaseParameters<AppServiceEnvironmentResource>;

      @doc("Name of the app.")
      @query("environmentName")
      environmentName: string;

      @path
      hostingEnvironmentName: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListCapacities")
  @summary("Get the used, available, and total worker capacity an App Service Environment.")
  @doc("Description for Get the used, available, and total worker capacity an App Service Environment.")
  // FIXME: AppServiceEnvironments_ListCapacities could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/capacities/compute")
  @get
  listCapacities is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    StampCapacityCollection
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_GetVipInfo")
  @summary("Get IP addresses assigned to an App Service Environment.")
  @doc("Description for Get IP addresses assigned to an App Service Environment.")
  // FIXME: AppServiceEnvironments_GetVipInfo could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/capacities/virtualip")
  @get
  getVipInfo is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    AddressResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListDiagnostics")
  @summary("Get diagnostic information for an App Service Environment.")
  @doc("Description for Get diagnostic information for an App Service Environment.")
  // FIXME: AppServiceEnvironments_ListDiagnostics could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/diagnostics")
  @get
  listDiagnostics is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_GetDiagnosticsItem")
  @summary("Get a diagnostics item for an App Service Environment.")
  @doc("Description for Get a diagnostics item for an App Service Environment.")
  // FIXME: AppServiceEnvironments_GetDiagnosticsItem could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/diagnostics/{diagnosticsName}")
  @get
  getDiagnosticsItem is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Name of the diagnostics item.")
      @path
      diagnosticsName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    HostingEnvironmentDiagnostics
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_GetInboundNetworkDependenciesEndpoints")
  @summary("Get the network endpoints of all inbound dependencies of an App Service Environment.")
  @doc("Description for Get the network endpoints of all inbound dependencies of an App Service Environment.")
  // FIXME: AppServiceEnvironments_GetInboundNetworkDependenciesEndpoints could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/inboundNetworkDependenciesEndpoints")
  @get
  getInboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    InboundEnvironmentEndpointCollection
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListOperations")
  @summary("List all currently running operations on the App Service Environment.")
  @doc("Description for List all currently running operations on the App Service Environment.")
  // FIXME: AppServiceEnvironments_ListOperations could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/operations")
  @get
  listOperations is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_GetOutboundNetworkDependenciesEndpoints")
  @summary("Get the network endpoints of all outbound dependencies of an App Service Environment.")
  @doc("Description for Get the network endpoints of all outbound dependencies of an App Service Environment.")
  // FIXME: AppServiceEnvironments_GetOutboundNetworkDependenciesEndpoints could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/outboundNetworkDependenciesEndpoints")
  @get
  getOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    OutboundEnvironmentEndpointCollection
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_GetPrivateLinkResources")
  @summary("Gets the private link resources")
  @doc("Description for Gets the private link resources")
  // FIXME: AppServiceEnvironments_GetPrivateLinkResources could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/privateLinkResources")
  @get
  getPrivateLinkResources is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    PrivateLinkResourcesWrapper
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListAppServicePlans")
  @summary("Get all App Service plans in an App Service Environment.")
  @doc("Description for Get all App Service plans in an App Service Environment.")
  // FIXME: AppServiceEnvironments_ListAppServicePlans could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/serverfarms")
  @get
  listAppServicePlans is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ResourceListResult<AppServicePlan>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListWebApps")
  @summary("Get all apps in an App Service Environment.")
  @doc("Description for Get all apps in an App Service Environment.")
  // FIXME: AppServiceEnvironments_ListWebApps could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/sites")
  @get
  listWebApps is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Comma separated list of app properties to include.")
      @query("propertiesToInclude")
      propertiesToInclude?: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ResourceListResult<Site>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListUsages")
  @summary("Get global usage metrics of an App Service Environment.")
  @doc("Description for Get global usage metrics of an App Service Environment.")
  // FIXME: AppServiceEnvironments_ListUsages could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/usages")
  @get
  listUsages is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Return only usages/metrics specified in the filter. Filter conforms to odata syntax. Example: $filter=(name.value eq 'Metric1' or name.value eq 'Metric2') and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.")
      @query("$filter")
      $filter?: string;
    },
    CsmUsageQuotaCollection
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Recommendations_ListHistoryForHostingEnvironment")
  @summary("Get past recommendations for an app, optionally specified by the time range.")
  @doc("Description for Get past recommendations for an app, optionally specified by the time range.")
  // FIXME: Recommendations_ListHistoryForHostingEnvironment could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{hostingEnvironmentName}/recommendationHistory")
  @get
  listHistoryForHostingEnvironment is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the hosting environment.")
      @path
      hostingEnvironmentName: string;

      @doc("Specify <code>false</code> to return all recommendations. The default is <code>true</code>, which returns only expired recommendations.")
      @query("expiredOnly")
      expiredOnly?: boolean;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification' and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[PT1H|PT1M|P1D]")
      @query("$filter")
      $filter?: string;
    },
    RecommendationCollection
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Recommendations_ListRecommendedRulesForHostingEnvironment")
  @summary("Get all recommendations for a hosting environment.")
  @doc("Description for Get all recommendations for a hosting environment.")
  // FIXME: Recommendations_ListRecommendedRulesForHostingEnvironment could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{hostingEnvironmentName}/recommendations")
  @get
  listRecommendedRulesForHostingEnvironment is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      hostingEnvironmentName: string;

      @doc("Specify <code>true</code> to return only the most critical recommendations. The default is <code>false</code>, which returns all recommendations.")
      @query("featured")
      featured?: boolean;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Return only channels specified in the filter. Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification'")
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
