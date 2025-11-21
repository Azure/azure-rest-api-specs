import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

@armResourceOperations
interface NewRelicMonitorResources {
  /**
   * Retrieves the properties and configuration details of a specific New Relic monitor resource, providing insight into its setup and status
   */
  get is ArmResourceRead<NewRelicMonitorResource>;

  /**
   * Creates a new or updates an existing New Relic monitor resource in your Azure subscription. This sets up the integration between Azure and your New Relic account, enabling observability and monitoring of your Azure resources through New Relic
   */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NewRelicMonitorResource>;

  /**
   * Updates an existing New Relic monitor resource from your Azure subscription
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NewRelicMonitorResource,
    PatchModel = NewRelicMonitorResourceUpdate
  >;

  /**
   * Deletes an existing New Relic monitor resource from your Azure subscription, removing the integration and stopping the observability of your Azure resources through New Relic
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
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
  listByResourceGroup is ArmResourceListByParent<NewRelicMonitorResource>;

  /**
   * Lists all New Relic monitor resources either within a specific subscription
   */
  listBySubscription is ArmListBySubscription<NewRelicMonitorResource>;

  /**
   * Retrieves the metric rules that are configured in the New Relic monitor resource
   */
  getMetricRules is ArmResourceActionSync<
    NewRelicMonitorResource,
    MetricsRequest,
    ArmResponse<MetricRules>
  >;

  /**
   * Retrieves the metric status that are configured in the New Relic monitor resource
   */
  getMetricStatus is ArmResourceActionSync<
    NewRelicMonitorResource,
    MetricsStatusRequest,
    ArmResponse<MetricsStatusResponse>
  >;

  /**
   * Lists the app service resources currently being monitored by the New Relic resource, helping you understand which app services are under monitoring
   */
  @list
  listAppServices is ArmResourceActionSync<
    NewRelicMonitorResource,
    AppServicesGetRequest,
    ArmResponse<AppServicesListResponse>
  >;

  /**
   * Switches the billing for the New Relic Monitor resource to be billed by Azure Marketplace
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  switchBilling is ArmResourceActionSync<
    NewRelicMonitorResource,
    SwitchBillingRequest,
    ArmResponse<NewRelicMonitorResource> | (AcceptedResponse &
      Azure.Core.Foundations.RetryAfterHeader) | NoContentResponse
  >;

  /**
   * Lists all VM resources currently being monitored by the New Relic monitor resource, helping you manage observability
   */
  @list
  listHosts is ArmResourceActionSync<
    NewRelicMonitorResource,
    HostsGetRequest,
    ArmResponse<VMHostsListResponse>
  >;

  /**
   * Refreshes the ingestion key for all monitors linked to the same account associated to the underlying monitor.
   */
  refreshIngestionKey is ArmResourceActionSync<
    NewRelicMonitorResource,
    void,
    NoContentResponse
  >;

  /**
   * Lists all Azure resources that are currently being monitored by the specified New Relic monitor resource, providing insight into the coverage of your observability setup
   */
  @list
  @action("monitoredResources")
  listMonitoredResources is ArmResourceActionSync<
    NewRelicMonitorResource,
    void,
    ArmResponse<MonitoredResourceListResponse>
  >;

  /**
   * Lists all Azure resources that are linked to the same New Relic organization as the specified monitor resource, helping you understand the scope of integration
   */
  @list
  @summary("Lists all Azure resources that are linked to the same New Relic organization as the specified monitor resource, helping you understand the scope of integration")
  listLinkedResources is ArmResourceActionSync<
    NewRelicMonitorResource,
    void,
    ArmResponse<LinkedResourceListResponse>
  >;

  /**
   * Returns the payload that needs to be passed in the request body for installing the New Relic agent on a VM, providing the necessary configuration details
   */
  @action("vmHostPayloads")
  vmHostPayload is ArmResourceActionSync<
    NewRelicMonitorResource,
    void,
    ArmResponse<VMExtensionPayload>
  >;

  /**
   * Returns the latest SaaS linked to the newrelic organization of the underlying monitor.
   */
  latestLinkedSaaS is ArmResourceActionSync<
    NewRelicMonitorResource,
    void,
    ArmResponse<LatestLinkedSaaSResponse>
  >;

  /**
   * Links a new SaaS to the newrelic organization of the underlying monitor.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Links a new SaaS to the newrelic organization of the underlying monitor.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  linkSaaS is ArmResourceActionAsync<
    NewRelicMonitorResource,
    SaaSData,
    ArmResponse<NewRelicMonitorResource>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = NewRelicMonitorResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @summary("Resubscribes the New Relic Organization of the underline Monitor Resource to be billed by Azure Marketplace")
  resubscribe is ArmResourceActionAsync<
    NewRelicMonitorResource,
    ResubscribeProperties,
    ArmResponse<NewRelicMonitorResource>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = NewRelicMonitorResource> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  @action("getBillingInfo")
  @summary("Retrieves marketplace and organization information mapped to the given New Relic monitor resource")
  billingInfoGet is ArmResourceActionSync<
    NewRelicMonitorResource,
    void,
    ArmResponse<BillingInfoResponse>
  >;

  @list
  @action("listConnectedPartnerResources")
  @summary("List of all active deployments that are associated with the marketplace subscription linked to the given monitor.")
  list is ArmResourceActionSync<
    NewRelicMonitorResource,
    email,
    ArmResponse<ConnectedPartnerResourcesListResponse>,
    OptionalRequestBody = true
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
@@doc(NewRelicMonitorResources.list::parameters.body, "Email Id of the user");
