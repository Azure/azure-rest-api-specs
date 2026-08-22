import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./cloudValidation.tsp";
import "./validationExecutionPlan.tsp";
import "./validationExecutionPlanRun.tsp";
import "./validationTestRun.tsp";
import "./validationTestCatalog.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.PlatformValidation Resource Provider management API. */
@armProviderNamespace("Microsoft.PlatformValidation")
@service(#{ title: "Microsoft.PlatformValidation management service" })
@versioned(global.Microsoft.PlatformValidation.Versions)
namespace Microsoft.PlatformValidation;

/** The available API versions. */
enum Versions {
  /** 2026-07-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @Azure.Core.previewVersion
  v2026_07_01_preview: "2026-07-01-preview",
}
