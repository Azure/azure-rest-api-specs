import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./LinkedAccount.tsp";
import "./UpdateInstances.tsp";
import "./client.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;

/**
 * Microsoft Device Update resource provider.
 */
@armProviderNamespace
@service(#{
  title: "Device Registry-linked device updating service under Microsoft.DeviceUpdate",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.DeviceUpdate;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-05-01-preview API version.
   */
  v2026_05_01_preview: "2026-05-01-preview",

  /**
   * The 2026-06-01-preview API version.
   */
  v2026_06_01_preview: "2026-06-01-preview",

  /**
   * The 2026-07-02-preview API version.
   */
  v2026_07_02_preview: "2026-07-02-preview",

  /**
   * The 2026-11-02-preview API version.
   */
  @previewVersion
  v2026_11_02_preview: "2026-11-02-preview",
}
