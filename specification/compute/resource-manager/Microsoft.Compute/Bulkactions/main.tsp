import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./routes.tsp";
import "./vmAttributes.tsp";
import "./launchBulkInstancesOperation.tsp";
import "./client.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Already exist outside this subservice"
@armProviderNamespace
@service(#{ title: "Azure Compute resource management API." })
@versioned(Versions)
namespace Microsoft.Compute;

/** ComputeSchedule API versions */
enum Versions {
  /** 2026-04-06-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  `2026-04-06-preview`,

  /** 2026-06-06 version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  `2026-06-06`,
}
