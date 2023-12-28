import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NewRelicObservability;
@doc("A Monitor Resource by NewRelic")
model NewRelicMonitorResource is TrackedResource<MonitorProperties> {
  @doc("Name of the Monitors resource")
  @key("monitorName")
  @segment("monitors")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Monitors {
  @doc("Get a NewRelicMonitorResource")
  get is ArmResourceRead<NewRelicMonitorResource>;
  @doc("Create a NewRelicMonitorResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NewRelicMonitorResource>;
  @doc("Update a NewRelicMonitorResource")
  update is ArmCustomPatchSync<
    NewRelicMonitorResource,
    NewRelicMonitorResourceUpdate
  >;
  @doc("Delete a NewRelicMonitorResource")
  delete is ArmResourceDeleteAsync<
    NewRelicMonitorResource,
    {
      ...BaseParameters<NewRelicMonitorResource>;

      @doc("User Email.")
      @query("userEmail")
      userEmail: string;
    }
  >;
  @doc("List NewRelicMonitorResource resources by resource group")
  listByResourceGroup is ArmResourceListByParent<NewRelicMonitorResource>;
  @doc("List NewRelicMonitorResource resources by subscription ID")
  listBySubscription is ArmListBySubscription<NewRelicMonitorResource>;
  @doc("Get metric rules")
  getMetricRules is ArmResourceActionSync<
    NewRelicMonitorResource,
    MetricsRequest,
    MetricRules
  >;
  @doc("Get metric status")
  getMetricStatus is ArmResourceActionSync<
    NewRelicMonitorResource,
    MetricsStatusRequest,
    MetricsStatusResponse
  >;
  @doc("List the app service resources currently being monitored by the NewRelic resource.")
  listAppServices is ArmResourceActionSync<
    NewRelicMonitorResource,
    AppServicesGetRequest,
    AppServicesListResponse
  >;
  @doc("Switches the billing for NewRelic monitor resource.")
  switchBilling is ArmResourceActionSync<
    NewRelicMonitorResource,
    SwitchBillingRequest,
    NewRelicMonitorResource
  >;
  @doc("List the compute vm resources currently being monitored by the NewRelic resource.")
  listHosts is ArmResourceActionSync<
    NewRelicMonitorResource,
    HostsGetRequest,
    VMHostsListResponse
  >;
  @doc("List the resources currently being monitored by the NewRelic monitor resource.")
  listMonitoredResources is ArmResourceActionSync<
    NewRelicMonitorResource,
    void,
    MonitoredResourceListResponse
  >;
  @doc("Returns the payload that needs to be passed in the request body for installing NewRelic agent on a VM.")
  vmHostPayload is ArmResourceActionSync<
    NewRelicMonitorResource,
    void,
    VMExtensionPayload
  >;
}
