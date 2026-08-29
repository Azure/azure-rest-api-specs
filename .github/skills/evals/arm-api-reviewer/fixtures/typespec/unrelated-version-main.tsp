import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "Handwritten Service" })
@versioned(Versions)
namespace Microsoft.HandwrittenService;

enum Versions {
  v2025_01_01: "2025-01-01",
}
