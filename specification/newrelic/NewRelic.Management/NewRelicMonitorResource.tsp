import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace NewRelic.Observability;
/**
 * A Monitor Resource by NewRelic
 */
model NewRelicMonitorResource
  is Azure.ResourceManager.TrackedResource<MonitorProperties, false> {
  ...ResourceNameParameter<
    Resource = NewRelicMonitorResource,
    KeyName = "monitorName",
    SegmentName = "monitors",
    NamePattern = "^.*$"
  >;

  /**
   * The managed service identities assigned to this resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

@armResourceOperations
interface NewRelicMonitorResourceWithoutPatternOperations
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = NewRelicMonitorResource,
        KeyName = "monitorName",
        SegmentName = "monitors",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface NewRelicMonitorResources {
  /**
   * Retrieves the properties and configuration details of a specific New Relic monitor resource, providing insight into its setup and status
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_Get")
  get is NewRelicMonitorResourceWithoutPatternOperations.Read<NewRelicMonitorResource>;

  /**
   * Creates a new or updates an existing New Relic monitor resource in your Azure subscription. This sets up the integration between Azure and your New Relic account, enabling observability and monitoring of your Azure resources through New Relic
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_CreateOrUpdate")
  createOrUpdate is NewRelicMonitorResourceWithoutPatternOperations.CreateOrUpdateAsync<NewRelicMonitorResource>;

  /**
   * Updates an existing New Relic monitor resource from your Azure subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_Update")
  @patch(#{ implicitOptionality: false })
  update is NewRelicMonitorResourceWithoutPatternOperations.CustomPatchAsync<
    NewRelicMonitorResource,
    PatchModel = NewRelicMonitorResourceUpdate
  >;

  /**
   * Deletes an existing New Relic monitor resource from your Azure subscription, removing the integration and stopping the observability of your Azure resources through New Relic
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Monitors_Delete")
  delete is NewRelicMonitorResourceWithoutPatternOperations.DeleteWithoutOkAsync<
    NewRelicMonitorResource,
    Parameters = {
      /**
       * User Email.
       */
      @query("userEmail")
      userEmail: string;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Retrieves a list of all New Relic monitor resources either a specific resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<NewRelicMonitorResource>;

  /**
   * Lists all New Relic monitor resources either within a specific subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListBySubscription")
  listBySubscription is ArmListBySubscription<NewRelicMonitorResource>;

  /**
   * Retrieves the metric rules that are configured in the New Relic monitor resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_GetMetricRules")
  getMetricRules is NewRelicMonitorResourceWithoutPatternOperations.ActionSync<
    NewRelicMonitorResource,
    MetricsRequest,
    ArmResponse<MetricRules>
  >;

  /**
   * Retrieves the metric status that are configured in the New Relic monitor resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_GetMetricStatus")
  getMetricStatus is NewRelicMonitorResourceWithoutPatternOperations.ActionSync<
    NewRelicMonitorResource,
    MetricsStatusRequest,
    ArmResponse<MetricsStatusResponse>
  >;

  /**
   * Lists the app service resources currently being monitored by the New Relic resource, helping you understand which app services are under monitoring
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListAppServices")
  listAppServices is NewRelicMonitorResourceWithoutPatternOperations.ActionSync<
    NewRelicMonitorResource,
    AppServicesGetRequest,
    ArmResponse<AppServicesListResponse>
  >;

  /**
   * Switches the billing for the New Relic Monitor resource to be billed by Azure Marketplace
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_SwitchBilling")
  switchBilling is NewRelicMonitorResourceWithoutPatternOperations.ActionSync<
    NewRelicMonitorResource,
    SwitchBillingRequest,
    ArmResponse<NewRelicMonitorResource> | AcceptedResponse | NoContentResponse
  >;

  /**
   * Lists all VM resources currently being monitored by the New Relic monitor resource, helping you manage observability
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListHosts")
  listHosts is NewRelicMonitorResourceWithoutPatternOperations.ActionSync<
    NewRelicMonitorResource,
    HostsGetRequest,
    ArmResponse<VMHostsListResponse>
  >;

  /**
   * Refreshes the ingestion key for all monitors linked to the same account associated to the underlying monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_RefreshIngestionKey")
  refreshIngestionKey is NewRelicMonitorResourceWithoutPatternOperations.ActionSync<
    NewRelicMonitorResource,
    void,
    NoContentResponse
  >;

  /**
   * Lists all Azure resources that are currently being monitored by the specified New Relic monitor resource, providing insight into the coverage of your observability setup
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListMonitoredResources")
  @action("monitoredResources")
  listMonitoredResources is NewRelicMonitorResourceWithoutPatternOperations.ActionSync<
    NewRelicMonitorResource,
    void,
    ArmResponse<MonitoredResourceListResponse>
  >;

  /**
   * Lists all Azure resources that are linked to the same New Relic organization as the specified monitor resource, helping you understand the scope of integration
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListLinkedResources")
  listLinkedResources is ArmResourceActionSync<
    NewRelicMonitorResource,
    void,
    ArmResponse<LinkedResourceListResponse>
  >;

  /**
   * Returns the payload that needs to be passed in the request body for installing the New Relic agent on a VM, providing the necessary configuration details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_VmHostPayload")
  @action("vmHostPayloads")
  vmHostPayload is ArmResourceActionSync<
    NewRelicMonitorResource,
    void,
    ArmResponse<VMExtensionPayload>
  >;

  /**
   * Returns the latest SaaS linked to the newrelic organization of the underlying monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_LatestLinkedSaaS")
  latestLinkedSaaS is ArmResourceActionSync<
    NewRelicMonitorResource,
    void,
    ArmResponse<LatestLinkedSaaSResponse>
  >;

  /**
   * Links a new SaaS to the newrelic organization of the underlying monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_LinkSaaS")
  linkSaaS is ArmResourceActionAsync<
    NewRelicMonitorResource,
    SaaSData,
    ArmResponse<NewRelicMonitorResource>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Resubscribes the New Relic Organization of the underline Monitor Resource to be billed by Azure Marketplace
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_Resubscribe")
  resubscribe is ArmResourceActionAsync<
    NewRelicMonitorResource,
    ResubscribeProperties,
    ArmResponse<NewRelicMonitorResource>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Retrieves marketplace and organization information mapped to the given New Relic monitor resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BillingInfo_Get")
  @action("getBillingInfo")
  billingInfoGet is ArmResourceActionSync<
    NewRelicMonitorResource,
    void,
    ArmResponse<BillingInfoResponse>
  >;

  /**
   * List of all active deployments that are associated with the marketplace subscription linked to the given monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedPartnerResources_List")
  @action("listConnectedPartnerResources")
  list is ArmResourceActionSync<
    NewRelicMonitorResource,
    {
      /**
       * Email Id of the user
       */
      @bodyRoot
      body?: string;
    },
    ArmResponse<ConnectedPartnerResourcesListResponse>
  >;
}

@@doc(NewRelicMonitorResource.name, "Name of the Monitors resource");
@@doc(NewRelicMonitorResource.properties,
  "The resource-specific properties for this resource."
);
@@doc(NewRelicMonitorResources.getMetricRules::parameters.body,
  "The details of the get metrics status request."
);
@@doc(NewRelicMonitorResources.getMetricStatus::parameters.body,
  "The details of the get metrics status request."
);
@@doc(NewRelicMonitorResources.listAppServices::parameters.body,
  "The details of the app services get request."
);
@@doc(NewRelicMonitorResources.switchBilling::parameters.body,
  "The details of the switch billing request."
);
@@doc(NewRelicMonitorResources.listHosts::parameters.body,
  "The details of the Hosts get request."
);
@@doc(NewRelicMonitorResources.linkSaaS::parameters.body,
  "Link SaaS body parameter"
);
@@doc(NewRelicMonitorResources.resubscribe::parameters.body,
  "Resubscribe Properties"
);
