import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Microsoft.MessagingConnectors Resource Provider management API.")
@armProviderNamespace
@service({
  title: "Microsoft.MessagingConnectors management service",
})
@versioned(Versions)
namespace Microsoft.MessagingConnectors;

@doc("Microsoft.MessagingConnectors api versions.")
enum Versions {
  @doc("2024-08-01-preview version")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_05_01_preview: "2024-08-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
