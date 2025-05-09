import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace Microsoft.Datadog;

#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" ""
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@Azure.ResourceManager.Private.armResourceInternal(IdentityProperties)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
model DatadogMonitorResource
  extends Azure.ResourceManager.Foundations.TrackedResource {
  ...ResourceNameParameter<
    Resource = DatadogMonitorResource,
    KeyName = "monitorName",
    SegmentName = "monitors",
    NamePattern = ""
  >;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: ResourceSku;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" ""
  @Azure.ResourceManager.Private.conditionalClientFlatten
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(true)
  properties?: MonitorProperties;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: IdentityProperties;
}

@armResourceOperations
interface DatadogMonitorResources {
  /**
   * Get the properties of a specific monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_Get")
  get is ArmResourceRead<DatadogMonitorResource>;

  /**
   * Create a monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_Create")
  create is ArmResourceCreateOrReplaceAsync<DatadogMonitorResource>;

  /**
   * Update a monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("Monitors_Update")
  update is ArmCustomPatchAsync<
    DatadogMonitorResource,
    PatchModel = DatadogMonitorResourceUpdateParameters,
    Response = ArmResponse<DatadogMonitorResource> | (ArmResourceCreatedResponse<DatadogMonitorResource> &
      ArmLroLocationHeader)
  >;

  /**
   * Delete a monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Monitors_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    DatadogMonitorResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all monitors under the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    DatadogMonitorResource,
    Response = ArmResponse<DatadogMonitorResourceListResponse>
  >;

  /**
   * List all monitors under the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_List")
  list is ArmListBySubscription<
    DatadogMonitorResource,
    Response = ArmResponse<DatadogMonitorResourceListResponse>
  >;

  /**
   * List the api keys for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListApiKeys")
  listApiKeys is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<DatadogApiKeyListResponse>
  >;

  /**
   * Get the default api key.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_GetDefaultKey")
  getDefaultKey is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<DatadogApiKey>
  >;

  /**
   * Set the default api key.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_SetDefaultKey")
  setDefaultKey is ArmResourceActionSync<
    DatadogMonitorResource,
    {
      @bodyRoot
      body?: DatadogApiKey;
    },
    OkResponse
  >;

  /**
   * List the hosts for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListHosts")
  listHosts is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<DatadogHostListResponse>
  >;

  /**
   * List all Azure resources associated to the same Datadog organization as the target resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListLinkedResources")
  listLinkedResources is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<LinkedResourceListResponse>
  >;

  /**
   * List the resources currently being monitored by the Datadog monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListMonitoredResources")
  listMonitoredResources is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<MonitoredResourceListResponse>
  >;

  /**
   * Refresh the set password link and return a latest one.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_RefreshSetPasswordLink")
  refreshSetPasswordLink is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<DatadogSetPasswordLink>
  >;

  /**
   * Get marketplace and organization info mapped to the given monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("getBillingInfo")
  @operationId("BillingInfo_Get")
  billingInfoGet is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<BillingInfoResponse>
  >;
}

@@doc(DatadogMonitorResource.name, "Monitor resource name");
@@doc(DatadogMonitorResource.properties,
  "Properties specific to the monitor resource."
);
@@doc(DatadogMonitorResources.create::parameters.resource, "");
@@doc(DatadogMonitorResources.update::parameters.properties, "");
