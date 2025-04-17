import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.LoadTestService")
@service(#{ title: "Operations API" })
@doc("Operations API is an ARM RPC requirement.")
@versioned(Versions)
namespace Operations.Management;

@doc("Operations API Versions.")
enum Versions {
  /** 2025-07-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_07_01_preview: "2025-07-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
