import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./operation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.RpLiteTest3 Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.RpLiteTest3 management service" })
@versioned(Microsoft.RpLiteTest3.Versions)
namespace Microsoft.RpLiteTest3;

/** The available API versions. */
enum Versions {
  /** 2026-03-06-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_03_06_preview: "2026-03-06-preview",
}
