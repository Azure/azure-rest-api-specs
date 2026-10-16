import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models/ProbingGatewayModels.tsp";
import "./interfaces/ProbingGateway.tsp";

using Versioning;
using Azure.ResourceManager;

/** Microsoft.Network Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Azure Probing Gateway Service" })
@versioned(Microsoft.Network.Versions)
namespace Microsoft.Network;

/** The available API versions. */
enum Versions {
  /** 2026-02-09-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_02_09_preview: "2026-02-09-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
