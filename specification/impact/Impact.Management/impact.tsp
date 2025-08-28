import "@typespec/rest";

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.Impact" })
@versioned(Versions)
@armCommonTypesVersion(CommonTypes.Versions.v3)
namespace Microsoft.Impact;

@doc("API Versions")
enum Versions {
  @doc("May 01, 2024 Preview API Version")
  v2024_05_01_preview: "2024-05-01-preview",
}
