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

/** Microsoft.SecurityScanningService Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.SecurityScanningService management service" })
@versioned(Microsoft.SecurityScanningService.Versions)
namespace Microsoft.SecurityScanningService;

/** The available API versions. */
enum Versions {
  /** 2026-03-27-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2021_10_01_preview: "2026-03-27-preview",
}
