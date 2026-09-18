import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "Clean Service" })
@versioned(Versions)
namespace Microsoft.CleanService;

enum Versions {
  v2024_01_01: "2024-01-01",
}
