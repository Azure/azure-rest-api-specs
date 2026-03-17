import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./cloudValidation.tsp";
import "./validationExecutionPlan.tsp";
import "./validationExecutionPlanRun.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.Validate Resource Provider management API. */
@armProviderNamespace("Microsoft.Validate")
@service(#{ title: "Microsoft.Validate management service" })
@versioned(Microsoft.Validate.Versions)
namespace Microsoft.Validate;

/** The available API versions. */
enum Versions {
  /** 2025-10-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_10_01_preview: "2025-10-01-preview",

  /** 2026-01-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_01_01_preview: "2026-01-01-preview",

  /** 2026-02-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_02_01_preview: "2026-02-01-preview",

  /** 2026-03-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_03_01_preview: "2026-03-01-preview",
}
