import "./commons.tsp"; // Import common types

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using LiftrBase.Data;

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

  @doc("The current state of the endpoint")
  @added(Neon.Postgres.Versions.v3_preview)
  currentState?: string;

  @doc("The pending state of the endpoint")
  @added(Neon.Postgres.Versions.v3_preview)
  pendingState?: string;

  @doc("The minimum compute units for autoscaling")
  @added(Neon.Postgres.Versions.v3_preview)
  autoscalingLimitMinCu?: int32;

  @doc("The maximum compute units for autoscaling")
  @added(Neon.Postgres.Versions.v3_preview)
  autoscalingLimitMaxCu?: int32;

  @doc("The timestamp when the endpoint was last active")
  @added(Neon.Postgres.Versions.v3_preview)
  lastActive?: string;
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
