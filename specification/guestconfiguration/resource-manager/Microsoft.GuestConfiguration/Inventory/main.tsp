import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./resources.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "GuestConfiguration" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.GuestConfiguration;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-03-19-preview API version.
   */
  @Azure.Core.previewVersion
  v2026_03_19_preview: "2026-03-19-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
