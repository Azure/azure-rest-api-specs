import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Dynatrace.Observability;
/**
 * Dynatrace Monitor Resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(MonitorProperties)
@includeInapplicableMetadataInPayload(false)
model MonitorResource extends TrackedResourceBase {
  /**
   * Monitor resource name
   */
  @path
  @key("monitorName")
  @segment("monitors")
  name: string;

  /**
   * The resource-specific properties for this resource.
   */
  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties: MonitorProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface MonitorResources {
  /**
   * Get a MonitorResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_Get")
  get is ArmResourceRead<MonitorResource>;

  /**
   * Create a MonitorResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    MonitorResource,
    BaseParameters<MonitorResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a MonitorResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Monitors_Update")
  update is ArmCustomPatchSync<MonitorResource, MonitorResourceUpdate>;

  /**
   * Delete a MonitorResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_Delete")
  delete is ArmResourceDeleteAsync<
    MonitorResource,
    BaseParameters<MonitorResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * List MonitorResource resources by resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<MonitorResource>;

  /**
   * List all MonitorResource by subscriptionId
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListBySubscriptionId")
  listBySubscriptionId is ArmListBySubscription<MonitorResource>;

  /**
   * Gets the user account credentials for a Monitor
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_GetAccountCredentials")
  getAccountCredentials is ArmResourceActionSync<
    MonitorResource,
    void,
    AccountInfoSecure
  >;

  /**
   * List the resources currently being monitored by the Dynatrace monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListMonitoredResources")
  listMonitoredResources is ArmResourceActionSync<
    MonitorResource,
    void,
    MonitoredResourceListResponse
  >;

  /**
   * Returns the payload that needs to be passed in the request body for installing Dynatrace agent on a VM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_GetVMHostPayload")
  getVMHostPayload is ArmResourceActionSync<
    MonitorResource,
    void,
    VMExtensionPayload
  >;

  /**
   * List the compute resources currently being monitored by the Dynatrace resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListHosts")
  listHosts is ArmResourceActionSync<
    MonitorResource,
    void,
    VMHostsListResponse
  >;

  /**
   * Gets list of App Services with Dynatrace PaaS OneAgent enabled
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListAppServices")
  listAppServices is ArmResourceActionSync<
    MonitorResource,
    void,
    AppServiceListResponse
  >;

  /**
   * Gets the SSO configuration details from the partner.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_GetSSODetails")
  getSSODetails is ArmResourceActionSync<
    MonitorResource,
    SSODetailsRequest,
    SSODetailsResponse
  >;

  /**
   * Gets all the Dynatrace environments that a user can link a azure resource to
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListLinkableEnvironments")
  listLinkableEnvironments is ArmResourceActionSync<
    MonitorResource,
    LinkableEnvironmentRequest,
    LinkableEnvironmentListResponse
  >;
}

@@projectedName(MonitorResources.update::parameters.properties,
  "json",
  "resource"
);
@@extension(MonitorResources.update::parameters.properties,
  "x-ms-client-name",
  "resource"
);
@@projectedName(MonitorResources.getSSODetails::parameters.body,
  "json",
  "request"
);
@@extension(MonitorResources.getSSODetails::parameters.body,
  "x-ms-client-name",
  "request"
);
@@doc(MonitorResources.getSSODetails::parameters.body,
  "The details of the get sso details request."
);
@@projectedName(MonitorResources.listLinkableEnvironments::parameters.body,
  "json",
  "request"
);
@@extension(MonitorResources.listLinkableEnvironments::parameters.body,
  "x-ms-client-name",
  "request"
);
@@doc(MonitorResources.listLinkableEnvironments::parameters.body,
  "The details of the linkable environment request."
);
