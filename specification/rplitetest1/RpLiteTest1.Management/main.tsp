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

/** Microsoft.RpLiteTest1 Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.RpLiteTest1 management service" })
@versioned(Microsoft.RpLiteTest1.Versions)
namespace Microsoft.RpLiteTest1;

/** The available API versions. */
enum Versions {
  /** 2026-02-09-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_02_09_preview: "2026-02-09-preview",
}
