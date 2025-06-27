import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Elastic;
/**
 * Monitor resource.
 */
model ElasticMonitorResource
  is Azure.ResourceManager.TrackedResource<MonitorProperties> {
  ...ResourceNameParameter<
    Resource = ElasticMonitorResource,
    KeyName = "monitorName",
    SegmentName = "monitors",
    NamePattern = "^.*$"
  >;

  /**
   * The kind of the Elastic resource - observability, security, search etc.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;

  /**
   * SKU of the monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ResourceSku;

  /**
   * Identity properties of the monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: IdentityProperties;
}

/**
 * Represents the SKU of a resource.
 */
model ResourceSku {
  /**
   * The name of the SKU.
   */
  name: string;
}
@armResourceOperations
interface ElasticMonitorCreateOrUpdateResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("monitors")
        @pattern("^.*$")
        monitorName: string,
      },
      ErrorType = ResourceProviderDefaultErrorResponse
    > {}

@armResourceOperations
interface ElasticMonitorUpdateResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("monitors")
        @pattern("^.*$")
        monitorName: string,
      }
    > {}

@armResourceOperations
interface ElasticMonitorResources {
  /**
   * Get detailed properties of a specific Elastic monitor resource, helping you manage observability and performance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Monitors_Get")
  get is ArmResourceRead<
    ElasticMonitorResource,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create a new Elastic monitor resource in your Azure subscription, enabling observability and monitoring of your Azure resources through Elastic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Monitors_Create")
  create is ElasticMonitorCreateOrUpdateResourceOps.CreateOrUpdateAsync<
    ElasticMonitorResource,
    OptionalRequestBody = true
  >;

  /**
   * Update an existing Elastic monitor resource in your Azure subscription, ensuring optimal observability and performance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @operationId("Monitors_Update")
  update is ElasticMonitorUpdateResourceOps.CustomPatchAsync<
    ElasticMonitorResource,
    PatchModel = ElasticMonitorResourceUpdateParameters,
    Response = ArmResponse<ElasticMonitorResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: ElasticMonitorResource;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete an existing Elastic monitor resource from your Azure subscription, removing its observability and monitoring capabilities.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Monitors_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ElasticMonitorResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List all Elastic monitor resources within a specified resource group of the subscription, helping you audit and manage your monitoring setup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Monitors_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    ElasticMonitorResource,
    Response = ArmResponse<ElasticMonitorResourceListResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List all Elastic monitor resources within a specified subscription, helping you audit and manage your monitoring setup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Monitors_List")
  list is ArmListBySubscription<
    ElasticMonitorResource,
    Response = ArmResponse<ElasticMonitorResourceListResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List all resources currently being monitored by the Elastic monitor resource, helping you manage observability.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("listMonitoredResources")
  @operationId("MonitoredResources_List")
  monitoredResourcesList is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<MonitoredResourceListResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Fetch detailed information about Elastic cloud deployments corresponding to the Elastic monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("listDeploymentInfo")
  @operationId("DeploymentInfo_List")
  deploymentInfoList is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<DeploymentInfoResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create or update external user configurations for your Elastic monitor resource, enabling access and management by external users.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("createOrUpdateExternalUser")
  @operationId("ExternalUser_CreateOrUpdate")
  createOrUpdate is ArmResourceActionSync<
    ElasticMonitorResource,
    {
      /**
       * Elastic External User Creation Parameters
       */
      @bodyRoot
      body?: ExternalUserInfo;
    },
    ArmResponse<ExternalUserCreationResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Retrieve marketplace and organization billing information mapped to the given Elastic monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("getBillingInfo")
  @operationId("BillingInfo_Get")
  billingInfoGet is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<BillingInfoResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List all active deployments associated with the marketplace subscription linked to the given Elastic monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("listConnectedPartnerResources")
  @operationId("ConnectedPartnerResources_List")
  connectedPartnerResourcesList is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<ConnectedPartnerResourcesListResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List all VM resources currently being monitored by the Elastic monitor resource, helping you manage observability.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("listVMHost")
  @operationId("VMHost_List")
  vMHostList is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<VMHostListResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List detailed information about VM ingestion that will be monitored by the Elastic monitor resource, ensuring optimal observability and performance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("vmIngestionDetails")
  @operationId("VMIngestion_Details")
  details is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<VMIngestionDetailsResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Update the VM details that will be monitored by the Elastic monitor resource, ensuring optimal observability and performance.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("vmCollectionUpdate")
  @operationId("VMCollection_Update")
  vMCollectionUpdate is ArmResourceActionSync<
    ElasticMonitorResource,
    {
      /**
       * VM resource Id
       */
      @bodyRoot
      body?: VMCollectionUpdate;
    },
    OkResponse,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List all upgradable versions for your Elastic monitor resource, helping you plan and execute upgrades.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("listUpgradableVersions")
  @operationId("UpgradableVersions_Details")
  upgradableVersionsDetails is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<UpgradableVersionsList>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Upgrade the Elastic monitor resource to a newer version, ensuring optimal observability and performance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Monitor_Upgrade")
  upgrade is ArmResourceActionAsyncBase<
    ElasticMonitorResource,
    {
      /**
       * Elastic Monitor Upgrade Parameters
       */
      @bodyRoot
      body?: ElasticMonitorUpgrade;
    },
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ElasticMonitorResource>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List all traffic filters associated with your Elastic monitor resource, helping you manage network traffic control.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("listAllTrafficFilters")
  @operationId("AllTrafficFilters_list")
  allTrafficFiltersList is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<ElasticTrafficFilterResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List all traffic filters associated with your Elastic monitor resource, helping you manage network traffic control.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("listAssociatedTrafficFilters")
  @operationId("listAssociatedTrafficFilters_list")
  listAssociatedTrafficFiltersList is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<ElasticTrafficFilterResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create and associate an IP filter with your Elastic monitor resource to control and manage network traffic.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("createAndAssociateIPFilter")
  @operationId("createAndAssociateIPFilter_Create")
  createAndAssociateIPFilterCreate is ArmResourceActionAsync<
    ElasticMonitorResource,
    void,
    OkResponse,
    Parameters = {
      /**
       * List of ips
       */
      @query("ips")
      ips?: string;

      /**
       * Name of the traffic filter
       */
      @query("name")
      name?: string;
    },
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create and associate a PL filter with your Elastic monitor resource to control and manage network traffic.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("createAndAssociatePLFilter")
  @operationId("createAndAssociatePLFilter_Create")
  createAndAssociatePLFilterCreate is ArmResourceActionAsync<
    ElasticMonitorResource,
    void,
    OkResponse,
    Parameters = {
      /**
       * Name of the traffic filter
       */
      @query("name")
      name?: string;

      /**
       * Guid of the private endpoint
       */
      @query("privateEndpointGuid")
      privateEndpointGuid?: string;

      /**
       * Name of the private endpoint
       */
      @query("privateEndpointName")
      privateEndpointName?: string;
    },
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Associate a traffic filter with your Elastic monitor resource to control and manage network traffic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("associateTrafficFilter")
  @operationId("AssociateTrafficFilter_Associate")
  associate is ArmResourceActionAsyncBase<
    ElasticMonitorResource,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ElasticMonitorResource>,
    Parameters = {
      /**
       * Ruleset Id of the filter
       */
      @query("rulesetId")
      rulesetId?: string;
    },
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Detach and delete an existing traffic filter from your Elastic monitor resource, removing its network traffic control capabilities.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("detachAndDeleteTrafficFilter")
  @operationId("DetachAndDeleteTrafficFilter_Delete")
  detachAndDeleteTrafficFilterDelete is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    OkResponse,
    Parameters = {
      /**
       * Ruleset Id of the filter
       */
      @query("rulesetId")
      rulesetId?: string;
    },
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Detach an existing traffic filter from your Elastic monitor resource, removing its network traffic control capabilities.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("detachTrafficFilter")
  @operationId("DetachTrafficFilter_Update")
  detachTrafficFilterUpdate is ArmResourceActionAsyncBase<
    ElasticMonitorResource,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ElasticMonitorResource>,
    Parameters = {
      /**
       * Ruleset Id of the filter
       */
      @query("rulesetId")
      rulesetId?: string;
    },
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Delete an existing traffic filter associated with your Elastic monitor resource, removing its network traffic control capabilities.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("deleteTrafficFilter")
  @operationId("TrafficFilters_Delete")
  trafficFiltersDelete is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    OkResponse,
    Parameters = {
      /**
       * Ruleset Id of the filter
       */
      @query("rulesetId")
      rulesetId?: string;
    },
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Resubscribe the Elasticsearch Organization.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Organizations_Resubscribe")
  resubscribe is ArmResourceActionAsync<
    ElasticMonitorResource,
    {
      /**
       * Resubscribe Properties
       */
      @bodyRoot
      body?: ResubscribeProperties;
    },
    ElasticMonitorResource
  >;
}

@@doc(ElasticMonitorResource.name, "Monitor resource name");
@@doc(ElasticMonitorResource.properties, "Properties of the monitor resource.");
@@doc(ElasticMonitorResources.create::parameters.resource,
  "Elastic monitor resource model"
);
@@doc(ElasticMonitorResources.update::parameters.properties,
  "Elastic resource model update parameters."
);
