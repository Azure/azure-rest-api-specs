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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatadogMonitorResource
  is Azure.ResourceManager.TrackedResource<MonitorProperties, true> {
  ...ResourceNameParameter<
    Resource = DatadogMonitorResource,
    KeyName = "monitorName",
    SegmentName = "monitors",
    NamePattern = ""
  >;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ResourceSku;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: IdentityProperties;
}

@armResourceOperations
interface DatadogMonitorResourcesOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /**
         * Monitor resource name
         */
        @path
        @segment("monitors")
        monitorName: string,
      },
      ErrorResponse
    > {}

@armResourceOperations
interface DatadogMonitorResources {
  /**
   * Get the properties of a specific monitor resource.
   */
  get is ArmResourceRead<DatadogMonitorResource>;

  /**
   * Create a monitor resource.
   */
  create is DatadogMonitorResourcesOps.CreateOrUpdateAsync<
    DatadogMonitorResource,
    OptionalRequestBody = true
  >;

  /**
   * Update a monitor resource.
   */
  @patch(#{ implicitOptionality: false })
  update is DatadogMonitorResourcesOps.CustomPatchAsync<
    DatadogMonitorResource,
    PatchModel = DatadogMonitorResourceUpdateParameters,
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
  delete is ArmResourceDeleteWithoutOkAsync<
    DatadogMonitorResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all monitors under the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    DatadogMonitorResource,
    Response = ArmResponse<DatadogMonitorResourceListResponse>
  >;

  /**
   * List all monitors under the specified subscription.
   */
  list is ArmListBySubscription<
    DatadogMonitorResource,
    Response = ArmResponse<DatadogMonitorResourceListResponse>
  >;

  /**
   * List the api keys for a given monitor resource.
   */
  @list
  listApiKeys is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<DatadogApiKeyListResponse>
  >;

  /**
   * Get the default api key.
   */
  getDefaultKey is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<DatadogApiKey>
  >;

  /**
   * Set the default api key.
   */
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
  listHosts is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<DatadogHostListResponse>
  >;

  /**
   * List all Azure resources associated to the same Datadog organization as the target resource.
   */
  @list
  listLinkedResources is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<LinkedResourceListResponse>
  >;

  /**
   * List the resources currently being monitored by the Datadog monitor resource.
   */
  @list
  listMonitoredResources is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<MonitoredResourceListResponse>
  >;

  /**
   * Refresh the set password link and return a latest one.
   */
  refreshSetPasswordLink is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    ArmResponse<DatadogSetPasswordLink>
  >;

  /**
   * Get marketplace and organization info mapped to the given monitor.
   */
  @action("getBillingInfo")
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
@@doc(DatadogMonitorResources.setDefaultKey::parameters.body, "");
