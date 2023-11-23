import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

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
  @doc("Get the properties of a specific monitor resource.")
  get is ArmResourceRead<DatadogMonitorResource>;
  @doc("Create a monitor resource.")
  create is ArmResourceCreateOrUpdateAsync<DatadogMonitorResource>;
  @doc("Update a monitor resource.")
  update is ArmResourcePatchAsync<DatadogMonitorResource, MonitorProperties>;
  @doc("Delete a monitor resource.")
  delete is ArmResourceDeleteAsync<DatadogMonitorResource>;
  @doc("List all monitors under the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<DatadogMonitorResource>;
  @doc("List all monitors under the specified subscription.")
  list is ArmListBySubscription<DatadogMonitorResource>;
  @doc("List the api keys for a given monitor resource.")
  listApiKeys is ArmResourceActionSync<
    DatadogMonitorResource,
    {},
    DatadogApiKeyListResponse
  >;
  @doc("Get the default api key.")
  getDefaultKey is ArmResourceActionSync<
    DatadogMonitorResource,
    {},
    DatadogApiKey
  >;
  @doc("Set the default api key.")
  setDefaultKey is ArmResourceActionSync<
    DatadogMonitorResource,
    DatadogApiKey,
    {}
  >;
  @doc("List the hosts for a given monitor resource.")
  listHosts is ArmResourceActionSync<
    DatadogMonitorResource,
    {},
    DatadogHostListResponse
  >;
  @doc("List all Azure resources associated to the same Datadog organization as the target resource.")
  listLinkedResources is ArmResourceActionSync<
    DatadogMonitorResource,
    {},
    LinkedResourceListResponse
  >;
  @doc("List the resources currently being monitored by the Datadog monitor resource.")
  listMonitoredResources is ArmResourceActionSync<
    DatadogMonitorResource,
    {},
    MonitoredResourceListResponse
  >;
  @doc("Refresh the set password link and return a latest one.")
  refreshSetPasswordLink is ArmResourceActionSync<
    DatadogMonitorResource,
    {},
    DatadogSetPasswordLink
  >;
}
