import "./commons.tsp";

using TypeSpec.Versioning;

namespace Neon.Postgres;

@doc("Entity types allowed for preflight deletion validation.")
@added(Neon.Postgres.Versions.v3_preview)
union EntityType {
  string,

  @doc("Branch entity")
  Branch: "branch",

  @doc("NeonRole entity")
  NeonRole: "neonRole",

  @doc("Database entity")
  NeonDatabase: "neonDatabase",

  @doc("Endpoint entity")
  Endpoint: "endpoint",
}

/**
 * Preflight check parameters for branch and child resources.
 *
 * IMPORTANT: Only one of the property types (branchProperties, roleProperties, databaseProperties,
 * or endpointProperties) should be provided at a time, based on the entityType value:
 * - When entityType is "branch", provide only branchProperties
 * - When entityType is "role", provide only roleProperties
 * - When entityType is "database", provide only databaseProperties
 * - When entityType is "endpoint", provide only endpointProperties
 */
@added(Neon.Postgres.Versions.v3_preview)
model PreflightCheckParameters {
  @doc("Project Id associated with this connection")
  projectId: string;

  @doc("Branch Id associated with this connection")
  branchId: string;

  @doc("Entity type to be validated for deletion.")
  entityType: EntityType;

  @doc("The branch properties - ONLY provided when entityType is 'branch'")
  branchProperties?: BranchProperties;

  @doc("The role properties - ONLY provided when entityType is 'role'")
  roleProperties?: NeonRoleProperties;

  @doc("The database properties - ONLY provided when entityType is 'database'")
  databaseProperties?: NeonDatabaseProperties;

  @doc("The endpoint properties - ONLY provided when entityType is 'endpoint'")
  endpointProperties?: EndpointProperties;
}

@doc("Result of the pre-deletion validation operation.")
@added(Neon.Postgres.Versions.v3_preview)
model PreflightCheckResult {
  @doc("Indicates whether action is allowed.")
  isValid: boolean;

  @doc("Optional message in case action is not allowed.")
  reason?: string;
}
