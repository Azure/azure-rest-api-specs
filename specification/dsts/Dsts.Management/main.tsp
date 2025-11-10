import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./operation.tsp";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Dsts Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.Dsts management service" })
@versioned(Microsoft.Dsts.Versions)
namespace Microsoft.Dsts;

/** The available API versions. */
enum Versions {
  /** 2025-04-30-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_04_30_preview: "2025-04-30-preview",

  /** 2025-05-23-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_05_23_preview: "2025-05-23-preview",

  /** 2025-06-10-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_06_10_preview: "2025-06-10-preview",
}
