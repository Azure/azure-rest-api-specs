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
  @doc("Monitor resource name")
  @path
  @key("monitorName")
  @segment("monitors")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface DatadogMonitorResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the properties of a specific monitor resource.")
  @operationId("Monitors_Get")
  get is ArmResourceRead<DatadogMonitorResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a monitor resource.")
  @operationId("Monitors_Create")
  create is ArmResourceCreateOrUpdateAsync<
    DatadogMonitorResource,
    BaseParameters<DatadogMonitorResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a monitor resource.")
  @operationId("Monitors_Update")
  update is ArmCustomPatchAsync<
    DatadogMonitorResource,
    DatadogMonitorResourceUpdateParameters
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a monitor resource.")
  @operationId("Monitors_Delete")
  delete is ArmResourceDeleteAsync<DatadogMonitorResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all monitors under the specified resource group.")
  @operationId("Monitors_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<DatadogMonitorResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all monitors under the specified subscription.")
  @operationId("Monitors_List")
  list is ArmListBySubscription<DatadogMonitorResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the api keys for a given monitor resource.")
  @operationId("Monitors_ListApiKeys")
  listApiKeys is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    DatadogApiKeyListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the default api key.")
  @operationId("Monitors_GetDefaultKey")
  getDefaultKey is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    DatadogApiKey
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Set the default api key.")
  @operationId("Monitors_SetDefaultKey")
  setDefaultKey is ArmResourceActionSync<
    DatadogMonitorResource,
    DatadogApiKey,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the hosts for a given monitor resource.")
  @operationId("Monitors_ListHosts")
  listHosts is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    DatadogHostListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all Azure resources associated to the same Datadog organization as the target resource.")
  @operationId("Monitors_ListLinkedResources")
  listLinkedResources is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    LinkedResourceListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the resources currently being monitored by the Datadog monitor resource.")
  @operationId("Monitors_ListMonitoredResources")
  listMonitoredResources is ArmResourceActionSync<
    DatadogMonitorResource,
    void,
    MonitoredResourceListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Refresh the set password link and return a latest one.")
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
