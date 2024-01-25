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
 * App Service plan.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
model AppServicePlan extends Resource {
  /**
   * Name of the App Service plan.
   */
  @path
  @key("name")
  @segment("serverfarms")
  @visibility("read")
  name: string;

  /**
   * Description of a SKU for a scalable resource.
   */
  sku?: SkuDescription;

  /**
   * Extended Location.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * AppServicePlan resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: AppServicePlanProperties;
}

@armResourceOperations
interface AppServicePlans {
  /**
   * Description for Get an App Service plan.
   */
  get is ArmResourceRead<AppServicePlan>;

  /**
   * Description for Creates or updates an App Service Plan.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AppServicePlan>;

  /**
   * Description for Creates or updates an App Service Plan.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<AppServicePlan, AppServicePlanPatchResource>;

  /**
   * Description for Delete an App Service plan.
   */
  delete is ArmResourceDeleteSync<AppServicePlan>;

  /**
   * Description for Get all App Service plans in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServicePlans_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AppServicePlan>;

  /**
   * Description for Get all App Service plans for a subscription.
   */
  list is ArmListBySubscription<AppServicePlan>;

  /**
   * Description for Restart all apps in an App Service plan.
   */
  restartWebApps is ArmResourceActionNoContentSync<
    AppServicePlan,
    void,
    {
      ...BaseParameters<AppServicePlan>;

      /**
       * Specify <code>true</code> to perform a soft restart, applies the configuration settings and restarts the apps if necessary. The default is <code>false</code>, which always restarts and reprovisions the apps
       */
      @query("softRestart")
      softRestart?: boolean;
    }
  >;

  /**
   * Description for Reboot a worker machine in an App Service plan.
   */
  rebootWorker is ArmResourceActionNoContentSync<
    AppServicePlan,
    void,
    {
      ...BaseParameters<AppServicePlan>;

      /**
       * Name of worker machine, which typically starts with RD.
       */
      @path
      workerName: string;
    }
  >;

  /**
   * Description for List all capabilities of an App Service plan.
   */
  // FIXME: AppServicePlans_ListCapabilities could not be converted to a resource operation
  @summary("List all capabilities of an App Service plan.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/capabilities")
  @get
  listCapabilities is Azure.Core.Foundations.Operation<
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
       * Name of the App Service plan.
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
   * Description for Retrieve all Hybrid Connections in use in an App Service plan.
   */
  // FIXME: AppServicePlans_ListHybridConnections could not be converted to a resource operation
  @summary("Retrieve all Hybrid Connections in use in an App Service plan.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/hybridConnectionRelays")
  @get
  listHybridConnections is Azure.Core.Foundations.Operation<
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
       * Name of the App Service plan.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    HybridConnectionCollection
  >;

  /**
   * Description for Get all apps associated with an App Service plan.
   */
  // FIXME: AppServicePlans_ListWebApps could not be converted to a resource operation
  @summary("Get all apps associated with an App Service plan.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/sites")
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
       * Name of the App Service plan.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Skip to a web app in the list of webapps associated with app service plan. If specified, the resulting list will contain web apps starting from (including) the skipToken. Otherwise, the resulting list contains web apps from the start of the list
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Supported filter: $filter=state eq running. Returns only web apps that are currently running
       */
      @query("$filter")
      $filter?: string;

      /**
       * List page size. If specified, results are paged.
       */
      @query("$top")
      $top?: string;
    },
    ResourceListResult<Site>
  >;

  /**
   * Description for Gets all selectable SKUs for a given App Service Plan
   */
  // FIXME: AppServicePlans_GetServerFarmSkus could not be converted to a resource operation
  @summary("Gets all selectable SKUs for a given App Service Plan")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/skus")
  @get
  getServerFarmSkus is Azure.Core.Foundations.Operation<
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
       * Name of App Service Plan
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
   * Description for Gets server farm usage information
   */
  // FIXME: AppServicePlans_ListUsages could not be converted to a resource operation
  @summary("Gets server farm usage information")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/usages")
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
       * Name of App Service Plan
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Return only usages/metrics specified in the filter. Filter conforms to odata syntax. Example: $filter=(name.value eq 'Metric1' or name.value eq 'Metric2').
       */
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
