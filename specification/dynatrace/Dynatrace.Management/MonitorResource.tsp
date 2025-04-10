import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Dynatrace.Observability;
/**
 * Dynatrace Monitor Resource
 */
model MonitorResource
  is Azure.ResourceManager.TrackedResource<MonitorProperties, false> {
  ...ResourceNameParameter<
    Resource = MonitorResource,
    KeyName = "monitorName",
    SegmentName = "monitors",
    NamePattern = ""
  >;

  /**
   * The managed service identities assigned to this resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: IdentityProperties;
}

@armResourceOperations
interface MonitorResources {
  /**
   * Get a MonitorResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_Get")
  get is ArmResourceRead<MonitorResource>;

  /**
   * Create a MonitorResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MonitorResource>;

  /**
   * Update a MonitorResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("Monitors_Update")
  update is ArmCustomPatchSync<
    MonitorResource,
    PatchModel = MonitorResourceUpdate
  >;

  /**
   * Delete a MonitorResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Monitors_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    MonitorResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List MonitorResource resources by resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<MonitorResource>;

  /**
   * List all MonitorResource by subscriptionId
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListBySubscriptionId")
  listBySubscriptionId is ArmListBySubscription<MonitorResource>;

  /**
   * List the resources currently being monitored by the Dynatrace monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListMonitoredResources")
  listMonitoredResources is ArmResourceActionSync<
    MonitorResource,
    void,
    ArmResponse<MonitoredResourceListResponse>
  >;

  /**
   * Returns the payload that needs to be passed in the request body for installing Dynatrace agent on a VM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_GetVMHostPayload")
  getVMHostPayload is ArmResourceActionSync<
    MonitorResource,
    void,
    ArmResponse<VMExtensionPayload>
  >;

  /**
   * List the VM/VMSS resources currently being monitored by the Dynatrace resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListHosts")
  listHosts is ArmResourceActionSync<
    MonitorResource,
    void,
    ArmResponse<VMHostsListResponse>
  >;

  /**
   * Get metric status
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_GetMetricStatus")
  getMetricStatus is ArmResourceActionSync<
    MonitorResource,
    void,
    ArmResponse<MetricsStatusResponse>
  >;

  /**
   * Gets list of App Services with Dynatrace PaaS OneAgent enabled
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListAppServices")
  listAppServices is ArmResourceActionSync<
    MonitorResource,
    void,
    ArmResponse<AppServiceListResponse>
  >;

  /**
   * Gets the SSO configuration details from the partner.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_GetSSODetails")
  getSSODetails is ArmResourceActionSync<
    MonitorResource,
    {
      /**
       * The details of the get sso details request.
       */
      @bodyRoot
      request?: SSODetailsRequest;
    },
    ArmResponse<SSODetailsResponse>
  >;

  /**
   * Gets all the Dynatrace environments that a user can link a azure resource to
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Monitors_ListLinkableEnvironments")
  listLinkableEnvironments is ArmResourceActionSync<
    MonitorResource,
    LinkableEnvironmentRequest,
    ArmResponse<LinkableEnvironmentListResponse>
  >;
}

@@doc(MonitorResource.name, "Monitor resource name");
@@doc(MonitorResource.properties,
  "The resource-specific properties for this resource."
);
@@doc(MonitorResources.listLinkableEnvironments::parameters.body,
  "The details of the linkable environment request."
);
