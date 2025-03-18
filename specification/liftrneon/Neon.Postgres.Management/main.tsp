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
  v1_preview: "2024-08-01-preview",
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
}
