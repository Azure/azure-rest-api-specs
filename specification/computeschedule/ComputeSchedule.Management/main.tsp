import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./routes.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.ComputeSchedule" })
@doc("Microsoft.ComputeSchedule Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.ComputeSchedule;

/** ComputeSchedule API versions */
enum Versions {
  /** 2024-08-15-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  `2024-08-15-preview`,

  /** 2024-10-01 version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  `2024-10-01`,

  /** 2025-05-01 version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  `2025-05-01`,

  //------- Autoaction versions
  /** 2025-04-15-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  `2025-04-15-preview`,

  /** 2026-01-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  `2026-01-01-preview`,
}
