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
