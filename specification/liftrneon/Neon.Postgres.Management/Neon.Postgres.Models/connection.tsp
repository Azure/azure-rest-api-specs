import "./commons.tsp"; // Import common types

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using LiftrBase.Data;

namespace Neon.Postgres;

@doc("Connection uri parameters for the associated database")
@added(Neon.Postgres.Versions.v2_preview)
model ConnectionUriProperties {
  @doc("Project Id associated with this connection")
  projectId?: string;

  @doc("Branch Id associated with this connection")
  branchId?: string;

  @doc("Database name associated with this connection")
  databaseName?: string;

  @doc("The role name used for authentication")
  roleName?: string;

  @doc("the endpoint Id with this connection")
  endpointId?: string;

  @doc("Indicates if the connection is pooled")
  isPooled?: boolean;

  @doc("connection uri returned for the database")
  @secret
  @visibility(Lifecycle.Read)
  connectionStringUri?: string;
}
