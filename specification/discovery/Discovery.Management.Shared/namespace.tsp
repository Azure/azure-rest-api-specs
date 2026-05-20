import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.Discovery Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.Discovery management service" })
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

/** The available API versions. */
enum Versions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2026_02_01_preview: "2026-02-01-preview",
}
