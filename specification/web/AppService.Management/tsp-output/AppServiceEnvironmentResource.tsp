import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("App Service Environment ARM resource.")
model AppServiceEnvironmentResource is TrackedResource<AppServiceEnvironment> {
  @doc("Name of the App Service Environment.")
  @path
  @key("name")
  @segment("hostingEnvironments")
  name: string;
}

@armResourceOperations
interface AppServiceEnvironments {
  @doc("Description for Get the properties of an App Service Environment.")
  get is ArmResourceRead<AppServiceEnvironmentResource>;
  @doc("Description for Create or update an App Service Environment.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppServiceEnvironmentResource>;
  @doc("Description for Create or update an App Service Environment.")
  update is ArmResourcePatchSync<
    AppServiceEnvironmentResource,
    AppServiceEnvironment
  >;
  @doc("Description for Delete an App Service Environment.")
  delete is ArmResourceDeleteWithoutOkAsync<
    AppServiceEnvironmentResource,
    {
      ...BaseParameters<AppServiceEnvironmentResource>;

      @doc("Specify <code>true</code> to force the deletion even if the App Service Environment contains resources. The default is <code>false</code>.")
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;
  @doc("Description for Get all App Service Environments in a resource group.")
  listByResourceGroup is ArmResourceListByParent<AppServiceEnvironmentResource>;
  @doc("Description for Get all App Service Environments for a subscription.")
  list is ArmListBySubscription<AppServiceEnvironmentResource>;
  @doc("Description for Reboot all machines in an App Service Environment.")
  reboot is ArmResourceActionNoContentSync<AppServiceEnvironmentResource, void>;
  @summary("Get the used, available, and total worker capacity an App Service Environment.")
  @doc("Description for Get the used, available, and total worker capacity an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/capacities/compute")
  @get
  ListCapacities is Azure.Core.Foundations.Operation<
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

  @summary("Get IP addresses assigned to an App Service Environment.")
  @doc("Description for Get IP addresses assigned to an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/capacities/virtualip")
  @get
  GetVipInfo is Azure.Core.Foundations.Operation<
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

  @summary("Get diagnostic information for an App Service Environment.")
  @doc("Description for Get diagnostic information for an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/diagnostics")
  @get
  ListDiagnostics is Azure.Core.Foundations.Operation<
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

  @summary("Get a diagnostics item for an App Service Environment.")
  @doc("Description for Get a diagnostics item for an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/diagnostics/{diagnosticsName}")
  @get
  GetDiagnosticsItem is Azure.Core.Foundations.Operation<
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

  @summary("Get the network endpoints of all inbound dependencies of an App Service Environment.")
  @doc("Description for Get the network endpoints of all inbound dependencies of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/inboundNetworkDependenciesEndpoints")
  @get
  GetInboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
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

  @summary("List all currently running operations on the App Service Environment.")
  @doc("Description for List all currently running operations on the App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/operations")
  @get
  ListOperations is Azure.Core.Foundations.Operation<
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

  @summary("Get the network endpoints of all outbound dependencies of an App Service Environment.")
  @doc("Description for Get the network endpoints of all outbound dependencies of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/outboundNetworkDependenciesEndpoints")
  @get
  GetOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
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

  @summary("Gets the private link resources")
  @doc("Description for Gets the private link resources")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/privateLinkResources")
  @get
  GetPrivateLinkResources is Azure.Core.Foundations.Operation<
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

  @summary("Get all App Service plans in an App Service Environment.")
  @doc("Description for Get all App Service plans in an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/serverfarms")
  @get
  ListAppServicePlans is Azure.Core.Foundations.Operation<
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
    AppServicePlanCollection
  >;

  @summary("Get all apps in an App Service Environment.")
  @doc("Description for Get all apps in an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/sites")
  @get
  ListWebApps is Azure.Core.Foundations.Operation<
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
    WebAppCollection
  >;

  @summary("Get global usage metrics of an App Service Environment.")
  @doc("Description for Get global usage metrics of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/usages")
  @get
  ListUsages is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations
interface Recommendations {
  @doc("Description for Disable all recommendations for an app.")
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
  @doc("Description for Reset all recommendation opt-out settings for an app.")
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
  @summary("Get past recommendations for an app, optionally specified by the time range.")
  @doc("Description for Get past recommendations for an app, optionally specified by the time range.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{hostingEnvironmentName}/recommendationHistory")
  @get
  ListHistoryForHostingEnvironment is Azure.Core.Foundations.Operation<
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

  @summary("Get all recommendations for a hosting environment.")
  @doc("Description for Get all recommendations for a hosting environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{hostingEnvironmentName}/recommendations")
  @get
  ListRecommendedRulesForHostingEnvironment is Azure.Core.Foundations.Operation<
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
