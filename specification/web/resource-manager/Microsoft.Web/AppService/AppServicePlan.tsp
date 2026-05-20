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
 * App Service plan.
 */
model AppServicePlan
  is Azure.ResourceManager.TrackedResource<AppServicePlanProperties> {
  ...ResourceNameParameter<
    Resource = AppServicePlan,
    KeyName = "name",
    SegmentName = "serverfarms",
    NamePattern = ""
  >;

  /**
   * Description of a SKU for a scalable resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: SkuDescription;

  /**
   * Extended Location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /** Kind of resource. If the resource is an app, you can refer to https://github.com/Azure/app-service-linux-docs/blob/master/Things_You_Should_Know/kind_property.md#app-service-resource-kind-reference for details supported values for kind. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;

  /**
   * Managed service identity.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}

alias AppServicePlanActionParamsOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
  },
  {
    /** App Service plan. */
    @path
    @segment("serverfarms")
    @key
    name: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/serverfarms",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface AppServicePlans {
  /**
   * Description for Get the RDP password for an IsCustomMode ServerFarm.
   */
  @summary("Get the RDP password for an IsCustomMode ServerFarm.")
  @action("getrdppassword")
  getServerFarmRdpPassword is ArmResourceActionSync<
    AppServicePlan,
    void,
    ArmResponse<ServerFarmRdpDetails>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Recycles a managed instance worker machine.
   */
  @summary("Recycles a managed instance worker machine.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/serverfarms/{name}/workers/{workerName}/recycleinstance")
  recycleManagedInstanceWorker is AppServicePlanActionParamsOps.ActionSync<
    AppServicePlan,
    void,
    ArmResponse<Operation>,
    Parameters = {
      /**
       * Name of worker machine, which typically starts with RD.
       */
      @pattern("^[a-zA-Z0-9]+$")
      @path
      workerName: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;
  /**
   * Description for Get the instance details for an app service plan.
   */
  @summary("Get the instance details for an app service plan.")
  @action("listinstances")
  getServerFarmInstanceDetails is ArmResourceActionSync<
    AppServicePlan,
    void,
    ArmResponse<ServerFarmInstanceDetails>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get an App Service plan.
   */
  @summary("Get an App Service plan.")
  get is ArmResourceRead<
    AppServicePlan,
    Response = ArmResponse<AppServicePlan> | ArmNotFoundResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates or updates an App Service Plan.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates or updates an App Service Plan.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AppServicePlan,
    Response = ArmResourceUpdatedResponse<AppServicePlan> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = AppServicePlan>> & {
      @bodyRoot
      _: AppServicePlan;
    }),
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates or updates an App Service Plan.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates or updates an App Service Plan.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AppServicePlan,
    PatchModel = AppServicePlanPatchResource,
    Response = ArmResponse<AppServicePlan> | (AcceptedResponse & {
      @bodyRoot
      _: AppServicePlan;
    }),
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Delete an App Service plan.
   */
  @summary("Delete an App Service plan.")
  delete is ArmResourceDeleteSync<AppServicePlan, Error = DefaultErrorResponse>;

  /**
   * Description for Get all App Service plans in a resource group.
   */
  @summary("Get all App Service plans in a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    AppServicePlan,
    Response = ArmResponse<AppServicePlanCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get all App Service plans for a subscription.
   */
  @summary("Get all App Service plans for a subscription.")
  list is ArmListBySubscription<
    AppServicePlan,
    Parameters = {
      /**
       * Specify <code>true</code> to return all App Service plan properties. The default is <code>false</code>, which returns a subset of the properties.
       *  Retrieval of all properties may increase the API latency.
       */
      @query("detailed")
      detailed?: boolean;
    },
    Response = ArmResponse<AppServicePlanCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for List all capabilities of an App Service plan.
   */
  @summary("List all capabilities of an App Service plan.")
  @get
  @action("capabilities")
  listCapabilities is ArmResourceActionSync<
    AppServicePlan,
    void,
    ArmResponse<Capability[]>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Retrieve all Hybrid Connections in use in an App Service plan.
   */
  @summary("Retrieve all Hybrid Connections in use in an App Service plan.")
  @get
  @action("hybridConnectionRelays")
  @list
  listHybridConnections is ArmResourceActionSync<
    AppServicePlan,
    void,
    ArmResponse<HybridConnectionCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Restart all apps in an App Service plan.
   */
  @summary("Restart all apps in an App Service plan.")
  @action("restartSites")
  restartWebApps is ArmResourceActionSync<
    AppServicePlan,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * Specify <code>true</code> to perform a soft restart, applies the configuration settings and restarts the apps if necessary. The default is <code>false</code>, which always restarts and reprovisions the apps
       */
      @query("softRestart")
      softRestart?: boolean;
    },
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get all apps associated with an App Service plan.
   */
  @summary("Get all apps associated with an App Service plan.")
  @get
  @action("sites")
  @list
  listWebApps is ArmResourceActionSync<
    AppServicePlan,
    void,
    ArmResponse<WebAppCollection>,
    Parameters = {
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
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets all selectable SKUs for a given App Service Plan
   */
  @summary("Gets all selectable SKUs for a given App Service Plan")
  @get
  @action("skus")
  getServerFarmSkus is ArmResourceActionSync<
    AppServicePlan,
    void,
    ArmResponse<unknown>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets server farm usage information
   */
  @get
  @action("usages")
  @list
  @summary("Gets server farm usage information")
  listUsages is ArmResourceActionSync<
    AppServicePlan,
    void,
    ArmResponse<CsmUsageQuotaCollection>,
    Parameters = {
      /**
       * Return only usages/metrics specified in the filter. Filter conforms to odata syntax. Example: $filter=(name.value eq 'Metric1' or name.value eq 'Metric2').
       */
      @query("$filter")
      $filter?: string;
    },
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Reboot a worker machine in an App Service plan.
   */
  @summary("Reboot a worker machine in an App Service plan.")
  @action("reboot")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/serverfarms/{name}/workers/{workerName}/reboot")
  rebootWorker is AppServicePlanActionParamsOps.ActionSync<
    AppServicePlan,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * Name of worker machine, which typically starts with RD.
       */
      @path
      workerName: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(AppServicePlan.name, "Name of the App Service plan.");
@@doc(AppServicePlan.properties, "AppServicePlan resource specific properties");
@@doc(AppServicePlans.createOrUpdate::parameters.resource,
  "Details of the App Service plan."
);
@@doc(AppServicePlans.update::parameters.properties,
  "Details of the App Service plan."
);
