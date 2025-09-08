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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: SkuDescription;

  /**
   * Extended Location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface AppServicePlans {
  /**
   * Description for Get an App Service plan.
   */
  get is ArmResourceRead<
    AppServicePlan,
    Response = ArmResponse<AppServicePlan> | ArmNotFoundResponse
  >;

  /**
   * Description for Creates or updates an App Service Plan.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AppServicePlan,
    Response = ArmResourceUpdatedResponse<AppServicePlan> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: AppServicePlan;
    }),
    LroHeaders = ArmLroLocationHeader<FinalResult = AppServicePlan> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Description for Creates or updates an App Service Plan.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" ""
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AppServicePlan,
    PatchModel = AppServicePlanPatchResource,
    Response = ArmResponse<AppServicePlan> | (AcceptedResponse & {
      @bodyRoot
      _: AppServicePlan;
    })
  >;

  /**
   * Description for Delete an App Service plan.
   */
  delete is ArmResourceDeleteSync<AppServicePlan>;

  /**
   * Description for Get all App Service plans in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    AppServicePlan,
    Response = ArmResponse<AppServicePlanCollection>
  >;

  /**
   * Description for Get all App Service plans for a subscription.
   */
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
  @get
  @action("capabilities")
  listCapabilities is ArmResourceActionSync<
    AppServicePlan,
    void,
    ArmResponse<Capability[]>
  >;

  /**
   * Description for Retrieve all Hybrid Connections in use in an App Service plan.
   */
  @get
  @action("hybridConnectionRelays")
  @list
  listHybridConnections is ArmResourceActionSync<
    AppServicePlan,
    void,
    ArmResponse<HybridConnectionCollection>
  >;

  /**
   * Description for Restart all apps in an App Service plan.
   */
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
    }
  >;

  /**
   * Description for Get all apps associated with an App Service plan.
   */
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
    }
  >;

  /**
   * Description for Gets all selectable SKUs for a given App Service Plan
   */
  @get
  @action("skus")
  getServerFarmSkus is ArmResourceActionSync<
    AppServicePlan,
    void,
    ArmResponse<unknown>
  >;

  /**
   * Description for Gets server farm usage information
   */
  @get
  @action("usages")
  @list
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
    }
  >;

  /**
   * Description for Reboot a worker machine in an App Service plan.
   */
  @action("reboot")
  rebootWorker is ArmResourceActionSync<
    AppServicePlan,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * Name of worker machine, which typically starts with RD.
       */
      @path
      @segment("workers")
      workerName: string;
    }
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
