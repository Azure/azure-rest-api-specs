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

/** Microsoft.RpLiteTest Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.RpLiteTest management service" })
@versioned(Microsoft.RpLiteTest.Versions)
namespace Microsoft.RpLiteTest;

/** The available API versions. */
enum Versions {
  /** 2026-01-29-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_01_29_preview: "2026-01-29-preview",
}
