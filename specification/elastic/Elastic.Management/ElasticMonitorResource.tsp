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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;

  /**
   * SKU of the monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: ResourceSku;

  /**
   * Identity properties of the monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: IdentityProperties;
}

@armResourceOperations
interface ElasticMonitorResources {
  /**
   * Get the properties of a specific monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_Get")
  get is ArmResourceRead<ElasticMonitorResource>;

  /**
   * Create a monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_Create")
  create is ArmResourceCreateOrReplaceAsync<ElasticMonitorResource>;

  /**
   * Update a monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("Monitors_Update")
  update is ArmCustomPatchAsync<
    ElasticMonitorResource,
    PatchModel = ElasticMonitorResourceUpdateParameters,
    Response = ArmResponse<ElasticMonitorResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: ElasticMonitorResource;
    })
  >;

  /**
   * Delete a monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Monitors_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ElasticMonitorResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all monitors under the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    ElasticMonitorResource,
    Response = ArmResponse<ElasticMonitorResourceListResponse>
  >;

  /**
   * List all monitors under the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_List")
  list is ArmListBySubscription<
    ElasticMonitorResource,
    Response = ArmResponse<ElasticMonitorResourceListResponse>
  >;

  /**
   * List the resources currently being monitored by the Elastic monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listMonitoredResources")
  @operationId("MonitoredResources_List")
  monitoredResourcesList is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<MonitoredResourceListResponse>
  >;

  /**
   * Fetch information regarding Elastic cloud deployment corresponding to the Elastic monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listDeploymentInfo")
  @operationId("DeploymentInfo_List")
  deploymentInfoList is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<DeploymentInfoResponse>
  >;

  /**
   * Create User inside elastic deployment which are used by customers to perform operations on the elastic deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
    ArmResponse<ExternalUserCreationResponse>
  >;

  /**
   * Get marketplace and organization info mapped to the given monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("getBillingInfo")
  @operationId("BillingInfo_Get")
  billingInfoGet is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<BillingInfoResponse>
  >;

  /**
   * List of all active deployments that are associated with the marketplace subscription linked to the given monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listConnectedPartnerResources")
  @operationId("ConnectedPartnerResources_List")
  connectedPartnerResourcesList is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<ConnectedPartnerResourcesListResponse>
  >;

  /**
   * List the vm resources currently being monitored by the Elastic monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listVMHost")
  @operationId("VMHost_List")
  vMHostList is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<VMHostListResponse>
  >;

  /**
   * List the vm ingestion details that will be monitored by the Elastic monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("vmIngestionDetails")
  @operationId("VMIngestion_Details")
  details is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<VMIngestionDetailsResponse>
  >;

  /**
   * Update the vm details that will be monitored by the Elastic monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
    OkResponse
  >;

  /**
   * List of upgradable versions for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listUpgradableVersions")
  @operationId("UpgradableVersions_Details")
  upgradableVersionsDetails is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<UpgradableVersionsList>
  >;

  /**
   * Upgradable version for a monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ElasticMonitorResource>
  >;

  /**
   * Get the list of all traffic filters for the account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listAllTrafficFilters")
  @operationId("AllTrafficFilters_list")
  allTrafficFiltersList is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<ElasticTrafficFilterResponse>
  >;

  /**
   * Get the list of all associated traffic filters for the given deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listAssociatedTrafficFilters")
  @operationId("listAssociatedTrafficFilters_list")
  listAssociatedTrafficFiltersList is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    ArmResponse<ElasticTrafficFilterResponse>
  >;

  /**
   * Create and Associate IP traffic filter for the given deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
    }
  >;

  /**
   * Create and Associate private link traffic filter for the given deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
    }
  >;

  /**
   * Associate traffic filter for the given deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
    }
  >;

  /**
   * Detach and Delete traffic filter from the given deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
    }
  >;

  /**
   * Detach traffic filter for the given deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
    }
  >;

  /**
   * Delete traffic filter from the account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
    }
  >;

  /**
   * Resubscribe the Elasticsearch Organization.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
    ArmResponse<ElasticMonitorResource>
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
