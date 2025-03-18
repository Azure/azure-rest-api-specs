import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./azurekeyvaultsecretproviderclass.tsp";
import "./secretsync.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.SecretSyncController")
@service(#{ title: "Microsoft.SecretSyncController" })
@doc("Microsoft.SecretSyncController resource provider.")
@versioned(Microsoft.SecretSyncController.Versions)
namespace Microsoft.SecretSyncController;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Supported API versions for the Microsoft.SecretSyncController resource provider.")
enum Versions {
  // Private preview - 2024-08-21
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("The 2024-08-21-preview API.")
  v2024_08_21_preview: "2024-08-21-preview",
}
