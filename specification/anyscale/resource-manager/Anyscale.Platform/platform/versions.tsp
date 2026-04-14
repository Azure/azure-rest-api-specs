import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Anyscale.Platform;

/** The available API versions. */
enum Versions {
  /** The 2023-04-01-preview API version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2023_04_01_preview: "2023-04-01-preview",

  /** The 2026-02-01-preview API version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2026_02_01_preview: "2026-02-01-preview",
}
