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

/** Microsoft.SecureExchange Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.SecureExchange management service" })
@versioned(Microsoft.SecureExchange.Versions)
namespace Microsoft.SecureExchange;

/** The available API versions. */
enum Versions {
  /** 2024-07-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2021_10_01_preview: "2024-07-01-preview",
}
