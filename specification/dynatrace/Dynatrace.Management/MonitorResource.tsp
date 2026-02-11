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
    NamePattern = "^[a-zA-Z0-9_-]*$"
  >;

  /**
   * The managed service identities assigned to this resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: IdentityProperties;
}

@armResourceOperations
interface MonitorResources {
  /**
   * Get a MonitorResource
   */
  get is ArmResourceRead<MonitorResource>;

  /**
   * Create a MonitorResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MonitorResource>;

  /**
   * Update a MonitorResource
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    MonitorResource,
    PatchModel = MonitorResourceUpdate
  >;

  /**
   * Delete a MonitorResource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    MonitorResource,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List MonitorResource resources by resource group
   */
  listByResourceGroup is ArmResourceListByParent<MonitorResource>;

  /**
   * List all MonitorResource by subscriptionId
   */
  listBySubscriptionId is ArmListBySubscription<MonitorResource>;

  /**
   * List the resources currently being monitored by the Dynatrace monitor resource.
   */
  @list
  listMonitoredResources is ArmResourceActionSync<
    MonitorResource,
    LogStatusRequest,
    ArmResponse<MonitoredResourceListResponse>,
    OptionalRequestBody = true
  >;

  /**
   * Returns the payload that needs to be passed in the request body for installing Dynatrace agent on a VM.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  getVMHostPayload is ArmResourceActionSync<
    MonitorResource,
    void,
    ArmResponse<VMExtensionPayload>
  >;

  /**
   * Performs Dynatrace agent install/uninstall action through the Azure Dynatrace resource on the provided list of resources.
   */
  manageAgentInstallation is ArmResourceActionSync<
    MonitorResource,
    ManageAgentInstallationRequest,
    NoContentResponse
  >;

  /**
   * List the VM/VMSS resources currently being monitored by the Dynatrace resource.
   */
  @list
  listHosts is ArmResourceActionSync<
    MonitorResource,
    void,
    ArmResponse<VMHostsListResponse>
  >;

  /**
   * Get metric status
   */
  getMetricStatus is ArmResourceActionSync<
    MonitorResource,
    MetricStatusRequest,
    ArmResponse<MetricsStatusResponse>,
    OptionalRequestBody = true
  >;

  /**
   * Gets list of App Services with Dynatrace PaaS OneAgent enabled
   */
  @list
  listAppServices is ArmResourceActionSync<
    MonitorResource,
    void,
    ArmResponse<AppServiceListResponse>
  >;

  /**
   * Upgrades the billing Plan for Dynatrace monitor resource.
   */
  upgradePlan is ArmResourceActionAsyncBase<
    MonitorResource,
    UpgradePlanRequest,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<MonitorResource>
  >;

  /**
   * Gets the SSO configuration details from the partner.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  getSSODetails is ArmResourceActionSync<
    MonitorResource,
    SSODetailsRequest,
    ArmResponse<SSODetailsResponse>,
    OptionalRequestBody = true
  >;

  /**
   * Gets all the Dynatrace environments that a user can link a azure resource to
   */
  @list
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
@@doc(MonitorResources.listMonitoredResources::parameters.body,
  "The details of the log status request."
);
@@doc(MonitorResources.manageAgentInstallation::parameters.body,
  "List of resources and action"
);
@@doc(MonitorResources.getMetricStatus::parameters.body,
  "The details of the metric status request."
);
@@doc(MonitorResources.upgradePlan::parameters.body,
  "The details of the upgrade plan request."
);
@@doc(MonitorResources.getSSODetails::parameters.body,
  "The details of the get sso details request."
);
@@doc(MonitorResources.listLinkableEnvironments::parameters.body,
  "The details of the linkable environment request."
);
