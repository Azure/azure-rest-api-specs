import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./routes.tsp";
import "./autoactionroutes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.ComputeSchedule" })
@doc("Microsoft.ComputeSchedule Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.ComputeSchedule;

/** ComputeSchedule API versions */
enum Versions {
  /** 2024-06-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2024-06-01-preview`,

  /** 2024-08-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2024-08-01-preview`,

  /** 2025-04-15-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2025-04-15-preview`,

  /** 2026-03-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  `2026-03-01-preview`,
}
