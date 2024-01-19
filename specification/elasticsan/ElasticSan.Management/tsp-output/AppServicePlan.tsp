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
@doc("App Service plan.")
model AppServicePlan is TrackedResource<AppServicePlanProperties> {
  @doc("Name of the App Service plan.")
  @path
  @key("name")
  @segment("serverfarms")
  name: string;

  @doc("Extended Location.")
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface AppServicePlans {
  @doc("Description for Get an App Service plan.")
  get is ArmResourceRead<AppServicePlan>;

  @doc("Description for Creates or updates an App Service Plan.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppServicePlan>;

  @doc("Description for Creates or updates an App Service Plan.")
  update is ArmCustomPatchSync<AppServicePlan, AppServicePlanPatchResource>;

  @doc("Description for Delete an App Service plan.")
  delete is ArmResourceDeleteSync<AppServicePlan>;

  @doc("Description for Get all App Service plans in a resource group.")
  listByResourceGroup is ArmResourceListByParent<AppServicePlan>;

  @doc("Description for Get all App Service plans for a subscription.")
  list is ArmListBySubscription<AppServicePlan>;

  @doc("Description for Restart all apps in an App Service plan.")
  restartWebApps is ArmResourceActionNoContentSync<
    AppServicePlan,
    void,
    {
      ...BaseParameters<AppServicePlan>;

      @doc("Specify <code>true</code> to perform a soft restart, applies the configuration settings and restarts the apps if necessary. The default is <code>false</code>, which always restarts and reprovisions the apps")
      @query("softRestart")
      softRestart?: boolean;
    }
  >;

  @doc("Description for Reboot a worker machine in an App Service plan.")
  rebootWorker is ArmResourceActionNoContentSync<
    AppServicePlan,
    void,
    {
      ...BaseParameters<AppServicePlan>;

      @doc("Name of worker machine, which typically starts with RD.")
      @path
      workerName: string;
    }
  >;

  @summary("List all capabilities of an App Service plan.")
  @doc("Description for List all capabilities of an App Service plan.")
  // FIXME: AppServicePlans_ListCapabilities could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/capabilities")
  @get
  listCapabilities is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service plan.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Retrieve all Hybrid Connections in use in an App Service plan.")
  @doc("Description for Retrieve all Hybrid Connections in use in an App Service plan.")
  // FIXME: AppServicePlans_ListHybridConnections could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/hybridConnectionRelays")
  @get
  listHybridConnections is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service plan.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    HybridConnectionCollection
  >;

  @summary("Get all apps associated with an App Service plan.")
  @doc("Description for Get all apps associated with an App Service plan.")
  // FIXME: AppServicePlans_ListWebApps could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/sites")
  @get
  listWebApps is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service plan.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Skip to a web app in the list of webapps associated with app service plan. If specified, the resulting list will contain web apps starting from (including) the skipToken. Otherwise, the resulting list contains web apps from the start of the list")
      @query("$skipToken")
      $skipToken?: string;

      @doc("Supported filter: $filter=state eq running. Returns only web apps that are currently running")
      @query("$filter")
      $filter?: string;

      @doc("List page size. If specified, results are paged.")
      @query("$top")
      $top?: string;
    },
    ResourceListResult<Site>
  >;

  @summary("Gets all selectable SKUs for a given App Service Plan")
  @doc("Description for Gets all selectable SKUs for a given App Service Plan")
  // FIXME: AppServicePlans_GetServerFarmSkus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/skus")
  @get
  getServerFarmSkus is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of App Service Plan")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets server farm usage information")
  @doc("Description for Gets server farm usage information")
  // FIXME: AppServicePlans_ListUsages could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/usages")
  @get
  listUsages is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of App Service Plan")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Return only usages/metrics specified in the filter. Filter conforms to odata syntax. Example: $filter=(name.value eq 'Metric1' or name.value eq 'Metric2').")
      @query("$filter")
      $filter?: string;
    },
    CsmUsageQuotaCollection
  >;
}

@@projectedName(AppServicePlans.createOrUpdate::parameters.resource,
  "json",
  "appServicePlan"
);
@@extension(AppServicePlans.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "appServicePlan"
);
@@doc(AppServicePlans.createOrUpdate::parameters.resource,
  "Details of the App Service plan."
);
@@projectedName(AppServicePlans.update::parameters.properties,
  "json",
  "appServicePlan"
);
@@extension(AppServicePlans.update::parameters.properties,
  "x-ms-client-name",
  "appServicePlan"
);
@@doc(AppServicePlans.update::parameters.properties,
  "Details of the App Service plan."
);
