import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.WorkloadMonitor;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * One of health states - healthy, critical, warning, unknown, none, disabled.
 */
enum HealthState {
  Healthy,
  Critical,
  Warning,
  Unknown,
  Disabled,
  None,
}

/**
 * Error info.
 */
model ErrorResponseError {
  /**
   * Service-defined error code. This code serves as a sub-status for the HTTP error code specified in the response.
   */
  code?: string;

  /**
   * Human-readable representation of the error.
   */
  message?: string;

  /**
   * Error details.
   */
  details?: ErrorDetails[];
}

/**
 * Error details
 */
model ErrorDetails {
  /**
   * Error code identifying the specific error.
   */
  code?: string;

  /**
   * A human-readable error message.
   */
  message?: string;
}

/**
 * Properties of the monitor.
 */
model HealthMonitorProperties {
  /**
   * Human-readable name of the monitor.
   */
  monitorName?: string;

  /**
   * Type of the monitor.
   */
  monitorType?: string;

  /**
   * Dynamic monitored object of the monitor.
   */
  monitoredObject?: string;

  /**
   * Name of the parent monitor.
   */
  parentMonitorName?: string;

  /**
   * Previous health state of the monitor.
   */
  @visibility("read")
  previousMonitorState?: HealthState;

  /**
   * Current health state of the monitor.
   */
  @visibility("read")
  currentMonitorState?: HealthState;

  /**
   * Timestamp of the monitor's last health evaluation.
   */
  evaluationTimestamp?: string;

  /**
   * Timestamp of the monitor's last health state change.
   */
  currentStateFirstObservedTimestamp?: string;

  /**
   * Timestamp of the monitor's last reported health state.
   */
  lastReportedTimestamp?: string;

  /**
   * Evidence validating the monitor's current health state.
   */
  evidence?: Record<unknown>;

  /**
   * The configuration settings at the time of the monitor's health evaluation.
   */
  monitorConfiguration?: Record<unknown>;
}

/**
 * The resource model definition for the ARM proxy resource, 'microsoft.workloadmonitor/monitors'.
 */
model Resource {
  /**
   * The resource Id.
   */
  @visibility("read")
  id?: string;

  /**
   * The resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * The resource type.
   */
  @visibility("read")
  type?: string;
}

/**
 * Properties of the monitor.
 */
model HealthMonitorStateChangeProperties {
  /**
   * Human-readable name of the monitor.
   */
  monitorName?: string;

  /**
   * Type of the monitor.
   */
  monitorType?: string;

  /**
   * Dynamic monitored object of the monitor.
   */
  monitoredObject?: string;

  /**
   * Timestamp of the monitor's last health evaluation.
   */
  evaluationTimestamp?: string;

  /**
   * Timestamp of the monitor's last health state change.
   */
  currentStateFirstObservedTimestamp?: string;

  /**
   * Previous health state of the monitor.
   */
  @visibility("read")
  previousMonitorState?: HealthState;

  /**
   * Current health state of the monitor.
   */
  @visibility("read")
  currentMonitorState?: HealthState;

  /**
   * Evidence validating the monitor's current health state.
   */
  evidence?: Record<unknown>;

  /**
   * The configuration settings at the time of the monitor's health evaluation.
   */
  monitorConfiguration?: Record<unknown>;
}
