import "@azure-tools/typespec-liftr-base";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-providerhub";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using LiftrBase;
using Azure.Core;

@armProviderNamespace
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@service({
  title: "Commvault.ContentStore",
})
@versioned(Commvault.ContentStore.Versions)
namespace Commvault.ContentStore;

@doc("Supported API versions for the Commvault.ContentStore resource provider.")
enum Versions {
  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v1_preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_preview)
  v1_preview: "2024-10-01-preview",
}
interface Operations extends Azure.ResourceManager.Operations {}

@doc("A Commvault Entity Resource")
model Entity is TrackedResource<EntityProperties> {
  @key("entityName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("entities")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the Entity resource")
  @example("entityName")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

@armResourceOperations
interface Entities {
  get is ArmResourceRead<Entity>;
  create is ArmResourceCreateOrReplaceAsync<Entity>;
  delete is ArmResourceDeleteWithoutOkAsync<Entity>;
  patch is ArmResourcePatchAsync<Entity, EntityProperties>;
  listByResourceGroup is ArmResourceListByParent<Entity>;
  listBySubscription is ArmListBySubscription<Entity>;
}

@doc("Properties specific to Commvault Entity resource")
model EntityProperties is BaseResourceProperties;
