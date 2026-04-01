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

/** Microsoft.RpLiteTest4 Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.RpLiteTest4 management service" })
@versioned(Microsoft.RpLiteTest4.Versions)
namespace Microsoft.RpLiteTest4;

/** The available API versions. */
enum Versions {
  /** 2026-03-10-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_03_10_preview: "2026-03-10-preview",
}
