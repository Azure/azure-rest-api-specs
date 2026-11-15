import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models.tsp";
import "./routes.tsp";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.AIInfraOptimization Resource Provider management API. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Microsoft.AIInfraOptimization is the resource provider namespace."
@armProviderNamespace
@service(#{ title: "AIInfraOptimization" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.AIInfraOptimization;

/** The available API versions. */
enum Versions {
  /** The 2026-06-01-preview API version. */
  @Azure.Core.previewVersion
  v2026_06_01_preview: "2026-06-01-preview",
}

/** The operations supported by the Microsoft.AIInfraOptimization resource provider. */
interface Operations extends Azure.ResourceManager.Operations {}
