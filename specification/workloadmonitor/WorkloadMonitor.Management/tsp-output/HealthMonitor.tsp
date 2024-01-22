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
/**
 * Information about the monitor’s current health status.
 */
model HealthMonitor is ProxyResource<HealthMonitorProperties> {
  /**
   * The monitor Id of the virtual machine.
   */
  @path
  @key("monitorId")
  @segment("monitors")
  name: string;
}

@armResourceOperations
interface HealthMonitors {
  /**
   * Get the current health status of a monitor of a virtual machine. Optional parameter: $expand (retrieve the monitor's evidence and configuration).
   */
  get is ArmResourceRead<
    HealthMonitor,
    {
      ...BaseParameters<HealthMonitor>;

      /**
       * Optionally expand the monitor’s evidence and/or configuration. Example: $expand=evidence,configuration.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Get the current health status of all monitors of a virtual machine. Optional parameters: $expand (retrieve the monitor's evidence and configuration) and $filter (filter by monitor name).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("HealthMonitors_List")
  list is ArmResourceListByParent<
    HealthMonitor,
    {
      ...BaseParameters<HealthMonitor>;

      /**
       * Optionally filter by monitor name. Example: $filter=monitorName eq 'logical-disks|C:|disk-free-space-mb.'
       */
      @query("$filter")
      $filter?: string;

      /**
       * Optionally expand the monitor’s evidence and/or configuration. Example: $expand=evidence,configuration.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
}
