import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "./eapvirtualnetworks.tsp";

using Azure.ResourceManager;
using Versioning;

@armProviderNamespace
@service(#{ title: "Microsoft.Hypernet service" })
@doc("Microsoft.Hypernet Resource Provider API.")
@versioned(Microsoft.Hypernet.Versions)
namespace Microsoft.Hypernet;

@doc("Supported versions.")
enum Versions {
  @doc("API version 2024-12-01-preview")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2024_12_01_preview: "2024-12-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
