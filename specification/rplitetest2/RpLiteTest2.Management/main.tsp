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

/** Microsoft.RpLiteTest2 Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.RpLiteTest2 management service" })
@versioned(Microsoft.RpLiteTest2.Versions)
namespace Microsoft.RpLiteTest2;

/** The available API versions. */
enum Versions {
  /** 2026-03-02-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_03_02_preview: "2026-03-02-preview",
}
