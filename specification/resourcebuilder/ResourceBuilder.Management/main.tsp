import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./workspaces.tsp";
import "./datasets.tsp";
import "./pipelines.tsp";
import "./jobs.tsp";
import "./operation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.ResourceBuilder Resource Provider management API. */
@armProviderNamespace(ProviderName)
@service(#{ title: ProviderName })
@versioned(Versions)
namespace Microsoft.ResourceBuilder;

/** The available API versions. */
enum Versions {
  /** 2024-07-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_07_01_preview: "2024-07-01-preview",
  
  /** 2025-11-04-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_11_04_preview: "2025-11-04-preview",
}

alias ProviderName = "Microsoft.ResourceBuilder";