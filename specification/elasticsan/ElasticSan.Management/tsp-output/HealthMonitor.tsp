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

namespace Microsoft.WorkloadMonitor;
@doc("Information about the monitor’s current health status.")
model HealthMonitor is ProxyResource<HealthMonitorProperties> {
  @doc("The monitor Id of the virtual machine.")
  @path
  @key("monitorId")
  @segment("monitors")
  name: string;
}

@armResourceOperations
interface HealthMonitors {
  @doc("Get the current health status of a monitor of a virtual machine. Optional parameter: $expand (retrieve the monitor's evidence and configuration).")
  get is ArmResourceRead<
    HealthMonitor,
    {
      ...BaseParameters<HealthMonitor>;

      @doc("Optionally expand the monitor’s evidence and/or configuration. Example: $expand=evidence,configuration.")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Get the current health status of all monitors of a virtual machine. Optional parameters: $expand (retrieve the monitor's evidence and configuration) and $filter (filter by monitor name).")
  list is ArmResourceListByParent<
    HealthMonitor,
    {
      ...BaseParameters<HealthMonitor>;

      @doc("Optionally filter by monitor name. Example: $filter=monitorName eq 'logical-disks|C:|disk-free-space-mb.'")
      @query("$filter")
      $filter?: string;

      @doc("Optionally expand the monitor’s evidence and/or configuration. Example: $expand=evidence,configuration.")
      @query("$expand")
      $expand?: string;
    }
  >;
}
