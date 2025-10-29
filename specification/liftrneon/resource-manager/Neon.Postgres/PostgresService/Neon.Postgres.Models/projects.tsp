import "./commons.tsp"; // Import common types
import "./endpoints.tsp"; // Import EndpointProperties type

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Neon.Postgres;

@doc("The Project resource type.")
@added(Neon.Postgres.Versions.v2_preview)
@parentResource(OrganizationResource)
model Project is ProxyResource<ProjectProperties> {
  ...ResourceNameParameter<
    Resource = Project,
    KeyName = "projectName",
    SegmentName = "projects",
    NamePattern = "^\\S.{0,62}\\S$|^\\S$"
  >;
}

@doc("Default Endpoint Settings for the project.")
@added(Neon.Postgres.Versions.v2_preview)
model DefaultEndpointSettings {
  @doc("Minimum compute units for autoscaling.")
  autoscalingLimitMinCu: float32;

  @doc("Maximum compute units for autoscaling.")
  autoscalingLimitMaxCu: float32;
}

@doc("Properties specific to Project")
@added(Neon.Postgres.Versions.v2_preview)
model ProjectProperties {
  ...BaseEntity;

  @doc("Region where the project is created")
  regionId?: string;

  @doc("Data Storage bytes per hour for the project")
  storage?: int64;

  @doc("Postgres version for the project")
  pgVersion?: int32;

  @doc("The retention period for project history in seconds.")
  historyRetention?: int32;

  @doc("Default endpoint settings for the project.")
  defaultEndpointSettings?: DefaultEndpointSettings;

  @doc("The Branch properties of the project. This is optional")
  branch?: BranchProperties;

  @doc("Roles associated with the project")
  @identifiers(#[])
  roles?: NeonRoleProperties[];

  @doc("Neon Databases associated with the project")
  @identifiers(#[])
  databases?: NeonDatabaseProperties[];

  @doc("Endpoints associated with the project")
  @identifiers(#[])
  endpoints?: EndpointProperties[];
}
