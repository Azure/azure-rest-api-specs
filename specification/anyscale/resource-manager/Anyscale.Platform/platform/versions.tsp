import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Anyscale.Platform;

/** The available API versions. */
enum Versions {
  /** The 2026-09-01 API version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-common-types-version" "Preserve the existing v5 common-types contract pending a separately reviewed upgrade."
  v2026_09_01: "2026-09-01",
}
