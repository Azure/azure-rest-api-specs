import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HealthMonitor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.WorkloadMonitor;
@doc("Information about the monitor’s health state change at the provided timestamp.")
@parentResource(HealthMonitor)
model HealthMonitorStateChange
  is ProxyResource<HealthMonitorStateChangeProperties> {
  @doc("The timestamp of the state change (unix format).")
  @path
  @key("timestampUnix")
  @segment("history")
  name: string;
}

@armResourceOperations
interface HealthMonitorStateChanges {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the health state change of a monitor of a virtual machine at the provided timestamp. Optional parameter: $expand (retrieve the monitor's evidence and configuration).")
  @operationId("HealthMonitors_GetStateChange")
  getStateChange is ArmResourceRead<
    HealthMonitorStateChange,
    {
      ...BaseParameters<HealthMonitorStateChange>;

      @doc("Optionally expand the monitor’s evidence and/or configuration. Example: $expand=evidence,configuration.")
      @query("$expand")
      $expand?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the health state changes of a monitor of a virtual machine within the provided time window (default is the last 24 hours). Optional parameters: $expand (retrieve the monitor's evidence and configuration) and $filter (filter by heartbeat condition).")
  @operationId("HealthMonitors_ListStateChanges")
  listStateChanges is ArmResourceListByParent<
    HealthMonitorStateChange,
    {
      ...BaseParameters<HealthMonitorStateChange>;

      @doc("Optionally filter by heartbeat condition. Example: $filter=isHeartbeat eq false.")
      @query("$filter")
      $filter?: string;

      @doc("Optionally expand the monitor’s evidence and/or configuration. Example: $expand=evidence,configuration.")
      @query("$expand")
      $expand?: string;

      @doc("The start of the time window.")
      @query("startTimestampUtc")
      startTimestampUtc?: utcDateTime;

      @doc("The end of the time window.")
      @query("endTimestampUtc")
      endTimestampUtc?: utcDateTime;
    }
  >;
}
