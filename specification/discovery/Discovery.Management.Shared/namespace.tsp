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
  /** 2025-07-01-preview version */
  // Can't use CommonTypes v6 because it no longer has MoboBrokerResource
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_07_01_preview: "2025-07-01-preview",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_12_01_preview: "2025-12-01-preview",
}
