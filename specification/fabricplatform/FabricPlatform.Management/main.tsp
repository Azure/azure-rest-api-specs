import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./operation.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.FabricPlatform Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.FabricPlatform management service" })
@versioned(Microsoft.FabricPlatform.Versions)
namespace Microsoft.FabricPlatform;

/** The available API versions. */
enum Versions {
  /** 2025-11-03-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_11_03_preview: "2025-11-03-preview",
}
