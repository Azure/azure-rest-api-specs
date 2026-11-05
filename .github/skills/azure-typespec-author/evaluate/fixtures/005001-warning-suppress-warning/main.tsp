import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./stubs.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "CognitiveServicesManagementClient" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.CognitiveServices;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2025-10-01-preview API version.
   */
  v2025_10_01_preview: "2025-10-01-preview",

  /**
   * The 2025-12-01 API version.
   */
  v2025_12_01: "2025-12-01",

  /**
   * The 2026-01-15-preview API version.
   */
  v2026_01_15_preview: "2026-01-15-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
