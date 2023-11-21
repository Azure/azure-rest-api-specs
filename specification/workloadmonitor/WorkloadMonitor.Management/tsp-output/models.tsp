import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace WorkloadMonitorAPI;

enum HealthState {
  Healthy,
  Critical,
  Warning,
  Unknown,
  Disabled,
  None,
}

@doc("List of available REST API operations")
model OperationList is Azure.Core.Page<Operation>;

@doc("Operation supported by the resource provider.")
model Operation {
  @doc("The name of the operation being performed on this particular object.")
  name: string;

  @doc("The localized display information for this particular operation or action.")
  display: OperationDisplay;

  @doc("The intended executor of the operation.")
  origin: string;
}

@doc("The localized display information for this particular operation or action.")
model OperationDisplay {
  @doc("Operation resource provider name.")
  provider: string;

  @doc("Resource on which the operation is performed.")
  resource: string;

  @doc("Human-readable, friendly name for the operation.")
  operation: string;

  @doc("Operation description.")
  description: string;
}

@doc("Error response")
@error
model ErrorResponse {
  @doc("Error info.")
  error?: ErrorResponseError;
}

@doc("Error info.")
model ErrorResponseError {
  @doc("""
Service-defined error code. This code serves as a sub-status for the HTTP error
code specified in the response.
""")
  code?: string;

  @doc("Human-readable representation of the error.")
  message?: string;

  @doc("Error details.")
  details?: ErrorDetails[];
}

@doc("Error details")
model ErrorDetails {
  @doc("Error code identifying the specific error.")
  code?: string;

  @doc("A human-readable error message.")
  message?: string;
}

@doc("Information about the current health statuses of the monitors.")
model HealthMonitorList is Azure.Core.Page<HealthMonitor>;

@doc("Information about the monitor’s current health status.")
model HealthMonitor {
  ...Resource;

  @doc("Properties of the monitor's health status.")
  properties?: HealthMonitorProperties;
}

@doc("Properties of the monitor.")
model HealthMonitorProperties {
  @doc("Human-readable name of the monitor.")
  monitorName?: string;

  @doc("Type of the monitor.")
  monitorType?: string;

  @doc("Dynamic monitored object of the monitor.")
  monitoredObject?: string;

  @doc("Name of the parent monitor.")
  parentMonitorName?: string;

  @doc("Previous health state of the monitor.")
  @visibility("read")
  previousMonitorState?: HealthState;

  @doc("Current health state of the monitor.")
  @visibility("read")
  currentMonitorState?: HealthState;

  @doc("Timestamp of the monitor's last health evaluation.")
  evaluationTimestamp?: string;

  @doc("Timestamp of the monitor's last health state change.")
  currentStateFirstObservedTimestamp?: string;

  @doc("Timestamp of the monitor's last reported health state.")
  lastReportedTimestamp?: string;

  @doc("Evidence validating the monitor's current health state.")
  evidence?: unknown;

  @doc("The configuration settings at the time of the monitor's health evaluation.")
  monitorConfiguration?: unknown;
}

@doc("""
The resource model definition for the ARM proxy resource,
'microsoft.workloadmonitor/monitors'.
""")
model Resource {
  @doc("The resource Id.")
  @visibility("read")
  id?: string;

  @doc("The resource name.")
  @visibility("read")
  name?: string;

  @doc("The resource type.")
  @visibility("read")
  type?: string;
}

@doc("""
Information about the health state changes of the monitor within the provided
time window.
""")
model HealthMonitorStateChangeList is Azure.Core.Page<HealthMonitorStateChange>;

@doc("Information about the monitor’s health state change at the provided timestamp.")
model HealthMonitorStateChange {
  ...Resource;

  @doc("Properties of the monitor's state change.")
  properties?: HealthMonitorStateChangeProperties;
}

@doc("Properties of the monitor.")
model HealthMonitorStateChangeProperties {
  @doc("Human-readable name of the monitor.")
  monitorName?: string;

  @doc("Type of the monitor.")
  monitorType?: string;

  @doc("Dynamic monitored object of the monitor.")
  monitoredObject?: string;

  @doc("Timestamp of the monitor's last health evaluation.")
  evaluationTimestamp?: string;

  @doc("Timestamp of the monitor's last health state change.")
  currentStateFirstObservedTimestamp?: string;

  @doc("Previous health state of the monitor.")
  @visibility("read")
  previousMonitorState?: HealthState;

  @doc("Current health state of the monitor.")
  @visibility("read")
  currentMonitorState?: HealthState;

  @doc("Evidence validating the monitor's current health state.")
  evidence?: unknown;

  @doc("The configuration settings at the time of the monitor's health evaluation.")
  monitorConfiguration?: unknown;
}
