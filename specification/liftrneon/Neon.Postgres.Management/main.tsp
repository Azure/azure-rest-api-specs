import "./Neon.Postgres.Models/projects.tsp";
import "./Neon.Postgres.Models/branches.tsp";
import "./Neon.Postgres.Models/commons.tsp";
import "./Neon.Postgres.Models/compute.tsp";
import "./Neon.Postgres.Models/databases.tsp";
import "./Neon.Postgres.Models/connection.tsp";
import "./Neon.Postgres.Models/roles.tsp";
import "./Neon.Postgres.Models/endpoints.tsp";
import "./Neon.Postgres.Models/preflight.tsp";
import "./LiftrBase.Data/main.tsp";

import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using LiftrBase.Data;

@armProviderNamespace
@service(#{ title: "Neon.Postgres" })
@versioned(Neon.Postgres.Versions)
@armCommonTypesVersion("v5")
namespace Neon.Postgres;

@doc("Supported API versions for the Neon.Postgres resource provider.")
enum Versions {
  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v1_preview, LiftrBase.Data.Versions.v1_preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_preview)
  @useDependency(LiftrBase.Data.Versions.v1_preview)
  v1_preview: "2024-12-22-preview",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v1_preview, LiftrBase.Data.Versions.v1_preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_preview)
  @useDependency(LiftrBase.Data.Versions.v2_preview)
  v2_preview: "2025-03-01-preview",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v1_preview, LiftrBase.Data.Versions.v1_preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_preview)
  @useDependency(LiftrBase.Data.Versions.v2_preview)
  v2025_03_01: "2025-03-01",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v1_preview, LiftrBase.Data.Versions.v1_preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_preview)
  @useDependency(LiftrBase.Data.Versions.v2_preview)
  v3_preview: "2025-06-23-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Organization Resource by Neon")
model OrganizationResource is TrackedResource<OrganizationProperties> {
  @key("organizationName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("organizations")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the Neon Organizations resource")
  @path
  name: string;
}

@armResourceOperations
interface Organizations {
  get is ArmResourceRead<OrganizationResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OrganizationResource>;
  update is ArmResourcePatchAsync<OrganizationResource, OrganizationProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<OrganizationResource>;
  listByResourceGroup is ArmResourceListByParent<OrganizationResource>;
  listBySubscription is ArmListBySubscription<OrganizationResource>;

  @doc("Action to retrieve the PostgreSQL versions.")
  @added(Neon.Postgres.Versions.v2_preview)
  @autoRoute
  @armResourceAction(OrganizationResource)
  @post
  getPostgresVersions(
    ...ResourceInstanceParameters<PgVersion>,

    @doc("Post Action to retrieve the PostgreSQL versions.")
    @body
    parameters?: PgVersion,
  ): ArmResponse<PgVersionsResult> | ErrorResponse;
}

@armResourceOperations
@added(Neon.Postgres.Versions.v2_preview)
interface Projects {
  get is ArmResourceRead<Project>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Project>;
  delete is ArmResourceDeleteSync<Project>;
  list is ArmResourceListByParent<Project>;

  @doc("Action to retrieve the connection URI for the Neon Database.")
  @autoRoute
  @armResourceAction(ConnectionUriProperties)
  @post
  getConnectionUri(
    ...ResourceInstanceParameters<Project>,

    @doc("Additional parameters for retrieving the database connection URI.")
    @body
    connectionUriParameters: ConnectionUriProperties,
  ): ArmResponse<ConnectionUriProperties> | ErrorResponse;
}

@armResourceOperations
@added(Neon.Postgres.Versions.v2_preview)
interface Branches {
  get is ArmResourceRead<Branch>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Branch>;
  delete is ArmResourceDeleteSync<Branch>;
  list is ArmResourceListByParent<Branch>;

  @added(Neon.Postgres.Versions.v3_preview)
  @doc("Action to validate preflight checks.")
  @autoRoute
  @armResourceAction(PreflightCheckParameters)
  @post
  preflight(
    ...ResourceInstanceParameters<Branch>,

    @doc("Parameters for preflight checks.")
    @body
    parameters: PreflightCheckParameters,
  ): ArmResponse<PreflightCheckResult> | ErrorResponse;
}

@armResourceOperations
@added(Neon.Postgres.Versions.v2_preview)
interface Computes {
  list is ArmResourceListByParent<Compute>;
}

@armResourceOperations
@added(Neon.Postgres.Versions.v2_preview)
interface NeonDatabases {
  @added(Neon.Postgres.Versions.v2_preview)
  list is ArmResourceListByParent<NeonDatabase>;
  @added(Neon.Postgres.Versions.v3_preview)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NeonDatabase>;
  @added(Neon.Postgres.Versions.v3_preview)
  delete is ArmResourceDeleteSync<NeonDatabase>;
}

@armResourceOperations
@added(Neon.Postgres.Versions.v2_preview)
interface NeonRoles {
  @added(Neon.Postgres.Versions.v2_preview)
  list is ArmResourceListByParent<NeonRole>;
  @added(Neon.Postgres.Versions.v3_preview)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NeonRole>;
  @added(Neon.Postgres.Versions.v3_preview)
  delete is ArmResourceDeleteSync<NeonRole>;
}

@armResourceOperations
@added(Neon.Postgres.Versions.v2_preview)
interface Endpoints {
  @added(Neon.Postgres.Versions.v2_preview)
  list is ArmResourceListByParent<Endpoint>;
  @added(Neon.Postgres.Versions.v3_preview)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Endpoint>;
  @added(Neon.Postgres.Versions.v3_preview)
  delete is ArmResourceDeleteSync<Endpoint>;
}
