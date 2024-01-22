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

namespace Microsoft.Datadog;

model DatadogMonitorResource is TrackedResource<MonitorProperties> {
  /**
   * Monitor resource name
   */
  @path
  @key("monitorName")
  @segment("monitors")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface DatadogMonitorResources {
  /**
   * Get the properties of a specific monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_Get")
  get is ArmResourceRead<DatadogMonitorResource>;

  /**
   * Create a monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_Create")
  create is ArmResourceCreateOrReplaceAsync<
    DatadogMonitorResource,
    BaseParameters<DatadogMonitorResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Monitors_Update")
  update is ArmCustomPatchAsync<
    DatadogMonitorResource,
    DatadogMonitorResourceUpdateParameters
  >;

  /**
   * Delete a monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_Delete")
  delete is ArmResourceDeleteAsync<DatadogMonitorResource>;

  /**
   * List all monitors under the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<DatadogMonitorResource>;

  /**
   * List all monitors under the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_List")
  list is ArmListBySubscription<DatadogMonitorResource>;

  /**
   * List the api keys for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListApiKeys")
  listApiKeys is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    DatadogApiKeyListResponse
  >;

  /**
   * Get the default api key.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_GetDefaultKey")
  getDefaultKey is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    DatadogApiKey
  >;

  /**
   * Set the default api key.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_SetDefaultKey")
  setDefaultKey is ArmResourceActionSync<
    DatadogMonitorResource,
    DatadogApiKey,
    void
  >;

  /**
   * List the hosts for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListHosts")
  listHosts is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    DatadogHostListResponse
  >;

  /**
   * List all Azure resources associated to the same Datadog organization as the target resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListLinkedResources")
  listLinkedResources is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    LinkedResourceListResponse
  >;

  /**
   * List the resources currently being monitored by the Datadog monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListMonitoredResources")
  listMonitoredResources is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    MonitoredResourceListResponse
  >;

  /**
   * Refresh the set password link and return a latest one.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_RefreshSetPasswordLink")
  refreshSetPasswordLink is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    DatadogSetPasswordLink
  >;
}

@@projectedName(DatadogMonitorResources.create::parameters.resource,
  "json",
  "body"
);
@@extension(DatadogMonitorResources.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(DatadogMonitorResources.create::parameters.resource, "");
@@projectedName(DatadogMonitorResources.update::parameters.properties,
  "json",
  "body"
);
@@extension(DatadogMonitorResources.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(DatadogMonitorResources.update::parameters.properties, "");
@@doc(DatadogMonitorResources.setDefaultKey::parameters.body, "");
