import "@typespec/rest";

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Microsoft.Impact",
})
@versioned(Versions)
namespace Microsoft.Impact;

@doc("API Versions")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("Dec 01, 2023 Preview API Version")
  v2023_12_01_preview: "2023-12-01-preview",
}
