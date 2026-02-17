import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Datadog;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatadogMonitorResource
  is Azure.ResourceManager.TrackedResource<MonitorProperties, true> {
  ...ResourceNameParameter<
    Resource = DatadogMonitorResource,
    KeyName = "monitorName",
    SegmentName = "monitors",
    NamePattern = "^[a-zA-Z0-9_][a-zA-Z0-9_-]+$"
  >;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ResourceSku;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: IdentityProperties;
}

@armResourceOperations
interface DatadogMonitorResources {
  /**
   * Get the properties of a specific monitor resource.
   */
  @summary("Get the properties of a specific monitor resource.")
  get is ArmResourceRead<DatadogMonitorResource>;

  /**
   * Create a monitor resource.
   */
  @summary("Create a monitor resource.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    DatadogMonitorResource,
    OptionalRequestBody = true
  >;

  /**
   * Update a monitor resource.
   */
  @summary("Update a monitor resource.")
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CreateOrReplaceAsync<
    DatadogMonitorResource,
    Request = DatadogMonitorResourceUpdateParameters,
    Response = ArmResponse<DatadogMonitorResource> | ArmResourceCreatedResponse<
      DatadogMonitorResource,
      LroHeaders = ArmLroLocationHeader<FinalResult = DatadogMonitorResource> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    OptionalRequestBody = true
  >;

  /**
   * Delete a monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a monitor resource.")
  delete is ArmResourceDeleteWithoutOkAsync<
    DatadogMonitorResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all monitors under the specified resource group.
   */
  @summary("List all monitors under the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<
    DatadogMonitorResource,
    Response = ArmResponse<DatadogMonitorResourceListResponse>
  >;

  /**
   * List all monitors under the specified subscription.
   */
  @summary("List all monitors under the specified subscription.")
  list is ArmListBySubscription<
    DatadogMonitorResource,
    Response = ArmResponse<DatadogMonitorResourceListResponse>
  >;

  /**
   * Manages Datadog MCP connectors to add/remove for the SRE Agent.
   */
  @added(Microsoft.Datadog.Versions.v2025_11_03_preview)
  manageSreAgentConnectors is ArmResourceActionSync<
    DatadogMonitorResource,
    SreAgentConnectorRequest,
    ArmResponse<SreAgentConfigurationListResponse>
  >;

  /**
   * Get the default application key.
   */
  @summary("Get the default application key.")
  @added(Versions.v2025_11_03_preview)
  getDefaultApplicationKey is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<DatadogApplicationKey>
  >;

  /**
   * List the api keys for a given monitor resource.
   */
  @list
  @summary("List the api keys for a given monitor resource.")
  listApiKeys is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<DatadogApiKeyListResponse>
  >;

  /**
   * Get the default api key.
   */
  @summary("Get the default api key.")
  getDefaultKey is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<DatadogApiKey>
  >;

  /**
   * Set the default api key.
   */
  @summary("Set the default api key.")
  setDefaultKey is ArmResourceActionSync<
    DatadogMonitorResource,
    DatadogApiKey,
    OkResponse,
    OptionalRequestBody = true
  >;

  /**
   * List the hosts for a given monitor resource.
   */
  @list
  @summary("List the hosts for a given monitor resource.")
  listHosts is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<DatadogHostListResponse>
  >;

  /**
   * List all Azure resources associated to the same Datadog organization as the target resource.
   */
  @list
  @summary("List all Azure resources associated to the same Datadog organization as the target resource.")
  listLinkedResources is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<LinkedResourceListResponse>
  >;

  /**
   * List the resources currently being monitored by the Datadog monitor resource.
   */
  @list
  @summary("List the resources currently being monitored by the Datadog monitor resource.")
  listMonitoredResources is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<MonitoredResourceListResponse>
  >;

  /**
   * Refresh the set password link and return a latest one.
   */
  @summary("Refresh the set password link and return a latest one.")
  refreshSetPasswordLink is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<DatadogSetPasswordLink>
  >;

  /**
   * Get marketplace and organization info mapped to the given monitor.
   */
  @summary("Get marketplace and organization info mapped to the given monitor.")
  @action("getBillingInfo")
  billingInfoGet is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<BillingInfoResponse>
  >;

  /**
   * Reinstate integration with your Datadog organization by choosing one of the available subscription plans.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Reinstate integration with your Datadog organization by choosing one of the available subscription plans.")
  resubscribe is ArmResourceActionAsync<
    DatadogMonitorResource,
    ResubscribeProperties,
    DatadogMonitorResource,
    OptionalRequestBody = true
  >;
}

@@maxLength(DatadogMonitorResource.name, 32);
@@minLength(DatadogMonitorResource.name, 2);
@@doc(DatadogMonitorResource.name, "Monitor resource name");
@@doc(DatadogMonitorResource.properties,
  "Properties specific to the monitor resource."
);
@@doc(DatadogMonitorResources.create::parameters.resource, "");
@@doc(DatadogMonitorResources.update::parameters.resource, "");
@@doc(DatadogMonitorResources.setDefaultKey::parameters.body, "");
@@doc(DatadogMonitorResources.resubscribe::parameters.body,
  "Resubscribe Properties"
);
