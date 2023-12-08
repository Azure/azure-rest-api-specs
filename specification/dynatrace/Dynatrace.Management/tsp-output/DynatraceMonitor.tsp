import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Dynatrace;
@doc("Dynatrace Monitor Resource")
model DynatraceMonitor is TrackedResource<MonitorProperties> {
  @doc("Monitor resource name")
  @path
  @key("monitorName")
  @segment("monitors")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface DynatraceMonitors {
  @doc("Get a MonitorResource")
  get is ArmResourceRead<DynatraceMonitor>;
  @doc("Create a MonitorResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DynatraceMonitor>;
  @doc("Update a MonitorResource")
  update is ArmTagsPatchSync<DynatraceMonitor>;
  @doc("Delete a MonitorResource")
  delete is ArmResourceDeleteAsync<DynatraceMonitor>;
  @doc("List MonitorResource resources by resource group")
  listByResourceGroup is ArmResourceListByParent<DynatraceMonitor>;
  @doc("List all MonitorResource by subscriptionId")
  listBySubscriptionId is ArmListBySubscription<DynatraceMonitor>;
  @doc("Gets the user account credentials for a Monitor")
  getAccountCredentials is ArmResourceActionSync<
    DynatraceMonitor,
    {},
    AccountInfoSecure
  >;
  @doc("List the resources currently being monitored by the Dynatrace monitor resource.")
  listMonitoredResources is ArmResourceActionSync<
    DynatraceMonitor,
    {},
    MonitoredResourceListResponse
  >;
  @doc("Returns the payload that needs to be passed in the request body for installing Dynatrace agent on a VM.")
  getVMHostPayload is ArmResourceActionSync<
    DynatraceMonitor,
    {},
    VMExtensionPayload
  >;
  @doc("List the compute resources currently being monitored by the Dynatrace resource.")
  listHosts is ArmResourceActionSync<DynatraceMonitor, {}, VMHostsListResponse>;
  @doc("Gets list of App Services with Dynatrace PaaS OneAgent enabled")
  listAppServices is ArmResourceActionSync<
    DynatraceMonitor,
    {},
    AppServiceListResponse
  >;
  @doc("Gets the SSO configuration details from the partner.")
  getSSODetails is ArmResourceActionSync<
    DynatraceMonitor,
    SSODetailsRequest,
    SSODetailsResponse
  >;
  @doc("Gets all the Dynatrace environments that a user can link a azure resource to")
  listLinkableEnvironments is ArmResourceActionSync<
    DynatraceMonitor,
    LinkableEnvironmentRequest,
    LinkableEnvironmentListResponse
  >;
}
