import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./operations.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.AdvisorResilience Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.AdvisorResilience management service" })
@versioned(Microsoft.AdvisorResilience.Versions)
namespace Microsoft.AdvisorResilience;

/** The available API version(s). */
enum Versions {
  /** 2024-07-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_07_01_preview: "2024-07-01-preview",
}
