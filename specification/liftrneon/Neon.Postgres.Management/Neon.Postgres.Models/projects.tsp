import "./commons.tsp"; // Import common types
import "./endpoints.tsp"; // Import EndpointProperties type

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using LiftrBase.Data;

namespace Neon.Postgres.Models;

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

  @doc("The Branch properties of the project. This is optional")
  branch?: BranchProperties;

  @doc("Roles associated with the project")
  @Azure.ResourceManager.identifiers(#[])
  roles?: NeonRoleProperties[];

  @doc("Neon Databases associated with the project")
  @Azure.ResourceManager.identifiers(#[])
  databases?: NeonDatabaseProperties[];

  @doc("Endpoints associated with the project")
  @Azure.ResourceManager.identifiers(#[])
  endpoints?: EndpointProperties[];
}
