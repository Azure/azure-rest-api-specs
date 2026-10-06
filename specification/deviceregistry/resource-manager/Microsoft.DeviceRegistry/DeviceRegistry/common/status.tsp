import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./provisioningState.tsp";

using TypeSpec.Versioning;

namespace Microsoft.DeviceRegistry;

@doc("Defines the status config properties.")
@added(Versions.v2025_07_01_preview)
model StatusConfig {
  @doc("A read-only incremental counter indicating the number of times the configuration has been modified from the perspective of the current actual (edge) state of the CRD. Edge would be the only writer of this value and would sync back up to the cloud. In steady state, this should equal version.")
  @visibility(Lifecycle.Read)
  version?: int64;

  @doc("A read-only timestamp indicating the last time the configuration has been modified from the perspective of the current actual (edge) state of the CRD. Edge would be the only writer of this value and would sync back up to the cloud.")
  @visibility(Lifecycle.Read)
  lastTransitionTime?: utcDateTime;

  @doc("Object to transfer and persist errors that originate from the edge.")
  @visibility(Lifecycle.Read)
  error?: StatusError;
}

@doc("Defines the status config error properties.")
@added(Versions.v2025_07_01_preview)
model StatusError is Error;

@doc("Defines the health state of the resource.")
@added(Versions.v2026_04_01)
union HealthStatus {
  @doc("Resource state is unknown.")
  Unknown: "Unknown",

  @doc("Resource is Available and functioning as expected.")
  Available: "Available",

  @doc("Resource health is degraded.")
  Degraded: "Degraded",

  @doc("Resource is not functioning as expected.")
  Unavailable: "Unavailable",

  string,
}

@doc("Represents the health state of a resource.")
@added(Versions.v2026_04_01)
model HealthState {
  @visibility(Lifecycle.Read)
  @doc("The high-level health status of the resource.")
  status?: HealthStatus;

  @doc("The timestamp (RFC3339) when the health status last changed.")
  @visibility(Lifecycle.Read)
  lastTransitionTime?: string;

  @doc("The timestamp (RFC3339) when the health status was last updated, even if the status did not change.")
  @visibility(Lifecycle.Read)
  lastUpdateTime?: string;

  @doc("A human-readable message describing the last transition.")
  @visibility(Lifecycle.Read)
  message?: string;

  @doc("Unique, CamelCase reason code describing the cause of the last health state transition.")
  @visibility(Lifecycle.Read)
  reasonCode?: string;
}
