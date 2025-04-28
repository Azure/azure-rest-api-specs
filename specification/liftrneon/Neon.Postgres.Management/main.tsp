import "./Neon.Postgres.Models/projects.tsp";
import "./Neon.Postgres.Models/branches.tsp";
import "./Neon.Postgres.Models/commons.tsp";
import "./Neon.Postgres.Models/compute.tsp";
import "./Neon.Postgres.Models/databases.tsp";
import "./Neon.Postgres.Models/connection.tsp";
import "./Neon.Postgres.Models/roles.tsp";
import "./Neon.Postgres.Models/endpoints.tsp";
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
    ...ResourceInstanceParameters<Models.PgVersion>,

    @doc("Post Action to retrieve the PostgreSQL versions.")
    @body
    parameters?: Models.PgVersion,
  ): ArmResponse<Models.PgVersionsResult> | ErrorResponse;
}

@armResourceOperations
@added(Neon.Postgres.Versions.v2_preview)
interface Projects {
  get is ArmResourceRead<Models.Project>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Models.Project>;
  update is ArmResourcePatchAsync<Models.Project, Models.ProjectProperties>;
  delete is ArmResourceDeleteSync<Models.Project>;
  list is ArmResourceListByParent<Models.Project>;

  @doc("Action to retrieve the connection URI for the Neon Database.")
  @autoRoute
  @armResourceAction(Models.ConnectionUriProperties)
  @post
  getConnectionUri(
    ...ResourceInstanceParameters<Models.Project>,

    @doc("Additional parameters for retrieving the database connection URI.")
    @body
    connectionUriParameters: Models.ConnectionUriProperties,
  ): ArmResponse<Models.ConnectionUriProperties> | ErrorResponse;
}

@armResourceOperations
@added(Neon.Postgres.Versions.v2_preview)
interface Branches {
  get is ArmResourceRead<Models.Branch>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Models.Branch>;
  update is ArmResourcePatchAsync<Models.Branch, Models.BranchProperties>;
  delete is ArmResourceDeleteSync<Models.Branch>;
  list is ArmResourceListByParent<Models.Branch>;
}

@armResourceOperations
@added(Neon.Postgres.Versions.v2_preview)
interface Computes {
  get is ArmResourceRead<Models.Compute>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Models.Compute>;
  update is ArmResourcePatchAsync<Models.Compute, Models.ComputeProperties>;
  delete is ArmResourceDeleteSync<Models.Compute>;
  list is ArmResourceListByParent<Models.Compute>;
}

@armResourceOperations
@added(Neon.Postgres.Versions.v2_preview)
interface NeonDatabases {
  get is ArmResourceRead<Models.NeonDatabase>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Models.NeonDatabase>;
  update is ArmResourcePatchAsync<
    Models.NeonDatabase,
    Models.NeonDatabaseProperties
  >;
  delete is ArmResourceDeleteSync<Models.NeonDatabase>;
  list is ArmResourceListByParent<Models.NeonDatabase>;
}

@armResourceOperations
@added(Neon.Postgres.Versions.v2_preview)
interface NeonRoles {
  get is ArmResourceRead<Models.NeonRole>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Models.NeonRole>;
  update is ArmResourcePatchAsync<Models.NeonRole, Models.NeonRoleProperties>;
  delete is ArmResourceDeleteSync<Models.NeonRole>;
  list is ArmResourceListByParent<Models.NeonRole>;
}

@armResourceOperations
@added(Neon.Postgres.Versions.v2_preview)
interface Endpoints {
  get is ArmResourceRead<Models.Endpoint>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Models.Endpoint>;
  update is ArmResourcePatchAsync<Models.Endpoint, Models.EndpointProperties>;
  delete is ArmResourceDeleteSync<Models.Endpoint>;
  list is ArmResourceListByParent<Models.Endpoint>;
}
