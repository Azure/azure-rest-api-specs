import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./identitycontroller.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.NexusIdentity Resource Provider management API. */
@doc("Microsoft.NexusIdentity Resource Provider management API.")
@armProviderNamespace("Microsoft.NexusIdentity")
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@service({
  title: "Microsoft.NexusIdentity management service",
})
@versioned(Versions)
namespace Microsoft.NexusIdentity;

@doc("API Versions")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2024-02-15-preview")
  v2024_02_15_preview: "2024-02-15-preview",
}
