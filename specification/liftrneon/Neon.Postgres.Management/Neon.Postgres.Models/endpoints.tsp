import "./commons.tsp"; // Import common types

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Neon.Postgres;

@doc("The Neon compute endpoint resource type.")
@added(Neon.Postgres.Versions.v2_preview)
@parentResource(Branch)
model Endpoint is ProxyResource<EndpointProperties> {
  ...ResourceNameParameter<
    Resource = Endpoint,
    KeyName = "endpointName",
    SegmentName = "endpoints",
    NamePattern = "^\\S.{0,62}\\S$|^\\S$"
  >;
}

@doc("Properties specific to Endpoints")
@added(Neon.Postgres.Versions.v2_preview)
model EndpointProperties {
  ...BaseEntity;

  @doc("The ID of the project this endpoint belongs to")
  projectId?: string;

  @doc("The ID of the branch this endpoint belongs to")
  branchId?: string;

  @doc("The type of the endpoint")
  endpointType?: EndpointType;

  @doc("Unique identifier for the compute endpoint")
  @pattern("^[a-z0-9-]{1,60}$")
  @added(Neon.Postgres.Versions.v3_preview)
  endpointId?: string;

  @doc("Name of the compute endpoint")
  @pattern("^\\S.{0,62}\\S$|^\\S$")
  @added(Neon.Postgres.Versions.v3_preview)
  computeName?: string;

  @doc("The current status of the compute endpoint")
  @added(Neon.Postgres.Versions.v3_preview)
  @visibility(Lifecycle.Read)
  status?: EndpointStatus;

  @doc("The timestamp when the compute endpoint was last active")
  @added(Neon.Postgres.Versions.v3_preview)
  @visibility(Lifecycle.Read)
  lastActive?: string;

  @doc("The compute units size range for autoscaling (MinCU-MaxCU)")
  @added(Neon.Postgres.Versions.v3_preview)
  size?: AutoscalingSize;
}

@doc("The compute endpoint type. Either read_write or read_only.")
@added(Neon.Postgres.Versions.v2_preview)
union EndpointType {
  string,

  @doc("ReadOnly compute endpoint type")
  ReadOnly: "read_only",

  @doc("ReadWrite compute endpoint type")
  ReadWrite: "read_write",
}

@doc("The current status of the compute endpoint.")
@added(Neon.Postgres.Versions.v3_preview)
union EndpointStatus {
  string,

  @doc("The compute endpoint is currently initializing")
  Init: "init",

  @doc("The compute endpoint is currently active")
  Active: "active",

  @doc("The compute endpoint is currently idle")
  Idle: "idle",
}

@doc("Represents the compute units size range for autoscaling")
@added(Neon.Postgres.Versions.v3_preview)
model AutoscalingSize {
  @doc("The minimum compute units for autoscaling")
  autoscalingLimitMinCu: float32;

  @doc("The maximum compute units for autoscaling")
  autoscalingLimitMaxCu: float32;
}
