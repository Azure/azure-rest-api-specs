import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.PackageRegistry")
@service(#{ title: "Microsoft.PackageRegistry" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.PackageRegistry;

enum Versions {
  `2026-04-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A PackageRegistry resource")
model Registry is TrackedResource<RegistryProperties> {
  @doc("The name of the registry. 3-24 characters of lowercase letters, digits, and hyphens; must start and end with a letter or digit.")
  @pattern("^[a-z0-9]([a-z0-9-]{1,22}[a-z0-9])$")
  @key("registryName")
  @segment("registries")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning: "Provisioning",

  @doc("Update in progress")
  Updating: "Updating",

  @doc("Deletion in progress")
  Deleting: "Deleting",

  @doc("Change accepted for processing")
  Accepted: "Accepted",
}

@doc("Details of the PackageRegistry Registry.")
model RegistryProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The API endpoint for the registry.")
  apiEndpoint?: url;

  @visibility(Lifecycle.Read)
  @doc("The content endpoint for the registry.")
  contentEndpoint?: url;
}

@doc("The properties of a PackageRegistry Registry that can be updated.")
model RegistryUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}

@armResourceOperations(Registry)
interface Registries {
  get is ArmResourceRead<Registry>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Registry>;
  update is ArmCustomPatchSync<Registry, RegistryUpdate>;
  delete is ArmResourceDeleteWithoutOkAsync<Registry>;
  listByResourceGroup is ArmResourceListByParent<Registry>;
  listBySubscription is ArmListBySubscription<Registry>;
}
