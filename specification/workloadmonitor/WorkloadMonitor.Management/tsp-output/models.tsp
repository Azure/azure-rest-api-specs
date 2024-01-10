import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.WorkloadMonitor;

interface Operations extends Azure.ResourceManager.Operations {}

enum HealthState {
  Healthy,
  Critical,
  Warning,
  Unknown,
  Disabled,
  None,
}

@doc("Error info.")
model ErrorResponseError {
  @doc("Service-defined error code. This code serves as a sub-status for the HTTP error code specified in the response.")
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
  evidence?: Record<unknown>;

  @doc("The configuration settings at the time of the monitor's health evaluation.")
  monitorConfiguration?: Record<unknown>;
}

@doc("The resource model definition for the ARM proxy resource, 'microsoft.workloadmonitor/monitors'.")
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
  evidence?: Record<unknown>;

  @doc("The configuration settings at the time of the monitor's health evaluation.")
  monitorConfiguration?: Record<unknown>;
}
