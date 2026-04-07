import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models.tsp";
import "./operations.tsp";
import "./2026-01-01-preview/models.tsp";
import "./2026-01-01-preview/operations.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/**
 * Microsoft.CloudDevicePlatform Resource Provider management API.
 */
@armProviderNamespace
@service(#{ title: "Microsoft.CloudDevicePlatform management service" })
@versioned(Versions)
namespace Microsoft.CloudDevicePlatform;

@doc("Microsoft.CloudDevicePlatform Versions")
enum Versions {
  /** 2024-05-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_05_01_preview: "2024-05-01-preview",

  /** 2024-06-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01_preview: "2024-06-01-preview",

  /** 2026-01-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_01_01_preview: "2026-01-01-preview",
}
